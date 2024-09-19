import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_experiment/images%20storing%20and%20retriving/image_display_page.dart';
import 'package:hive_experiment/images%20storing%20and%20retriving/image_picker_controller.dart';

class ImageInputPage extends StatelessWidget {
  final ImageController imageController = Get.put(ImageController());
  final TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Image and Audio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                imageController.pickImageFromGallery();
              },
              child: const Text('Pick Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: () {
                imageController.pickImageFromCamera();
              },
              child: const Text('Pick Image from Camera'),
            ),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (urlController.text.isNotEmpty) {
                  imageController.pickImageFromUrl(urlController.text);
                }
              },
              child: const Text('Pick Image from URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                imageController.pickAudioFromStorage();
              },
              child: const Text('Pick Audio from Storage'),
            ),
            ElevatedButton(
              onPressed: () {
                imageController.startRecordingAudio();
              },
              child: const Text('Start Recording Audio'),
            ),
            ElevatedButton(
              onPressed: () {
                imageController.stopRecordingAudio();
              },
              child: const Text('Stop Recording Audio'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return imageController.imagePaths.isEmpty
                  ? const Text('No images selected')
                  : Expanded(
                      child: ListView.builder(
                        itemCount: imageController.imagePaths.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(imageController.imagePaths[index]),
                            height: 100,
                          );
                        },
                      ),
                    );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => DisplayImagePage());
              },
              child: const Text('Go to Display Page'),
            ),
          ],
        ),
      ),
    );
  }
}
