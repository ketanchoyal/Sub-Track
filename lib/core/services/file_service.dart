import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

final fileServiceP = Provider<FileService>((ref) => FileServiceImpl());
final hiveP = Provider<HiveInterface>((ref) => Hive);

abstract class FileService {
  Future<String> getApplicationDocumentsDirectoryPath();
  Future<File?> getImage({bool fromGallery = true});
}

class FileServiceImpl implements FileService {
  @override
  Future<String> getApplicationDocumentsDirectoryPath() async {
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
