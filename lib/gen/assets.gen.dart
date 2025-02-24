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

  /// File path: assets/images/banana.png
  AssetGenImage get banana => const AssetGenImage('assets/images/banana.png');

  /// File path: assets/images/bedroom1.jpg
  AssetGenImage get bedroom1 =>
      const AssetGenImage('assets/images/bedroom1.jpg');

  /// File path: assets/images/bedroom10.jpg
  AssetGenImage get bedroom10 =>
      const AssetGenImage('assets/images/bedroom10.jpg');

  /// File path: assets/images/bedroom2.jpg
  AssetGenImage get bedroom2 =>
      const AssetGenImage('assets/images/bedroom2.jpg');

  /// File path: assets/images/bedroom3.jpg
  AssetGenImage get bedroom3 =>
      const AssetGenImage('assets/images/bedroom3.jpg');

  /// File path: assets/images/bedroom4.jpg
  AssetGenImage get bedroom4 =>
      const AssetGenImage('assets/images/bedroom4.jpg');

  /// File path: assets/images/bedroom5.jpg
  AssetGenImage get bedroom5 =>
      const AssetGenImage('assets/images/bedroom5.jpg');

  /// File path: assets/images/bedroom6.jpg
  AssetGenImage get bedroom6 =>
      const AssetGenImage('assets/images/bedroom6.jpg');

  /// File path: assets/images/bedroom7.jpg
  AssetGenImage get bedroom7 =>
      const AssetGenImage('assets/images/bedroom7.jpg');

  /// File path: assets/images/bedroom8.jpg
  AssetGenImage get bedroom8 =>
      const AssetGenImage('assets/images/bedroom8.jpg');

  /// File path: assets/images/bedroom9.jpg
  AssetGenImage get bedroom9 =>
      const AssetGenImage('assets/images/bedroom9.jpg');

  /// File path: assets/images/img2.jpg
  AssetGenImage get img2 => const AssetGenImage('assets/images/img2.jpg');

  /// File path: assets/images/img3.jpg
  AssetGenImage get img3 => const AssetGenImage('assets/images/img3.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        banana,
        bedroom1,
        bedroom10,
        bedroom2,
        bedroom3,
        bedroom4,
        bedroom5,
        bedroom6,
        bedroom7,
        bedroom8,
        bedroom9,
        img2,
        img3
      ];
}

class Assets {
  const Assets._();

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
    FilterQuality filterQuality = FilterQuality.medium,
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
