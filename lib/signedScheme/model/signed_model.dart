
class SignedSchemeModel {
  int? transactionId;
  String? transDate;
  String? shopName;
  int? quantity;
  String? status;

  SignedSchemeModel(
      {this.transactionId, this.transDate, this.shopName, this.quantity, this.status});

  SignedSchemeModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['TransactionId'];
    transDate = json['TransDate'];
    shopName = json['ShopName'];
    quantity = json['Quantity'];
    status = json['SchemeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TransactionId'] = transactionId;
    data['TransDate'] = transDate;
    data['ShopName'] = shopName;
    data['Quantity'] = quantity;
    data['SchemeStatus'] = status;
    return data;
  }
}
