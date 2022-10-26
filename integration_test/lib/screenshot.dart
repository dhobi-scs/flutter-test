import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

bool _init = false;

Future<void> takeScreenshot(WidgetTester tester, String screenshotName) async {
  final binding = IntegrationTestWidgetsFlutterBinding.instance;
  if (!_init) {
    await binding.convertFlutterSurfaceToImage();
    _init = true;
  }
  await tester.pumpAndSettle();
  await binding.takeScreenshot(screenshotName);
}
