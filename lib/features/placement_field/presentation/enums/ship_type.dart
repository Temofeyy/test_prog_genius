import '../../../../core/config.dart';
import '../../../../gen/assets.gen.dart';

enum ShipType {
  oneDesk(1, AppConfig.oneDeckShipsCount),
  twoDesk(2, AppConfig.twoDeckShipsCount),
  threeDesk(3, AppConfig.threeDeckShipsCount),
  fourDesk(4, AppConfig.fourDeckShipsCount),
  ;

  String get imagePath => switch (this) {
    ShipType.oneDesk => Assets.images.ships.ship2Demo.path,
    ShipType.twoDesk => Assets.images.ships.ship3Demo.path,
    ShipType.threeDesk => Assets.images.ships.ship4Demo.path,
    ShipType.fourDesk => Assets.images.ships.ship5Demo.path,
  };

  final int length;
  final int countInGame;

  const ShipType(this.length, this.countInGame);
}