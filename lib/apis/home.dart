// import 'dart:async';
// import 'dart:convert';


import 'package:camara/apis/youtube.dart';
import 'package:camara/src/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:proyecto_ra/pages/about.dart';
// import 'package:proyecto_ra/pages/apiFlutter.dart';
// import 'package:proyecto_ra/pages/youtube.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  //final CameraDescription cameras;
  //const HomePage({Key? key, required this.cameras}) : super(key: key);
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//late CameraDescription cameras;
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(16.9083823, -92.0950663);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title:  Text('Apis Funcionando'),
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
          //drawer: drawer(context),
          body: TabBarView(
            children: [
              HomeScreen(),
              Youtube(),
              gogleMaps(_onMapCreated, _center),
               //TakePictureScreen(cameras: cameras),
            ],
          ),
          
        ),
      ),
    );
  }
}

Widget gogleMaps(_onMapCreated, _center) {
  return GoogleMap(
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
      target: _center,
      zoom: 11.0,
    ),
  );
}

// Widget drawer(BuildContext context) {
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: <Widget>[
//         header(),
        
//         ListTile(
//           leading: Icon(Icons.account_circle),
//           title: Text('About'),
//           onTap: (){
//             // Navigator.push( context, MaterialPageRoute(builder: (context)=>About()));
//           },
//         ),
        
//       ],
//     ),
//   );
// }

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
