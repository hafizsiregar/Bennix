import 'package:benix/widget/select.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'model/select_model.dart';

final picker = ImagePicker();

Future<String?> getImage(context) async {
  String? _path;
  await Select.single(
    title: 'Pilih Tipe',
    context: context,
    isSearch: false,
    data: [
      SelectData(
        id: 'camera',
        title: 'Camera',
      ),
      SelectData(
        id: 'gallery',
        title: 'Gallery',
      )
    ],
  ).then((value) async {
    if (value?.id == 'camera') {
      final gets = await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
      _path = gets?.path;
    } else if (value?.id == 'gallery') {
      final gets = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      _path = gets?.path;
    }
  });
  return _path;
}

Future<String?> getVideo(context) async {
  String? _path;
  await Select.single(
    title: 'Pilih Tipe',
    context: context,
    isSearch: false,
    data: [
      SelectData(
        id: 'camera',
        title: 'Camera',
      ),
      SelectData(
        id: 'gallery',
        title: 'Gallery',
      )
    ],
  ).then((value) async {
    if (value?.id == 'camera') {
      final gets = await picker.pickVideo(source: ImageSource.camera);
      _path = gets?.path;
    } else if (value?.id == 'gallery') {
      final gets = await picker.pickVideo(source: ImageSource.gallery);
      _path = gets?.path;
    }
  });
  return _path;
}

Future<String?> getFile({context, bool isMultiple = false, List<String>? extension}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: isMultiple,
    allowedExtensions: extension,
    type: extension == null ? FileType.any : FileType.custom,
  );
  return result?.files.single.path;
}
