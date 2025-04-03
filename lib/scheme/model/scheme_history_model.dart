class SchemeHistoryModel {
  String? date;
  String? qty;
  String? schemeName;
  String? schemeStatus;

  SchemeHistoryModel({this.date, this.qty, this.schemeName, this.schemeStatus});

  SchemeHistoryModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    qty = json['Qty'];
    schemeName = json['Scheme Name'];
    schemeStatus = json['SchemeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['Qty'] = qty;
    data['Scheme Name'] = schemeName;
    data['SchemeStatus'] = schemeStatus;
    return data;
  }
}

