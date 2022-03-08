import 'package:clothes_by_weather/cloth.dart';
import 'package:clothes_by_weather/data/clothesTmp.dart';
import 'package:clothes_by_weather/data/location.dart';
import 'package:clothes_by_weather/data/preference.dart';
import 'package:clothes_by_weather/data/util.dart';
import 'package:clothes_by_weather/data/weatherApi.dart';
import 'package:clothes_by_weather/location.dart';
import 'package:flutter/material.dart';

import 'data/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Color> colors = [
    Color(0xFFf78144),
    Color(0xFF1d9fea),
    Color(0xFF7B7BBD),
    Color(0xff4c6173)
  ];

  List<String> sky = [
    "assets/img/sky1.png",
    "assets/img/sky2.png",
    "assets/img/sky3.png",
    "assets/img/sky4.png",
  ];

  List<String> clothes = [
    "assets/img/jumper.png",
    "assets/img/long-sleeve.png",
    "assets/img/shirts.png",
  ];

  List<String> status = [
    "활동하기 좋은 날씨!",
    "밤에는 춥다~",
    "쌀쌀해진 날씨",
    "우산 꼭 챙겨요~"
  ];

  List<ClothesTmp> clothesTmp = [];
  List<Weather> weatherList = [];
  Weather current;

  LocationData locationData = LocationData(name : "강남구", x: 0, y: 0, lat: 37.498122, lng: 127.027565);

  int level = 0; //하늘 상태

  void getWeather() async {
    final api = WeatherApi();
    Map<String, int> xy = Utils.latLngToXY(locationData.lat, locationData.lng);

    final pref = Preference();
    clothesTmp = await pref.getClothes();

    final now = DateTime.now();
    int checkTime = int.parse("${now.hour}10");
    String setTime = "";
    //데이터 업데이트 기준 시간
    if(checkTime > 2300) {
      setTime = "2300";
    } else if(checkTime > 2000) {
      setTime = "2000";
    } else if(checkTime > 1700) {
      setTime = "1700";
    } else if(checkTime > 1400) {
      setTime = "1400";
    } else if(checkTime > 1100) {
      setTime = "1100";
    } else if(checkTime > 800) {
      setTime = "0800";
    } else if(checkTime > 500) {
      setTime = "0500";
    } else {
      setTime = "0200";
    }

    weatherList = await api.getWeatherData(xy["nx"], xy["ny"], Utils.getFormatTime(DateTime.now()), setTime);

    int time = int.parse("${now.hour}00");

    // 지금 시간 이전의 예보 지우기
    weatherList.removeWhere((w) => w.time < time);
    current = weatherList.first;
    clothes = clothesTmp.firstWhere((t) => t.tmp < current.tmp).clothes;
    level = getLevel(current);
    setState(() {});
  }

  int getLevel(Weather w) {
    // 6~8 구름 많음
    if(w.sky > 8) {
      return 3;
    } else if(w.sky > 5) {
      return 2;
    } else if(w.sky > 2) {
      return 1;
    }
    return 0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.category),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => ClothPage())
                );
              }
          )
        ],
      ),
      backgroundColor: colors[level],
      body: weatherList.isEmpty? Container(child: Text("날씨 정보 불러오는 중..."),) : getPage(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on),
        onPressed: () async {
          LocationData data = await Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => LocationPage())
          );

          if(data != null) {
            locationData = data;
            getWeather();
          }
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getPage() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("${locationData.name}",
            textAlign: TextAlign.center,
            style: TextStyle(color : Colors.white, fontSize: 20),
          ),
          Container(
            width: 100,
            height: 100,
            child: Image.asset(sky[level]),
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${current.tmp}°C",
                style: TextStyle(color : Colors.white, fontSize: 28),
              ),
              Column(
                children: [
                  Text("${Utils.stringToDateTime(current.date).month}월 ${Utils.stringToDateTime(current.date).day}일",
                    style: TextStyle(color : Colors.white, fontSize: 14),
                  ),
                  Text(status[level],
                    style: TextStyle(color : Colors.white, fontSize: 14),
                  )
                ],
              )
            ],
          ),
          Container(height: 30),
          Container(
            child: Text("오늘의 옷은?", style: TextStyle(color : Colors.white, fontSize: 20)),
            margin: EdgeInsets.symmetric(horizontal: 20),
          ),
          Container(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(clothes.length, (idx) {
              return Expanded(child: Container(
                padding: EdgeInsets.all(8),
                width: 100,
                height: 100,
                child: Image.asset(clothes[idx], fit: BoxFit.contain,),
              ));
            }),
          ),
          Container(height: 30),
          Expanded(
            child: Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  weatherList.length,
                  (idx) {
                    final w = weatherList[idx];
                    int _level = getLevel(w);

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${w.tmp}°C", style: TextStyle(color : Colors.white, fontSize: 12)),
                          Text("${w.pop}%", style: TextStyle(color : Colors.white, fontSize: 12)),
                          Container(
                            width : 50,
                            height : 50,
                            child: Image.asset(sky[_level]),
                          ),
                          Text("${w.time.toString().substring(0,2)}시", style: TextStyle(color : Colors.white, fontSize: 14))
                        ],
                      ),
                    );
                  }
                ),
              )
            )
          ),
          Container(height: 80),
        ],
      ),
    );
  }
}
