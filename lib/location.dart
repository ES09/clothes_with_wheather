import 'package:clothes_by_weather/data/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationPageState();
  }
}

class _LocationPageState extends State<LocationPage> {
  List<LocationData> locations = [
    LocationData(name : "강남구", x: 0, y: 0, lat: 37.498122, lng: 127.027565),
    LocationData(name : "동작구", x: 0, y: 0, lat: 37.502418, lng: 126.953647),
    LocationData(name : "마포구", x: 0, y: 0, lat: 37.560502, lng: 126.907612),
    LocationData(name : "성동구", x: 0, y: 0, lat: 37.556723, lng: 127.035401),
    LocationData(name : "강동구", x: 0, y: 0, lat: 37.552288, lng: 127.145225),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListView(
        children: List.generate(locations.length, (idx) {
          return ListTile(
            title: Text(locations[idx].name),
            trailing: Icon(Icons.arrow_forward),
            onTap: (){
              Navigator.of(context).pop(locations[idx]);
            },
          );
        }),
      ),
    );
  }
}