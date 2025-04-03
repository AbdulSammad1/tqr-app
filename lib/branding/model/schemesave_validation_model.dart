

class SchemeSaveValidationModel {
  String? message;
  String? status;
  String? uploadFrontPicture;
  String? uploadNewPicture;

  SchemeSaveValidationModel(
      {this.message,
        this.status,
        this.uploadFrontPicture,
        this.uploadNewPicture});

  SchemeSaveValidationModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    status = json['Status'];
    uploadFrontPicture = json['UploadFrontPicture'];
    uploadNewPicture = json['UploadNewPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Status'] = status;
    data['UploadFrontPicture'] = uploadFrontPicture;
    data['UploadNewPicture'] = uploadNewPicture;
    return data;
  }
}

/*class SchemeSaveValidationModel {
  String? message;
  String? status;

  SchemeSaveValidationModel({this.message, this.status});

  SchemeSaveValidationModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Status'] = status;
    return data;
  }
}*/
