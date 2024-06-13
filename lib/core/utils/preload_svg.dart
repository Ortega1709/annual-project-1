import 'package:flutter_svg/flutter_svg.dart';

Future<void> preloadSVG(List<String> assets) async {
  for (final path in assets) {
    final loader = SvgAssetLoader(path);
    await svg.cache.putIfAbsent(
      loader.cacheKey(null),
      () => loader.loadBytes(null),
    );
  }
}
