import 'package:flutter_web_ui/ui.dart';
import 'package:pong/main.dart' as app;

main() async {
  await webOnlyInitializePlatform();
  app.main();
}