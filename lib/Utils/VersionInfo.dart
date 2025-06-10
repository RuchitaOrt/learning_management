import 'package:learning_mgt/widgets/GlobalLists.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  GlobalLists.versionNumber=packageInfo.version;
  print('App Name: $appName');
  print('Package Name: $packageName');
  print('Version: $version');
  print('Build Number: $buildNumber');
}
