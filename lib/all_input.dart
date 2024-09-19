import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_experiment/all_display.dart';
import 'package:hive_experiment/main-controller.dart';
// Adjust the import according to your file structure

class MediaInputPage extends StatelessWidget {
  final MediaController mediaController = Get.put(MediaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Media'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => mediaController.pickImageFromGallery(),
              child: Text('Pick Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: () => mediaController.pickImageFromCamera(),
              child: Text('Pick Image from Camera'),
            ),
            ElevatedButton(
              onPressed: () async {
                String imageUrl = 'https://example.com/image.png';
                await mediaController.pickImageFromUrl(imageUrl);
              },
              child: Text('Pick Image from URL'),
            ),
            ElevatedButton(
              onPressed: () => mediaController.pickAudioFromStorage(),
              child: Text('Pick Audio from Storage'),
            ),
            ElevatedButton(
              onPressed: () => mediaController.startRecordingAudio(),
              child: Text('Start Recording Audio'),
            ),
            ElevatedButton(
              onPressed: () => mediaController.stopRecordingAudio(),
              child: Text('Stop Recording Audio'),
            ),
            ElevatedButton(
              onPressed: () {
                String assetImagePath = 'assets/images/αγαπώ.png';
                mediaController.saveImageFromAssets(assetImagePath);
              },
              child: Text('Save Image from Assets'),
            ),

            // Example usage: Save an image from assets
//             ElevatedButton(
//               onPressed: () {
//                 String assetImagePath = 'assets/images/αγαπώ.png';
//                 mediaController.saveAssetFile(assetImagePath, 'image');
//               },
//               child: Text('Save Image from Assets'),
//             ),

// Example usage: Save an audio from assets
            ElevatedButton(
              onPressed: () {
                String assetAudioPath = 'assets/audios/adelfi.mp3';
                mediaController.saveAudioFromAssets(assetAudioPath);
              },
              child: Text('Save Audio from Assets'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Get.to(() => MediaDisplayPage()), // Navigate to display page
              child: Text('Go to Display Page'),
            ),
          ],
        ),
      ),
    );
  }
}
