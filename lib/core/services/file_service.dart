import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

abstract class FileService {
  Future<String> getApplicationDocumentsDirectoryPath();
  Future<File?> getImage({bool fromGallery = true});
  Future saveHomeScreen(Uint8List image);
  File? get homeScreen;
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

  File? _homescreen;

  @override
  saveHomeScreen(Uint8List image) async {
    final tempDir = await getApplicationDocumentsDirectory();
    final file = await new File('${tempDir.path}/homescreen.png').create();
    file.writeAsBytesSync(image);
    _homescreen = file;
  }

  @override
  File? get homeScreen => _homescreen;
}
