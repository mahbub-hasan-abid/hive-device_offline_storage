import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_experiment/main-controller.dart';
// Adjust the import according to your file structure

class MediaDisplayPage extends StatelessWidget {
  final MediaController mediaController = Get.find<MediaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Media'),
      ),
      body: Obx(() {
        if (mediaController.mediaFiles.isEmpty) {
          return Center(child: Text('No media files available'));
        }

        return ListView.builder(
          itemCount: mediaController.mediaFiles.length,
          itemBuilder: (context, index) {
            final mediaItem = mediaController.mediaFiles[index];
            final String mediaPath = mediaItem['path'];
            final String mediaType = mediaItem['type'];

            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: mediaType == 'image'
                    ? Image.file(File(mediaPath), width: 50, height: 50)
                    : Icon(Icons.audiotrack, size: 50, color: Colors.blue),
                title: Text(mediaType == 'image' ? 'Image' : 'Audio'),
                trailing: mediaType == 'audio'
                    ? IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          mediaController.playAudio(mediaPath);
                        },
                      )
                    : null,
                onTap: () {
                  if (mediaType == 'audio') {
                    mediaController.playAudio(mediaPath);
                  }
                },
              ),
            );
          },
        );
      }),
    );
  }
}
