class BarcodeModel {
  late String barcode;
  late bool isGood;
  late String description;

  BarcodeModel({
    required this.barcode,
    required this.isGood,
    required this.description,
  });

  BarcodeModel.fromJson(dynamic json) {
    barcode = json['barcode'];
    isGood = json['isGood'];
    description = json['description'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['barcode'] = barcode;
    map['isGood'] = isGood;
    map['description'] = description;
    return map;
  }
}
