import 'dart:io';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController {
  var imagePaths = <String>[].obs;

  final Box imageBox = Hive.box('images');

  @override
  void onInit() {
    super.onInit();
    loadImagesFromStorage();
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await saveImage(pickedFile.path);
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await saveImage(pickedFile.path);
    }
  }

  Future<void> pickImageFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/image_from_url.png';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        await saveImage(file.path);
      }
    } catch (e) {
      print("Failed to load image: $e");
    }
  }

  Future<void> saveImage(String path) async {
    final savedPath = await saveToLocalStorage(path);
    imagePaths.add(savedPath);
    imageBox.put('user_images', imagePaths.toList());
  }

  Future<String> saveToLocalStorage(String path) async {
    final file = File(path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = file.path.split('/').last;
    final localImage = await file.copy('${appDir.path}/$fileName');
    return localImage.path;
  }

  void loadImagesFromStorage() {
    List<String>? savedPaths = imageBox.get('user_images')?.cast<String>();
    if (savedPaths != null && savedPaths.isNotEmpty) {
      imagePaths.addAll(savedPaths);
    }
  }

  List<String> getImagesFromStorage() {
    return imageBox
        .get('user_images', defaultValue: <String>[])?.cast<String>();
  }
}
