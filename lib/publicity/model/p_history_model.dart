

class PHistoryModel {
  String? transactionNo;
  String? status;
  String? requestDate;
  String? item;
  String? qty;
  String? rate;
  String? amount;
  String? name;
  String? shopName;
  String? contactNo;
  String? contactNo2;
  String? address;
  String? language;

  PHistoryModel(
      {this.transactionNo,
      this.status,
      this.requestDate,
      this.item,
      this.qty,
      this.rate,
      this.amount,
      this.name,
      this.shopName,
      this.contactNo,
      this.contactNo2,
      this.address,
      this.language});

  PHistoryModel.fromJson(Map<String, dynamic> json) {
    transactionNo = json['TransactionNo'];
    status = json['Status'];
    requestDate = json['RequestDate'];
    item = json['Item'];
    qty = json['Qty'];
    rate = json['Rate'];
    amount = json['Amount'];
    name = json['Name'];
    shopName = json['ShopName'];
    contactNo = json['ContactNo'];
    contactNo2 = json['ContactNo2'];
    address = json['Address'];
    language = json['Language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TransactionNo'] = transactionNo;
    data['Status'] = status;
    data['RequestDate'] = requestDate;
    data['Item'] = item;
    data['Qty'] = qty;
    data['Rate'] = rate;
    data['Amount'] = amount;
    data['Name'] = name;
    data['ShopName'] = shopName;
    data['ContactNo'] = contactNo;
    data['ContactNo2'] = contactNo2;
    data['Address'] = address;
    data['Language'] = language;
    return data;
  }
}
