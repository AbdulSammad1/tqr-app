

class PointsOutTmModel {
  String? date;
  String? description;
  String? amount;

  PointsOutTmModel({this.date, this.description, this.amount});

  PointsOutTmModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    description = json['Description'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['Description'] = description;
    data['Amount'] = amount;
    return data;
  }
}

