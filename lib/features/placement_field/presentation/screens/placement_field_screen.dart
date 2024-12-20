import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config.dart';
import '../../../../shared/widgets/orange_button.dart';

import '../providers/field_highlighting_provider.dart';
import '../providers/ship_placement_provider.dart';
import '../widgets/draggable_ship.dart';
import '../widgets/field_cell.dart';
import '../widgets/field_ship.dart';
import '../widgets/field_symbol.dart';

class PlacementFieldScreen extends ConsumerStatefulWidget {
  static const double fieldPadding = 12;

  static double getCellSize(BuildContext context) {
    final fieldWidth = MediaQuery.sizeOf(context).width - (fieldPadding * 2);

    return fieldWidth / (AppConfig.fieldSize + 1);
  }

  const PlacementFieldScreen({super.key});

  @override
  ConsumerState<PlacementFieldScreen> createState() => _BattleshipGameState();
}

class _BattleshipGameState extends ConsumerState<PlacementFieldScreen> {
  static const gridSize = AppConfig.fieldSize;

  @override
  Widget build(BuildContext context) {
    final placementNotifier = ref.watch(shipPlacementProvider.notifier);
    final placementProvider = ref.watch(shipPlacementProvider);

    final highlightNotifier = ref.watch(fieldHighlightingProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Place the ships'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(PlacementFieldScreen.fieldPadding),
            child: Stack(
              children: [
                FieldSymbols(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSize,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: gridSize * gridSize,
                    itemBuilder: (context, index) {
                      final row = index ~/ gridSize;
                      final col = index % gridSize;
                      final point = Point(col, row);

                      return FieldCell(
                        point: point,
                        onWillAcceptWithDetails: (details) {
                          return placementNotifier.canPlaceShip(
                            point,
                            details.data,
                          );
                        },
                        onAcceptWithDetails: (details) {
                          placementNotifier.dropShip(point, details.data);
                        },
                        onMove: (details) {
                          placementNotifier.onShipMovedOverField(
                            point,
                            details.data,
                          );
                        },
                        onLeave: (_) => highlightNotifier.removeHighlighting(),
                      );
                    },
                  ),
                ),
                ...placementProvider.placedShips
                    .map((ship) => FieldShip(ship: ship)),
              ],
            ),
          ),

          ///
          placementProvider.isAllShipsPlaced
              ? ToBattleButton()
              : AvailableShipsPanel(),
        ],
      ),
    );
  }
}

class AvailableShipsPanel extends ConsumerWidget {
  const AvailableShipsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placementProvider = ref.watch(shipPlacementProvider);

    final highlightNotifier = ref.watch(fieldHighlightingProvider.notifier);

    return Container(
      height: 250,
      padding: const EdgeInsets.all(8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...placementProvider.shipToPlace.map(
            (ship) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: DraggableShip(
                  ship: ship,
                  onEndDrag: highlightNotifier.removeHighlighting,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ToBattleButton extends ConsumerWidget {
  const ToBattleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: OrangeButton(onTap: () {}, label: 'Start'),
    );
  }
}

class FieldSymbols extends StatelessWidget {
  const FieldSymbols({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAlphabet(),
        Row(
          children: [
            _buildNumbers(),
            Expanded(child: child),
          ],
        ),
      ],
    );
  }

  Widget _buildAlphabet() {
    return Row(
      children: List.generate(
        AppConfig.fieldSize + 1,
        (index) => index == 0
            ? FieldSymbol(symbol: '')
            : FieldSymbol(
                symbol: String.fromCharCode(64 + index).toUpperCase(),
              ),
      ),
    );
  }

  Widget _buildNumbers() => Column(
        children: List.generate(
          AppConfig.fieldSize,
          (index) => FieldSymbol(symbol: (index + 1).toString()),
        ),
      );
}
