import 'ship.dart';


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
