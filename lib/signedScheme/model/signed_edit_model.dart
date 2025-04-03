class SignedEditModel {
  int? transactionId;
  String? transDate;
  String? customerName;
  String? schemeName;
  int? quantity;
  int? totalSchemeAmount;
  String? schemeStatus;

  SignedEditModel(
      {this.transactionId,
        this.transDate,
        this.customerName,
        this.schemeName,
        this.quantity,
        this.totalSchemeAmount,
        this.schemeStatus});

  SignedEditModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['TransactionId'];
    transDate = json['TransDate'];
    customerName = json['CustomerName'];
    schemeName = json['SchemeName'];
    quantity = json['Quantity'];
    totalSchemeAmount = json['TotalSchemeAmount'];
    schemeStatus = json['SchemeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TransactionId'] = transactionId;
    data['TransDate'] = transDate;
    data['CustomerName'] = customerName;
    data['SchemeName'] = schemeName;
    data['Quantity'] = quantity;
    data['TotalSchemeAmount'] = totalSchemeAmount;
    data['SchemeStatus'] = schemeStatus;
    return data;
  }
}
