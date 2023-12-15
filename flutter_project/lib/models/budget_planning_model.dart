class Gelir {
  int id;
  String type;
  double tutar;
  DateTime creationTime;
  DateTime updateTime;

  Gelir(
      {required this.id,
        required this.type,
        required this.tutar,
        required this.creationTime,
        required this.updateTime});

  factory Gelir.fromJson(Map<String, dynamic> json) {
    return Gelir(
        id: int.parse(json['id']),
        type: json['subcategory_name'] as String,
        tutar: double.parse(json['amount'].toString()),
        creationTime: DateTime.parse(json['creation_time'].toString()),
        updateTime: DateTime.parse(json['update_time'].toString()));
  }
}

class GetGelirCategories {
  int id;
  int userId;
  int categoryId;
  String type;

  GetGelirCategories(
      {required this.id, required this.userId,required this.categoryId, required this.type});

  factory GetGelirCategories.fromJson(Map<String, dynamic> json) {
    return GetGelirCategories(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      categoryId: json['category_id'] as int,
      type: json['subcategory_name'].toString(),
    );
  }

}

