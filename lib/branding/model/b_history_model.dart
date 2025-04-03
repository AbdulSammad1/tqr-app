

class BHistoryModel {
  String? transactionNo;
  String? shopName1;
  String? status;
  String? requestDate;
  String? brandingType;
  String? name;
  String? shopName;
  String? contactNo;
  String? contactNo2;
  String? address;
  String? language;

  BHistoryModel(
      {this.transactionNo,
        this.shopName1,
        this.status,
        this.requestDate,
        this.brandingType,
        this.name,
        this.shopName,
        this.contactNo,
        this.contactNo2,
        this.address,
        this.language});

  BHistoryModel.fromJson(Map<String, dynamic> json) {
    transactionNo = json['TransactionNo'];
    shopName1 = json['ShopName1'];
    status = json['Status'];
    requestDate = json['Request Date'];
    brandingType = json['BrandingType'];
    name = json['Name'];
    shopName = json['Shop Name'];
    contactNo = json['ContactNo'];
    contactNo2 = json['ContactNo2'];
    address = json['Address'];
    language = json['Language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TransactionNo'] = transactionNo;
    data['ShopName1'] = shopName1;
    data['Status'] = status;
    data['Request Date'] = requestDate;
    data['BrandingType'] = brandingType;
    data['Name'] = name;
    data['Shop Name'] = shopName;
    data['ContactNo'] = contactNo;
    data['ContactNo2'] = contactNo2;
    data['Address'] = address;
    data['Language'] = language;
    return data;
  }
}


/*class BHistoryModel {
  String? transactionNo;
  String? status;
  String? requestDate;
  String? brandingType;
  String? name;
  String? shopName;
  String? contactNo;
  String? contactNo2;
  String? address;
  String? language;

  BHistoryModel(
      {this.transactionNo,
        this.status,
        this.requestDate,
        this.brandingType,
        this.name,
        this.shopName,
        this.contactNo,
        this.contactNo2,
        this.address,
        this.language});

  BHistoryModel.fromJson(Map<String, dynamic> json) {
    transactionNo = json['TransactionNo'];
    status = json['Status'];
    requestDate = json['RequestDate'];
    brandingType = json['BrandingType'];
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
    data['BrandingType'] = brandingType;
    data['Name'] = name;
    data['ShopName'] = shopName;
    data['ContactNo'] = contactNo;
    data['ContactNo2'] = contactNo2;
    data['Address'] = address;
    data['Language'] = language;
    return data;
  }
}*/
