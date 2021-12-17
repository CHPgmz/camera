import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewScreen extends StatefulWidget {
  File imageFile;
  ImageViewScreen({Key? key, required this.imageFile}) : super(key: key);
//late File imageFile;
  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: FileImage(widget.imageFile),
        heroAttributes: PhotoViewHeroAttributes(tag: "Imagen"),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pop(context);
        
      },child: Icon(Icons.arrow_back_sharp),
      ),
    );
  }
}
