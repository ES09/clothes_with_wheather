import 'package:clothes_by_weather/data/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collection/collection.dart';

class WeatherApi {
  final String BASE_URL = "http://apis.data.go.kr";

  final String KEY = "발급 받은 ENCODE KEY 입력";

  Future<List<Weather>> getWeatherData(int base_x, int base_y, int base_date, String base_time) async {
    // nx, ny 값 지정
    //
    String url = "$BASE_URL/1360000/VilageFcstInfoService_2.0/getVilageFcst?"
        "serviceKey=$KEY"
        "&pageNo=1&numOfRows=1000&dataType=JSON"
        "&base_date=$base_date"
        "&base_time=$base_time"
        "&nx=$base_x&ny=$base_y";

    final response = await http.get(url);

    List<Weather> weather = [];

    print('============== Response status: ${response.statusCode}');
    if(response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String, dynamic>;

      List<dynamic> _data = [];
      _data = res["response"]["body"]["items"]["item"] as List<dynamic>;

      //예보시간별 컬렉션화
      final _dataByTime = groupBy(_data, (obj) => "${obj["fcstTime"]}").entries.toList();
      for(final _d in _dataByTime) {
        final _result = {
          "fcstDate" : _d.value.first["fcstDate"],
          "fcstTime" : _d.key,
        };

        for(final _r in _d.value) {
          //위의 date와 time을 이용하여 category와 fcstValue 가져오기
          _result[_r["category"]] = _r["category"];
        }

        final weatherResult = Weather.fromJson(_result);
        weather.add(weatherResult);
      }
      return weather;
    } else {
      return weather;
    }

  }
}