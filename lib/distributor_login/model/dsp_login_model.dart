

class DspLoginModel {
  String? customerName;
  String? contactNo;
  // List<int>? password;
  

  DspLoginModel({this.customerName, this.contactNo, 
  // this.password
  });

  DspLoginModel.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    contactNo = json['ContactNo'];
    // password = json['Password'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerName'] = customerName;
    data['ContactNo'] = contactNo;
    // data['Password'] = password;
    return data;
  }
}
