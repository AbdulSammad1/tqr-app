
class PointsOutModel {
  String? date;
  String? description;
  String? amount;

  PointsOutModel({this.date, this.description, this.amount});

  PointsOutModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    description = json['Description'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Date'] = date;
    data['Description'] = description;
    data['Amount'] = amount;
    return data;
  }
}
