class PNReqVlidationModel {
  String? message;
  int? status;

  PNReqVlidationModel({this.message, this.status});

  PNReqVlidationModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Status'] = status;
    return data;
  }
}
