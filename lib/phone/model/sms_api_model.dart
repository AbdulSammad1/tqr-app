class SmsApiModel {
  String? sMSApi;

  SmsApiModel({this.sMSApi});

  SmsApiModel.fromJson(Map<String, dynamic> json) {
    sMSApi = json['SMSApi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SMSApi'] = sMSApi;
    return data;
  }
}
