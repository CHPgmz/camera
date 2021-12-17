import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:camara/apis/youtube.dart';
import 'package:camara/src/pages/image_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(16.9083823, -92.0950663);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final ImagePicker? _image = ImagePicker();
  //late List<PickedFile> images = [];
  late List<XFile> images = [];
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Apis Funcionando'),
          centerTitle: true,
          backgroundColor: Colors.teal[400],
          bottom: TabBar(
            tabs: [
              Tab(
              child: Row(
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.map),
                  Text('Camara'),
                ],
              )),
              Tab(
                child: Row(
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.youtube),
                  Text('YouTube'),
                ],
              )),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        drawer: drawer(context),
        body: TabBarView(
          children: [
            gogleMaps(_onMapCreated, _center),
             Youtube(),
            GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                File imageFile = File(images[index].path);
                return InkWell(
                    child: Image.file(imageFile),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageViewScreen(
                          imageFile: imageFile,
                        )));
                    });
              },
            ),
            
            //TakePictureScreen(cameras: cameras),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _optionsDialogBox,
        ),
      ),
    );
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('image_picker: Cámara'),
                    onTap: _openCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('image_picker: Galería'),
                    onTap: _openGallery,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  // GestureDetector(
                  //   child: Text('camera: cámara'),
                  //   onTap: () async {
                  //     String picturePath = await Navigator.of(context).push(
                  //         MaterialPageRoute(
                  //             builder: (context) => CameraScreen()));
                  //     Navigator.pop(context);
                  //     print(picturePath);
                  //     setState(() {
                  //       images.add(XFile(picturePath));
                  //       //images!.add(PickedFile(picturePath));
                  //     });
                  //   },
                  // ),
                ],
              ),
            ),
      );
    });
  }

  Future<void> _openCamera() async {
    // List<XFile>? images = await _image.pickMultiImage();
    //PickedFile picture = await imagePicker.getImage(source: ImageSource.camera,);
    file = await _image!.pickImage(source: ImageSource.camera);
    Navigator.pop(context);
    setState(() {
      images.add(file!);
    });
  }

  Future _openGallery() async {
    // PickedFile picture = await imagePicker.pickImage(source: source)(
    //   source: ImageSource.gallery,
    // );
    file = await _image!.pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
    setState(() {
      images.add(file!);
      //images;
    });
  }
}


Widget gogleMaps(_onMapCreated, _center) {
  return GoogleMap(
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
      target: _center,
      zoom: 10.0,
    ),
  );
}

Widget header() {
  return DrawerHeader(
    decoration: BoxDecoration(
      color: Colors.teal[400],
    ),
    child: Text(
      'Nivelación',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    ),
  );
}
































Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        header(),
        
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('About'),
          onTap: (){
            // Navigator.push( context, MaterialPageRoute(builder: (context)=>About()));
          },
        ),
        
      ],
    ),
  );
}

// Scaffold(
//       body:
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: _optionsDialogBox,
//       ),

// GridView.builder(
//         padding: EdgeInsets.all(10),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//         ),
//         itemCount: images.length,
//         itemBuilder: (BuildContext context, int index) {
//           File imageFile = File(images[index].path);

//           return InkWell(
//               child: Image.file(imageFile),
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => ImageViewScreen(
//                           imageFile: imageFile,
//                         )));
//               });
//         },
//       ),