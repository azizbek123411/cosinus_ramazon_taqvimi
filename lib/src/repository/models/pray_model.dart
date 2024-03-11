class PrayModel {
  String region;
  DateTime date;
  String weekday;
  String? hijriyOy;
  int? hijriyKun;
  String saharlik;
  String quyosh;
  String peshin;
  String asr;
  String shom;
  String xufton;

  PrayModel({
    required this.weekday,
    required this.region,
    required this.date,
    this.hijriyKun,
    this.hijriyOy,
    required this.quyosh,
    required this.asr,
    required this.peshin,
    required this.saharlik,
    required this.shom,
    required this.xufton,
  });

  factory PrayModel.fromJson(Map<String, dynamic> json) {
    return PrayModel(
      weekday: json['weekday'],
      region: json['region'],
      date: DateTime.parse(json['date']),
      hijriyKun: json['hijri_date']['day'],
      hijriyOy: json['hijri_date']['month'],
      quyosh: json['times']['quyosh'],
      asr: json['times']['asr'],
      peshin: json['times']['peshin'],
      saharlik: json['times']['tong_saharlik'],
      shom: json['times']['shom_iftor'],
      xufton: json['times']['hufton'],
    );
  }
}
