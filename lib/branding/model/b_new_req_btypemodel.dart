class NewBTypeModel {
  String? brandingType;

  NewBTypeModel({this.brandingType});

  NewBTypeModel.fromJson(Map<String, dynamic> json) {
    brandingType = json['BrandingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BrandingType'] = brandingType;
    return data;
  }
}
