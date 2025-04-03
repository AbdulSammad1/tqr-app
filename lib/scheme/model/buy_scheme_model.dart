

class BuySchemeModel {
  String? schemeName;
  String? attachmentPath;

  BuySchemeModel({this.schemeName, this.attachmentPath});

  BuySchemeModel.fromJson(Map<String, dynamic> json) {
    schemeName = json['SchemeName'];
    attachmentPath = json['AttachmentPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SchemeName'] = schemeName;
    data['AttachmentPath'] = attachmentPath;
    return data;
  }
}
