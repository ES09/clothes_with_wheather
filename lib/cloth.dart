import 'package:clothes_by_weather/data/clothesTmp.dart';
import 'package:clothes_by_weather/data/preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClothPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ClothPageState();
  }
}

class _ClothPageState extends State<ClothPage> {
  List<ClothesTmp> clothes = [];

  void getClothesFunc() async {
    final pref = Preference();
    clothes = await pref.getClothes();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClothesFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blue,
      body: ListView(
        children: List.generate(clothes.length, (idx) {
          return Container(
            child: Column(
              children: [
                Text("${clothes[idx].tmp}°C도 이상이예요"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(clothes[idx].clothes.length, (_i) {
                    return Expanded(child: Container(
                      padding: EdgeInsets.all(8),
                      width: 100,
                      height: 100,
                      child: Image.asset(clothes[idx].clothes[_i], fit: BoxFit.contain,),
                    ));
                  }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}