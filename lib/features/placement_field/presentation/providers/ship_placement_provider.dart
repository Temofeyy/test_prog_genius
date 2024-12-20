import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config.dart';

import '../enums/field_cell_state.dart';
import '../enums/ship_type.dart';
import '../models/ship.dart';
import '../models/ship_drag_info.dart';

part 'ship_placement_provider.g.dart';

@riverpod
class ShipPlacement extends _$ShipPlacement {
  late List<List<int>> field;

  final _onShipPlacementAttempt = StreamController<(List<Point>, bool)>();

  Stream<(List<Point>, bool)> get onShipPlacementAttempt =>
      _onShipPlacementAttempt.stream.asBroadcastStream();

  @override
  ShipPlacementState build() {
    _initField();
    final ships = [
      ..._generateShipsByType(ShipType.fourDesk),
      ..._generateShipsByType(ShipType.threeDesk),
      ..._generateShipsByType(ShipType.twoDesk),
      ..._generateShipsByType(ShipType.oneDesk),
    ];
    return ShipPlacementState(placedShips: [], shipToPlace: ships);
  }

  void onShipMovedOverField(Point targetPoint, ShipDragInfo dragInfo) {
    final shipCells = _getDraggedShipCells(targetPoint, dragInfo);
    final canPlace = canPlaceShip(targetPoint, dragInfo);
    _onShipPlacementAttempt.add((shipCells, canPlace));
  }

  bool canPlaceShip(Point targetPoint, ShipDragInfo dragInfo) {
    final cells = _getDraggedShipCells(targetPoint, dragInfo);

    /// Ignore own cells
    if (dragInfo.ship is PlacedShip) {
      final oldCells = _getPlacedShipCells(dragInfo.ship as PlacedShip);
      cells.removeWhere(oldCells.contains);
    }
    return _canPlaceShip(cells);
  }

  void dropShip(Point targetPoint, ShipDragInfo dragInfo) {
    if (state._getPlacementShipsIds.contains(dragInfo.ship.id)) {
      final placedShip = _getShipById(dragInfo.ship.id);
      _removeShip(placedShip);
    }

    _placeShip(targetPoint, dragInfo);
  }

  PlacedShip _getShipById(int id) =>
      state.placedShips.firstWhere((ship) => ship.id == id);

  void _placeShip(Point targetPoint, ShipDragInfo dragInfo) {
    final shipCells = _getDraggedShipCells(targetPoint, dragInfo);

    for (final cell in shipCells) {
      _setFieldCell(
        cell.x.toInt(),
        cell.y.toInt(),
        FieldCellState.occupied.code,
      );
    }

    final newShip = PlacedShip(
      id: dragInfo.ship.id,
      length: dragInfo.ship.length,
      imagePath: dragInfo.ship.imagePath,
      startPoint: shipCells.first,
      rotateDegrees: 0,
    );

    final newState = state.copyWith(
      placedShips: state.placedShips..add(newShip),
      shipToPlace: state.shipToPlace
        ..removeWhere((ship) => ship.id == dragInfo.ship.id),
    );

    state = newState;
  }

  void _removeShip(PlacedShip shipToRemove) {
    _removeShipCells(shipToRemove);

    final newState = state.copyWith(
      placedShips: state.placedShips
        ..removeWhere(
          (ship) => ship.id == shipToRemove.id,
        ),
    );
    state = newState;
  }

  List<Ship> _generateShipsByType(ShipType type) {
    return List.generate(
      type.countInGame,
      (i) => Ship(
        id: type.length * 10 + i,
        length: type.length,
        imagePath: type.imagePath,
      ),
    );
  }

  void _initField() {
    field = List.generate(
      10,
      (_) => List.generate(10, (_) => FieldCellState.empty.code),
    );
  }

  void _removeShipCells(PlacedShip ship) {
    final cells = _getPlacedShipCells(ship);
    for (final cell in cells) {
      _setFieldCell(
        cell.x.toInt(),
        cell.y.toInt(),
        FieldCellState.empty.code,
      );
    }
  }

  List<Point> _getPlacedShipCells(PlacedShip ship) {
    final shipStartPoint = ship.startPoint;
    final cells = <Point>[];

    final degrees = ship.rotateDegrees;

    for (var l = 0; l < ship.length; l++) {
      if (degrees == 0) {
        cells.add(Point(shipStartPoint.x, shipStartPoint.y + l));
      } else if (degrees == 90) {
        cells.add(Point(shipStartPoint.x - l, shipStartPoint.y));
      } else if (degrees == 180) {
        cells.add(Point(shipStartPoint.x, shipStartPoint.y - l));
      } else if (degrees == 270) {
        cells.add(Point(shipStartPoint.x + l, shipStartPoint.y));
      }
    }
    return cells;
  }

  List<Point> _getDraggedShipCells(Point targetPoint, ShipDragInfo dragInfo) {
    final cells = <Point>[];
    for (var i = 0; i < dragInfo.ship.length; i++) {
      cells.add(
        Point(targetPoint.x, targetPoint.y + i - dragInfo.tapOffset),
      );
    }
    return cells;
  }

  bool _canPlaceShip(List<Point> cells) {
    return _isCellsInBounce(cells) && _isCellsFree(cells);
  }

  bool _isCellsInBounce(List<Point> cells) {
    bool isValidCell(Point cell) {
      return cell.x >= 0 &&
          cell.x < AppConfig.fieldSize &&
          cell.y >= 0 &&
          cell.y < AppConfig.fieldSize;
    }

    return cells.every(isValidCell);
  }

  bool _isCellsFree(List<Point> cells) {
    return cells.every(
      (c) =>
          _getFieldCell(c.x.toInt(), c.y.toInt()) == FieldCellState.empty.code,
    );
  }

  int _getFieldCell(int x, int y) => field[y][x];
  int _setFieldCell(int x, int y, int value) => field[y][x] = value;
}

class ShipPlacementState {
  ShipPlacementState({
    required this.placedShips,
    required this.shipToPlace,
  });

  final List<PlacedShip> placedShips;
  final List<Ship> shipToPlace;

  bool get isAllShipsPlaced => shipToPlace.isEmpty;

  List<int> get _getPlacementShipsIds =>
      placedShips.map((ship) => ship.id).toList();

  ShipPlacementState copyWith({
    List<PlacedShip>? placedShips,
    List<Ship>? shipToPlace,
  }) {
    return ShipPlacementState(
      placedShips: placedShips ?? this.placedShips,
      shipToPlace: shipToPlace ?? this.shipToPlace,
    );
  }
}
