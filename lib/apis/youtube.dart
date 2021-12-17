import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:query_parser/query_parser.dart';

//import 'package:youtube_api/src/model/thumbnails.dart';

import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

//import 'package:uri/uri.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_api/youtube_api.dart';

class Youtube extends StatefulWidget {
  Youtube({Key? key}) : super(key: key);

  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  late ImageFrameBuilder? frameBuilder;
  String busqueda = "Ocosingo";
  static String api_key = "AIzaSyB2aZnujxp6pzlBcePq8FBLBej6B4ymsqY";
  YoutubeAPI youtube = YoutubeAPI(api_key, type: "Video");

  Future<List<YouTubeVideo>> _buscaVideos() async {
    List<YouTubeVideo> videos =
        await youtube.search(busqueda, type: "Videos", regionCode: "MX");
    return videos;
  }

  Future<void> _abreVideo(BuildContext context, String url) async {
    if (!await launch(url)) {
      SnackBar snack = SnackBar(
        content: Text("No se pudo abrir el Video"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return FutureBuilder(
        future: _buscaVideos(),
        builder: (BuildContext context, AsyncSnapshot respuesta) {
          if (respuesta.hasData) {
            return _scroll(respuesta.data);
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _buscador() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: TextField(
            decoration: InputDecoration(
              labelText: "Buscar",
              fillColor: Color(200),
            ),
            onChanged: (valor) {
              busqueda = valor;
            },
          ),
          width: 200,
        ),
        IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.search))
      ],
    );
  }

  Widget _scroll(List<YouTubeVideo> videos) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buscador(),
          _listaVideos(videos),
        ],
      ),
    );
  }

  Widget _listaVideos(List<YouTubeVideo> videos) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => ListTile(
        leading: IconButton(
          onPressed: () {
            String url = videos[index].url;
            _abreVideo(context, url);
          },
          //icon:
          //  frameBuilder: (BuildContext, Widget child, int?, bool)? {

          //  }
          //Widget Function(BuildContext, Widget, int?, bool)? ,

          //Image.network('https://i.ytimg.com/vi/'+videos[index].id.toString()+'/default.jpg',
          //icon: Icon(Icons.access_alarm),
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              'https://i.ytimg.com/vi/'+videos[index].id.toString()+'/default.jpg',
              //http.get(Uri.parse(videos[index].url.toString())),

              frameBuilder: (BuildContext context, Widget child, int? frame,
                  bool wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return frame == false 
                ? 
                  Icon(
                    Icons.video_library,
                    size: 28,
                    color: Colors.blue,
                  )
                  : child;
                }),
          ),
          iconSize: 100,
        ),
        title: Text(videos[index].title),
        subtitle: Text(videos[index].channelTitle.toString()),
      ),
      separatorBuilder: (context, index) => Divider(
        color: Colors.white,
      ),
      itemCount: videos.length,
    );
  }
}
