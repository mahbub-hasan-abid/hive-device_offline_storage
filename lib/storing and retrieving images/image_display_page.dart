import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_experiment/storing%20and%20retrieving%20images/image_picker_controller.dart';
import 'dart:io';

class DisplayImagePage extends StatelessWidget {
  final ImageController imageController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<String> savedImages = imageController.getImagesFromStorage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Images'),
      ),
      body: savedImages.isEmpty
          ? const Center(child: Text('No images stored'))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: savedImages.length,
              itemBuilder: (context, index) {
                return Image.file(
                  File(savedImages[index]),
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }
}
