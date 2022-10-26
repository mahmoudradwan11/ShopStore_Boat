class SendOrder{
  bool? status;
  String? message;
  SendData? data;

  SendOrder({this.status, this.message, this.data});

  SendOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SendData.fromJson(json['data']) : null;
  }
}
class SendData {
  String? paymentMethod;
  int? cost;
  int? vat;
  int? discount;
  int? points;
  int? total;
  int? id;
  SendData(
      {this.paymentMethod,
        this.cost,
        this.vat,
        this.discount,
        this.points,
        this.total,
        this.id});

  SendData.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    cost = json['cost'];
    vat = json['vat'];
    discount = json['discount'];
    points = json['points'];
    total = json['total'];
    id = json['id'];
  }
}