import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_experiment/images%20storing%20and%20retriving/image_picker_controller.dart';
import 'package:flutter_sound/flutter_sound.dart'; // For playing audio

class DisplayImagePage extends StatefulWidget {
  @override
  _DisplayImagePageState createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  final ImageController imageController = Get.find();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  @override
  Widget build(BuildContext context) {
    List<String> savedImages = imageController.getImagesFromStorage();
    List<String> savedAudios = imageController.getAudiosFromStorage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Images and Audios'),
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
                return Column(
                  children: [
                    Image.file(
                      File(savedImages[index]),
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                    if (savedAudios.length > index)
                      ElevatedButton(
                        onPressed: () {
                          _playAudio(savedAudios[index]);
                        },
                        child: const Text('Play Audio'),
                      ),
                  ],
                );
              },
            ),
    );
  }

  Future<void> _playAudio(String path) async {
    await _player.openPlayer();
    await _player.startPlayer(fromURI: path);
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }
}
