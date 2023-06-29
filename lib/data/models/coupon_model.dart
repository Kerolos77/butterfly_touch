class CouponModel {
  late String coupon;
  late String startDate;
  late String endDate;

  CouponModel({
    required this.coupon,
    required this.startDate,
    required this.endDate,
  });

  CouponModel.fromJson(dynamic json) {
    coupon = json['coupon'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['coupon'] = coupon;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    return map;
  }
}
