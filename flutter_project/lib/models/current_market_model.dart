import 'dart:convert';

List<Stock> stockFromJson(String str) => List<Stock>.from(json.decode(str).map((x) => Stock.fromJson(x)));

String stockToJson(List<Stock> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stock {
  String tur;
  String satis;
  String alis;
  String degisim;
  String? dOran;
  String? dYon;

  Stock({
    required this.tur,
    required this.satis,
    required this.alis,
    required this.degisim,
    this.dOran,
    this.dYon,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    tur: json["tur"],
    satis: json["satis"],
    alis: json["alis"],
    degisim: json["degisim"],
    dOran: json["d_oran"],
    dYon: json["d_yon"],
  );

  Map<String, dynamic> toJson() => {
    "tur": tur,
    "satis": satis,
    "alis": alis,
    "degisim": degisim,
    "d_oran": dOran,
    "d_yon": dYon,
  };
}
