import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_prog_genius/features/placement_field/presentation/screens/placement_field_screen.dart';

import '../../../../core/config.dart';
import '../models/ship.dart';
import '../providers/field_highlighting_provider.dart';
import 'draggable_ship.dart';

class FieldShip extends ConsumerWidget {
  const FieldShip({super.key, required this.ship});

  final PlacedShip ship;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldCellSize = PlacementFieldScreen.getCellSize(context);

    final topOffset = MediaQuery.paddingOf(context).top;

    return Positioned(
      top: (ship.startPoint.y + 1) * fieldCellSize + topOffset,
      left: (ship.startPoint.x + 1) * fieldCellSize,
      child: DraggableShip(
        ship: ship,
        rotateDegrees: ship.rotateDegrees,
        isPlaced: true,
        onEndDrag: () {
          ref.read(fieldHighlightingProvider.notifier).removeHighlighting();
        },
      ),
    );
  }
}
