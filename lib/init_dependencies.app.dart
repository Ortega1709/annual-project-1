part of 'init_dependencies.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> initDependencies() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  _initSVG();
}

void _initSVG() async {
  await preloadSVG([
    'assets/svg/vegetable-1.svg',
    'assets/svg/vegetable-2.svg',
  ]);
}

void _auth() {}

void _article() {}
