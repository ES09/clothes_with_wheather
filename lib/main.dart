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

  List<String> clothesTop = [
    "assets/img/jumper.png",
    "assets/img/long-sleeve.png",
    "assets/img/shirts.png",
    "assets/img/short-sleeve.png",
  ];

  List<String> clothesBottom = [
    "assets/img/pants.png",
    "assets/img/skirts.png",
  ];

  List<String> status = [
    "활동하기 좋은 날씨!",
    "밤에는 춥다~",
    "쌀쌀해진 날씨",
    "우산 꼭 챙겨요~"
  ];

  List<Weather> weatherList = [];

  int level = 0; //하늘 상태

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[level],
      body: getPage(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getPage() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 60),
          Text("금천구",
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
              Text("26°C",
                style: TextStyle(color : Colors.white, fontSize: 28),
              ),
              Column(
                children: [
                  Text("",
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
            children: List.generate(clothesTop.length, (idx) {
              return Expanded(child: Container(
                padding: EdgeInsets.all(8),
                width: 100,
                height: 100,
                child: Image.asset(clothesTop[idx], fit: BoxFit.contain,),
              ));
            }),
          ),
          Container(height: 30),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                weatherList.length,
                (idx) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("온도", style: TextStyle(color : Colors.white, fontSize: 10)),
                        Text("강수확률", style: TextStyle(color : Colors.white, fontSize: 10)),
                        Container(
                          width : 50,
                          height : 50,
                        ),
                        Text("0800", style: TextStyle(color : Colors.white, fontSize: 10))
                      ],
                    ),
                  );
                }
              ),
            )
          ),
        ],
      ),
    );
  }
}
