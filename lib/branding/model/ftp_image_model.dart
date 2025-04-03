class FtpImageModel {
  String? uploadFrontPicture;
  String? uploadNewPicture;

  FtpImageModel({this.uploadFrontPicture, this.uploadNewPicture});

  FtpImageModel.fromJson(Map<String, dynamic> json) {
    uploadFrontPicture = json['UploadFrontPicture'];
    uploadNewPicture = json['UploadNewPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UploadFrontPicture'] = uploadFrontPicture;
    data['UploadNewPicture'] = uploadNewPicture;
    return data;
  }
}
