import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'ship_placement_provider.dart';

part 'field_highlighting_provider.g.dart';

@riverpod
class FieldHighlighting extends _$FieldHighlighting {
  @override
  FieldHighlightState build() {
    ref
        .watch(shipPlacementProvider.notifier)
        .onShipPlacementAttempt
        .listen((data) => highlight(data.$1, data.$2));
    return IdleHighlightState();
  }

  /// Emit highlighted cells
  void highlight(List<Point> shipCells, bool canPlace) {
    state = canPlace
        ? ApprovedHighlightState(shipCells)
        : RejectedHighlightState(shipCells);
  }

  /// Removed all highlighted cells
  void removeHighlighting() {
    state = IdleHighlightState();
  }
}

sealed class FieldHighlightState {
  CellHighlightState get cellState;
}

class IdleHighlightState implements FieldHighlightState {
  @override
  CellHighlightState get cellState => CellHighlightState.idle;
}

class ApprovedHighlightState implements FieldHighlightState {
  ApprovedHighlightState(this.highlightedCells);

  final List<Point> highlightedCells;

  @override
  CellHighlightState get cellState => CellHighlightState.availableForPlacement;
}

class RejectedHighlightState implements FieldHighlightState {
  RejectedHighlightState(this.highlightedCells);

  final List<Point> highlightedCells;

  @override
  CellHighlightState get cellState => CellHighlightState.disabledForPlacement;
}

enum CellHighlightState {
  idle,
  availableForPlacement,
  disabledForPlacement,
  ;

  Color get color => switch (this) {
        CellHighlightState.idle => Colors.blue.shade900,
        CellHighlightState.availableForPlacement =>
          Colors.green.withOpacity(0.5),
        CellHighlightState.disabledForPlacement => Colors.red.withOpacity(0.5),
      };
}
