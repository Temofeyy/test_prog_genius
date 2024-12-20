import 'package:test_prog_genius/features/placement_field/presentation/models/ship.dart';


class ShipDragInfo {
  const ShipDragInfo({
    required this.ship,
    required this.tapOffset,
    this.isPlaced = false,
  });

  final Ship ship;
  final int tapOffset;
  final bool isPlaced;
}
