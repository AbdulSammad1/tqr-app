class TransferPointModel {
  String? customerName;
  int? cusomerid;
  String? contactNo;
  String? region;
  String? city;
  int? status;
  String? message;
  String? areaName;

  TransferPointModel(
      {this.customerName,
      this.cusomerid,
      this.contactNo,
      this.region,
      this.city, this.status, this.message, this.areaName});

  TransferPointModel.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    cusomerid = json['Cusomerid'];
    contactNo = json['ContactNo'];
    region = json['Region'];
    city = json['City'];
    status = json['Status'];
    message = json['MessageCaption'];
    areaName = json['Area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerName'] = customerName;
    data['Cusomerid'] = cusomerid;
    data['ContactNo'] = contactNo;
    data['Region'] = region;
    data['City'] = city;
    data['Status'] = status;
    data['MessageCaption'] = message;
    data['Area'] = areaName;
    return data;
  }
}

