class PointsValidateModel {
  String? messagebox;
  int? status;

  PointsValidateModel({this.messagebox, this.status});

  PointsValidateModel.fromJson(Map<String, dynamic> json) {
    messagebox = json['Messagebox'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Messagebox'] = messagebox;
    data['Status'] = status;
    return data;
  }
}
