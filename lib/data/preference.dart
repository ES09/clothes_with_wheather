import 'package:shared_preferences/shared_preferences.dart';

import 'clothesTmp.dart';

class Preference {
  Future<List<ClothesTmp>> getClothes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> tmp30 = pref.getStringList("30") ?? ["assets/img/short-sleeve.png", "assets/img/skirts.png"];
    List<String> tmp20 = pref.getStringList("20") ?? ["assets/img/short-sleeve.png", "assets/img/pants.png", "assets/img/skirts.png"];
    List<String> tmp10 = pref.getStringList("10") ?? ["assets/img/jumper.png", "assets/img/long-sleeve.png", "assets/img/pants.png"];
    List<String> tmp0 = pref.get("0") ?? ["assets/img/jumper.png", "assets/img/long-sleeve.png", "assets/img/pants.png"];

    return [
      ClothesTmp(tmp : 30, clothes: tmp30),
      ClothesTmp(tmp : 20, clothes: tmp20),
      ClothesTmp(tmp : 10, clothes: tmp10),
      ClothesTmp(tmp : 0, clothes: tmp0)
    ];
  }

  Future<void> setTmp(ClothesTmp clothes) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setStringList("${clothes.tmp}", clothes.clothes);
  }
}