import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_prog_genius/core/config.dart';
import 'package:test_prog_genius/features/placement_field/presentation/widgets/ship_widget.dart';

import '../models/ship.dart';
import '../models/ship_drag_info.dart';


class DraggableShip extends ConsumerStatefulWidget {
  const DraggableShip({
    super.key,
    required this.ship,
    required this.onEndDrag,
    this.isPlaced = false,
    this.rotateDegrees = 0,
  });

  final Ship ship;
  final int rotateDegrees;
  final bool isPlaced;
  final VoidCallback onEndDrag;

  @override
  ConsumerState<DraggableShip> createState() => _DraggableShipState();
}

class _DraggableShipState extends ConsumerState<DraggableShip> {
  bool _inDrag = false;

  ///This point represents the offset from the first ship cell to the user touch cell
  int _dragPoint = 0;

  ShipDragInfo get data => ShipDragInfo(
        ship: widget.ship,
        tapOffset: _dragPoint,
        isPlaced: widget.isPlaced,
      );

  void onDragStart(DragDownDetails details) {
    _dragPoint = details.localPosition.dy ~/ 40;
    _inDrag = true;
    setState(() {});
  }

  void endDrag() {
    _dragPoint = 0;
    _inDrag = false;
    setState(() {});
    widget.onEndDrag();
  }

  double get angle => widget.rotateDegrees * (pi / 180);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: IgnorePointer(
        ignoring: _inDrag,
        child: GestureDetector(
          onPanDown: onDragStart,
          behavior: HitTestBehavior.opaque,
          child: Draggable<ShipDragInfo>(
            data: data,
            onDraggableCanceled: (_, __) => endDrag(),
            onDragCompleted: () => endDrag(),
            feedback: ShipWidget.ghost(
              ship: widget.ship,
              touchPoint: _dragPoint,
              displayTouchPoint: AppConfig.displayShipTouchPoint,
              rotateQuarter: angle,
            ),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: ShipWidget(
                ship: widget.ship,
                rotateQuarter: angle,
              ),
            ),
            child: ShipWidget(
              ship: widget.ship,
              rotateQuarter: angle,
            ),
          ),
        ),
      ),
    );
  }
}
