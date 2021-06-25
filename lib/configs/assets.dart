import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  AppAssets._();

  // Base
  static const String baseImg = 'assets/images';
  static const String baseIcon = 'assets/icons';

  // Images
  static const String bgSplash = '$baseImg/bg_splash.png';
  static const String cat='$baseImg/cat.png';

  // Icons
  static const String icPlay = '$baseIcon/ic_play.svg';

  static Future precacheAssets(BuildContext context) async {
    await Future.wait([
      // Images
      precacheImage(const AssetImage(AppAssets.bgSplash), context),
      // Icons
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, AppAssets.icPlay),
        context,
      ),
    ]);
  }
}
