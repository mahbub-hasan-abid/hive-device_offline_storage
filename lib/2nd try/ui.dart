// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive_experiment/2nd%20try/controller.dart';

// class MediaPage extends StatelessWidget {
//   final MediaController controller = Get.put(MediaController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Media from Hive'),
//       ),
//       body: Column(
//         children: [
//           // Display Image
//           Obx(() => controller.imageFilePath.isNotEmpty
//               ? Image.file(File(controller.imageFilePath.value), height: 200)
//               : Text("No Image Stored")),

//           // Display Audio Control
//           Obx(() => controller.audioFilePath.isNotEmpty
//               ? Column(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.play_arrow),
//                       onPressed: () {
//                         controller.playAudio();
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.pause),
//                       onPressed: () {
//                         controller.pauseAudio();
//                       },
//                     ),
//                   ],
//                 )
//               : Text("No Audio Stored")),

//           SizedBox(height: 20),

//           // Save Media Buttons
//           ElevatedButton(
//             onPressed: () =>
//                 controller.saveImageFromAssets('assets/images/αγαπώ.png'),
//             child: Text('Save Image to Hive'),
//           ),
//           ElevatedButton(
//             onPressed: () =>
//                 controller.saveAudioFromAssets('assets/audios/adelfi.mp3'),
//             child: Text('Save Audio to Hive'),
//           ),
//         ],
//       ),
//     );
//   }
// }
