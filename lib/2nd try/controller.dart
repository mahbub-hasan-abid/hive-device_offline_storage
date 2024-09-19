// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:flutter_sound/flutter_sound.dart';

// class MediaController extends GetxController {
//   final mediaBox = Hive.box('mediaBox');
//   var imageFilePath = ''.obs;
//   var audioFilePath = ''.obs;
//   final FlutterSoundPlayer _soundPlayer = FlutterSoundPlayer();

//   @override
//   void onInit() {
//     super.onInit();
//     loadFilesFromHive();

//     saveImageFromAssets('assets/images/αγαπώ.png');
//     _soundPlayer.openPlayer(); // Initialize the sound player
//   }

//   @override
//   void onClose() {
//     _soundPlayer.closePlayer(); // Close the sound player when done
//     super.onClose();
//   }

//   // Save Image from assets to local storage and Hive
//   Future<void> saveImageFromAssets(String assetPath) async {
//     final ByteData data = await rootBundle.load(assetPath);
//     final buffer = data.buffer;

//     final appDocDir = await getApplicationDocumentsDirectory();
//     final filePath = join(appDocDir.path, 'image.jpg');
//     File(filePath).writeAsBytesSync(
//         buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

//     mediaBox.put('image', filePath);
//     imageFilePath.value = filePath;
//   }

//   // Save Audio from assets to local storage and Hive
//   Future<void> saveAudioFromAssets(String assetPath) async {
//     final ByteData data = await rootBundle.load(assetPath);
//     final buffer = data.buffer;

//     final appDocDir = await getApplicationDocumentsDirectory();
//     final filePath = join(appDocDir.path, 'audio.mp3');
//     File(filePath).writeAsBytesSync(
//         buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

//     mediaBox.put('audio', filePath);
//     audioFilePath.value = filePath;
//   }

//   // Load files from Hive if they exist
//   void loadFilesFromHive() {
//     if (mediaBox.containsKey('image')) {
//       imageFilePath.value = mediaBox.get('image');
//     }
//     if (mediaBox.containsKey('audio')) {
//       audioFilePath.value = mediaBox.get('audio');
//     }
//   }

//   // Play audio from local storage
//   Future<void> playAudio() async {
//     if (audioFilePath.isNotEmpty) {
//       await _soundPlayer.startPlayer(
//         fromURI: audioFilePath.value,
//         codec: Codec.mp3,
//       );
//     }
//   }

//   // Pause audio
//   Future<void> pauseAudio() async {
//     await _soundPlayer.pausePlayer();
//   }
// }
