import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ship_drag_info.dart';
import '../providers/field_highlighting_provider.dart';

class FieldCell extends ConsumerWidget {
  const FieldCell({
    super.key,
    this.onWillAcceptWithDetails,
    this.onAcceptWithDetails,
    required this.point,
    required this.onMove,
    required this.onLeave,
  });

  final Point point;
  final bool Function(DragTargetDetails<ShipDragInfo>)? onWillAcceptWithDetails;
  final void Function(DragTargetDetails<ShipDragInfo>)? onAcceptWithDetails;
  final void Function(DragTargetDetails<ShipDragInfo>) onMove;
  final void Function(ShipDragInfo?) onLeave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(fieldHighlightingProvider);
    return DragTarget<ShipDragInfo>(
      onWillAcceptWithDetails: onWillAcceptWithDetails,
      onAcceptWithDetails: onAcceptWithDetails,
      onMove: onMove,
      onLeave: onLeave,
      builder: (context, candidateData, rejectedData) {
        final activeCells = switch (provider) {
          IdleHighlightState() => <Point>[],
          ApprovedHighlightState() => provider.highlightedCells,
          RejectedHighlightState() => provider.highlightedCells,
        };
        final isHighlighted = activeCells.any((cell) => cell == point);

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white54),
            color: isHighlighted ? provider.cellState.color : Colors.blue[900],
          ),
        );
      },
    );
  }
}
