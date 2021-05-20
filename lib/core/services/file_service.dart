import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

abstract class FileService {
  Future<String> getApplicationDocumentsDirectoryPath();
  Future<File?> getImage({bool fromGallery = true});
}

class FileServiceImpl implements FileService {
  @override
  Future<String> getApplicationDocumentsDirectoryPath() async {
    if (kIsWeb) return "";
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  @override
  Future<File?> getImage({bool fromGallery = true}) async {
    ImagePicker imagePicker = new ImagePicker();
    PickedFile? pickedFile = await imagePicker.getImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }
}
