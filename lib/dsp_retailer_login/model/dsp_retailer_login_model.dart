class DspRetailerLoginModel {
  String? customerName;
  int? cusomerid;
  String? contactNo;
  String? region;
  String? city;

  DspRetailerLoginModel(
      {this.customerName,
        this.cusomerid,
        this.contactNo,
        this.region,
        this.city});

  DspRetailerLoginModel.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    cusomerid = json['Cusomerid'];
    contactNo = json['ContactNo'];
    region = json['Region'];
    city = json['City'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerName'] = customerName;
    data['Cusomerid'] = cusomerid;
    data['ContactNo'] = contactNo;
    data['Region'] = region;
    data['City'] = city;
    return data;
  }
}
