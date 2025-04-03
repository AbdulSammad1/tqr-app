
class SignedHistoryModel {
  int? transactionId;
  String? transDate;
  String? shopName;
  int? quantity;
  String? status;

  SignedHistoryModel(
      {this.transactionId, this.transDate, this.shopName, this.quantity, this.status,});

  SignedHistoryModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['TransId'];
    transDate = json['TransDate'];
    shopName = json['ShopName'];
    quantity = json['Quantity'];
    status = json['SchemeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TransId'] = transactionId;
    data['TransDate'] = transDate;
    data['ShopName'] = shopName;
    data['Quantity'] = quantity;
    data['SchemeStatus'] = status;
    return data;
  }
}
