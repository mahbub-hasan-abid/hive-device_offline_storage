// import 'dart:io';
// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_sound/flutter_sound.dart';

// class ImageController extends GetxController {
//   var imagePaths = <String>[].obs;
//   var audioPaths = <String>[].obs; // To store audio file paths

//   final Box imageBox = Hive.box('images');
//   final Box audioBox = Hive.box('audios'); // Audio box in Hive

//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   String? recordedAudioPath;

//   @override
//   void onInit() {
//     super.onInit();
//     loadImagesAndAudiosFromStorage();
//     _initRecorder();
//   }

//   Future<void> _initRecorder() async {
//     await _recorder.openRecorder();
//   }

//   Future<void> pickImageFromGallery() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       await saveImage(pickedFile.path);
//     }
//   }

//   Future<void> pickImageFromCamera() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       await saveImage(pickedFile.path);
//     }
//   }

//   Future<void> pickImageFromUrl(String url) async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final tempDir = await getTemporaryDirectory();
//         final filePath = '${tempDir.path}/image_from_url.png';
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//         await saveImage(file.path);
//       }
//     } catch (e) {
//       print("Failed to load image: $e");
//     }
//   }

//   Future<void> saveImage(String path) async {
//     final savedPath = await saveToLocalStorage(path);
//     imagePaths.add(savedPath);
//     imageBox.put('user_images', imagePaths.toList());
//   }

//   Future<void> pickAudioFromStorage() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.audio);
//     if (result != null) {
//       await saveAudio(result.files.single.path!);
//     }
//   }

//   Future<void> startRecordingAudio() async {
//     recordedAudioPath =
//         '${(await getTemporaryDirectory()).path}/recorded_audio.aac';
//     await _recorder.startRecorder(toFile: recordedAudioPath);
//   }

//   Future<void> stopRecordingAudio() async {
//     await _recorder.stopRecorder();
//     if (recordedAudioPath != null) {
//       await saveAudio(recordedAudioPath!);
//     }
//   }

//   Future<void> saveAudio(String path) async {
//     final savedPath = await saveToLocalStorage(path);
//     audioPaths.add(savedPath);
//     audioBox.put('user_audios', audioPaths.toList());
//   }

//   Future<String> saveToLocalStorage(String path) async {
//     final file = File(path);
//     final appDir = await getApplicationDocumentsDirectory();
//     final fileName = file.path.split('/').last;
//     final localFile = await file.copy('${appDir.path}/$fileName');
//     return localFile.path;
//   }

//   Future<void> storeAssetImage(String assetPath) async {
//     final ByteData byteData = await rootBundle.load(assetPath);
//     final Uint8List data = byteData.buffer.asUint8List();
//     final fileName = assetPath.split('/').last;
//     final filePath = await saveFileToLocal(data, fileName);
//     await saveImage(filePath);
//   }

//   Future<void> storeAssetAudio(String assetPath) async {
//     final ByteData byteData = await rootBundle.load(assetPath);
//     final Uint8List data = byteData.buffer.asUint8List();
//     final fileName = assetPath.split('/').last;
//     final filePath = await saveFileToLocal(data, fileName);
//     await saveAudio(filePath);
//   }

//   Future<String> saveFileToLocal(Uint8List data, String fileName) async {
//     final appDir = await getApplicationDocumentsDirectory();
//     final filePath = '${appDir.path}/$fileName';
//     final file = File(filePath);
//     await file.writeAsBytes(data);
//     return filePath;
//   }

//   void loadImagesAndAudiosFromStorage() {
//     List<String>? savedImagePaths = imageBox.get('user_images')?.cast<String>();
//     if (savedImagePaths != null && savedImagePaths.isNotEmpty) {
//       imagePaths.addAll(savedImagePaths);
//     }

//     List<String>? savedAudioPaths = audioBox.get('user_audios')?.cast<String>();
//     if (savedAudioPaths != null && savedAudioPaths.isNotEmpty) {
//       audioPaths.addAll(savedAudioPaths);
//     }
//   }

//   List<String> getImagesFromStorage() {
//     return imageBox
//         .get('user_images', defaultValue: <String>[])?.cast<String>();
//   }

//   List<String> getAudiosFromStorage() {
//     return audioBox
//         .get('user_audios', defaultValue: <String>[])?.cast<String>();
//   }

//   @override
//   void onClose() {
//     _recorder.closeRecorder();
//     super.onClose();
//   }
// }
