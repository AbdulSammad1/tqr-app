class SignedUpdateModel {
  String? schemeStatus;

  SignedUpdateModel({this.schemeStatus});

  SignedUpdateModel.fromJson(Map<String, dynamic> json) {
    schemeStatus = json['SchemeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SchemeStatus'] = schemeStatus;
    return data;
  }
}
