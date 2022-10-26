class CancelOrder {
  bool? status;
  String? message;
  Data? data;

  CancelOrder({this.status, this.message, this.data});

  CancelOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  int? cost;
  int? discount;
  int? points;
  int? vat;
  int? total;
  int? pointsCommission;
  String? promoCode;
  String? paymentMethod;

  Data(
      {this.id,
        this.cost,
        this.discount,
        this.points,
        this.vat,
        this.total,
        this.pointsCommission,
        this.promoCode,
        this.paymentMethod});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
    discount = json['discount'];
    points = json['points'];
    vat = json['vat'];
    total = json['total'];
    pointsCommission = json['points_commission'];
    promoCode = json['promo_code'];
    paymentMethod = json['payment_method'];
  }

}