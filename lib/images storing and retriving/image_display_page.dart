// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:hive_experiment/images%20storing%20and%20retriving/image_picker_controller.dart';

// class DisplayMediaPage extends StatefulWidget {
//   @override
//   _DisplayMediaPageState createState() => _DisplayMediaPageState();
// }

// class _DisplayMediaPageState extends State<DisplayMediaPage> {
//   final FlutterSoundPlayer _player = FlutterSoundPlayer();
//   final ImageController imageController = Get.find();

//   @override
//   void initState() {
//     super.initState();
//     _player.openPlayer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Media Display'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() {
//               List<String> imagePaths = imageController.imagePaths;
//               List<String> audioPaths = imageController.audioPaths;

//               print('Image paths: $imagePaths'); // Debugging
//               print('Audio paths: $audioPaths'); // Debugging

//               return ListView.builder(
//                 itemCount: imagePaths.length + audioPaths.length,
//                 itemBuilder: (context, index) {
//                   if (index < imagePaths.length) {
//                     // Display Image
//                     return Image.file(
//                       File(imagePaths[index]),
//                       fit: BoxFit.cover,
//                     );
//                   } else {
//                     final audioIndex = index - imagePaths.length;
//                     final audioPath = audioPaths[audioIndex];
//                     return ListTile(
//                       leading: Icon(Icons.audiotrack),
//                       title: Text('Audio: ${audioPath.split('/').last}'),
//                       onTap: () => _player.startPlayer(fromURI: audioPath),
//                     );
//                   }
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
