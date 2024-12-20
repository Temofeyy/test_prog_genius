/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/logo
  $AssetsImagesLogoGen get logo => const $AssetsImagesLogoGen();

  /// Directory path: assets/images/ships
  $AssetsImagesShipsGen get ships => const $AssetsImagesShipsGen();
}

class $AssetsImagesLogoGen {
  const $AssetsImagesLogoGen();

  /// File path: assets/images/logo/logo.jpg
  AssetGenImage get logo => const AssetGenImage('assets/images/logo/logo.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

class $AssetsImagesShipsGen {
  const $AssetsImagesShipsGen();

  /// File path: assets/images/ships/ship-2-demo.png
  AssetGenImage get ship2Demo =>
      const AssetGenImage('assets/images/ships/ship-2-demo.png');

  /// File path: assets/images/ships/ship-3-demo.png
  AssetGenImage get ship3Demo =>
      const AssetGenImage('assets/images/ships/ship-3-demo.png');

  /// File path: assets/images/ships/ship-4-demo.png
  AssetGenImage get ship4Demo =>
      const AssetGenImage('assets/images/ships/ship-4-demo.png');

  /// File path: assets/images/ships/ship-5-demo.png
  AssetGenImage get ship5Demo =>
      const AssetGenImage('assets/images/ships/ship-5-demo.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [ship2Demo, ship3Demo, ship4Demo, ship5Demo];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
