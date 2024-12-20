import 'dart:math';

class Ship {
  final int length;
  final int id;
  final String imagePath;

  Ship({
    required this.length,
    required this.id,
    required this.imagePath,
  });
}

class PlacedShip extends Ship {
  PlacedShip({
    required super.id,
    required super.length,
    required super.imagePath,
    required this.rotateDegrees,
    required this.startPoint,
  });

  final int rotateDegrees;
  final Point startPoint;

  PlacedShip copyWith({
    int? rotateDegrees,
    Point? startPoint,
  }) {
    return PlacedShip(
      id: id,
      length: length,
      imagePath: imagePath,
      rotateDegrees: rotateDegrees ?? this.rotateDegrees,
      startPoint: startPoint ?? this.startPoint,
    );
  }
}
