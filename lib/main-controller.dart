import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sound/flutter_sound.dart';

class MediaController extends GetxController {
  final mediaBox = Hive.box('mediaBox');
  var mediaFiles = <Map<String, dynamic>>[].obs; // Store both images and audios
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _soundPlayer = FlutterSoundPlayer();
  String? recordedAudioPath;

  @override
  void onInit() {
    super.onInit();
    loadMediaFromHive();
    _initRecorder();
    _soundPlayer.openPlayer(); // Initialize the sound player
  }

  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
  }

  @override
  void onClose() {
    _recorder.closeRecorder();
    _soundPlayer.closePlayer(); // Close the sound player
    super.onClose();
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await saveMedia(pickedFile.path, 'image');
    }
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await saveMedia(pickedFile.path, 'image');
    }
  }

  // Pick image from URL
  Future<void> pickImageFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/image_from_url.png';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        await saveMedia(file.path, 'image');
      }
    } catch (e) {
      print("Failed to load image: $e");
    }
  }

  // Pick audio from storage
  Future<void> pickAudioFromStorage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      await saveMedia(result.files.single.path!, 'audio');
    }
  }

  // Record audio
  Future<void> startRecordingAudio() async {
    recordedAudioPath =
        '${(await getTemporaryDirectory()).path}/recorded_audio.aac';
    await _recorder.startRecorder(toFile: recordedAudioPath);
  }

  Future<void> stopRecordingAudio() async {
    await _recorder.stopRecorder();
    if (recordedAudioPath != null) {
      await saveMedia(recordedAudioPath!, 'audio');
    }
  }

  // Save Image from assets to local storage and Hive
  Future<void> saveImageFromAssets(String assetPath) async {
    // var imageFilePath = ''.obs;
    final ByteData data = await rootBundle.load(assetPath);
    final buffer = data.buffer;

    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = join(appDocDir.path, 'image.jpg');
    //saveMedia(filePath, 'image');
    File(filePath).writeAsBytesSync(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    // saveMedia(filePath, 'image');
    mediaFiles.add({'path': filePath, 'type': 'image'});
    mediaBox.put('mediaFiles', mediaFiles.toList());

    // mediaBox.put('mediaFiles', filePath);
    // imageFilePath.value = filePath;
  }

  // Save Audio from assets to local storage and Hive
  Future<void> saveAudioFromAssets(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final buffer = data.buffer;

    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = join(appDocDir.path, 'audio.mp3');
    File(filePath).writeAsBytesSync(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

    mediaFiles.add({'path': filePath, 'type': 'audio'});
    mediaBox.put('mediaFiles', mediaFiles.toList());
  }

  // Save asset image or audio to local storage and Hive
//   Future<void> saveAssetFile(String assetPath, String type) async {
//     try {
//       // Load the asset as ByteData
//       final ByteData byteData = await rootBundle.load(assetPath);
//       final Uint8List data = byteData.buffer.asUint8List();

//       // Extract the file name from the asset path
//       final fileName = basename(assetPath);

//       // Save the file to the local storage directory
//       final filePath = await saveFileToLocal(data, fileName);

//       // After saving, store the file path and type in Hive
//       await saveMedia(filePath, type);
//     } catch (e) {
//       print("Error saving asset file: $e");
//     }
//   }

// // Save the file to local storage directory
//   Future<String> saveFileToLocal(Uint8List data, String fileName) async {
//     final appDir = await getApplicationDocumentsDirectory();
//     final filePath = '${appDir.path}/$fileName';
//     final file = File(filePath);

//     // Write the Uint8List data to the file
//     await file.writeAsBytes(data);

//     return filePath; // Return the path to be saved in Hive
//   }

  // Save media to Hive and the observable list
  Future<void> saveMedia(String path, String type) async {
    final savedPath = await saveToLocalStorage(path);
    mediaFiles.add({'path': savedPath, 'type': type});
    mediaBox.put('mediaFiles', mediaFiles.toList());
  }

  // Save to local storage
  Future<String> saveToLocalStorage(String path) async {
    final file = File(path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = file.path.split('/').last;
    final localFile = await file.copy('${appDir.path}/$fileName');
    return localFile.path;
  }

  // Load media (images and audios) from Hive
  void loadMediaFromHive() {
    List<Map<String, dynamic>>? savedMediaFiles =
        mediaBox.get('mediaFiles')?.cast<Map<String, dynamic>>();
    if (savedMediaFiles != null && savedMediaFiles.isNotEmpty) {
      mediaFiles.addAll(savedMediaFiles);
    }
  }

  // Play audio from the path
  Future<void> playAudio(String path) async {
    await _soundPlayer.startPlayer(fromURI: path, codec: Codec.mp3);
  }

  // Pause audio playback
  Future<void> pauseAudio() async {
    await _soundPlayer.pausePlayer();
  }
}
