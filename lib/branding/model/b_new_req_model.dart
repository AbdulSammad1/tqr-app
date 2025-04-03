

class BNewRequestModel {
  String? name;
  String? shopName;
  String? contactNo;
  String? contactNo2;
  String? address;

  BNewRequestModel(
      {this.name,
        this.shopName,
        this.contactNo,
        this.contactNo2,
        this.address});

  BNewRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    shopName = json['ShopName'];
    contactNo = json['ContactNo'];
    contactNo2 = json['ContactNo2'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['ShopName'] = shopName;
    data['ContactNo'] = contactNo;
    data['ContactNo2'] = contactNo2;
    data['Address'] = address;
    return data;
  }
}
