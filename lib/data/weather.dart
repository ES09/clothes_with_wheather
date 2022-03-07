class Weather {
  String date;
  int time;

  int pty; //강수형태
  int pop; //강수확률
  String pcp; //강수량

  double wsd; //풍속
  int sky; //하늘상태

  int reh; //습도
  int tmp; //온도

  Weather({this.date, this.time, this.pty, this.pop, this.pcp, this.wsd, this.sky, this.reh, this.tmp});

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      date : data["fcstDate"],
      time : int.tryParse(data["fcstTime"] ?? "") ?? 0,
      pty : int.tryParse(data["PTY"] ?? "") ?? 0,
      pop : int.tryParse(data["POP"] ?? "") ?? 0,
      pcp : data["PCP"],
      wsd : double.tryParse(data["WSD"] ?? "") ?? 0,
      sky: int.tryParse(data["SKY"] ?? "") ?? 0,
      reh : int.tryParse(data["REH"] ?? "") ?? 0,
      tmp: int.tryParse(data["TMP"] ?? "") ?? 0,
    );
  }
}