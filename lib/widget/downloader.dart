import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

savePath(String path, String base) {
  final slice = path.split('/');
  String dirs = '';
  for (int i = 0; i < slice.length; i++) {
    dirs += slice[i];
    if (i < slice.length - 1) {
      dirs += '/';
    }
    try {
      Directory(base + dirs).create().then((Directory directory) {});
    } catch (_) {}
  }
}

Future<String> getPhoneDirectory({platform, path}) async {
  if (platform == 'android') {
    await Permission.storage.request();
    final temp = await getExternalStorageDirectory();
    final base = (temp?.path ?? '') + '/';
    await savePath(path, base);
    return base + path;
  } else if (platform == 'ios') {
    final temp = await getApplicationDocumentsDirectory();
    await savePath(path, temp.path + '/');

    return temp.path + '/' + path;
  }
  return '';
}

getPlatformDir(directory) async {
  if (Platform.isAndroid) {
    return (await getPhoneDirectory(path: directory, platform: 'android'));
  } else if (Platform.isIOS) {
    return (await getPhoneDirectory(path: directory, platform: 'ios'));
  }
}
