class FTPModel {
  String? ftpAddress;
  String? ftpPort;
  String? ftpUserid;
  String? ftpPassword;
  String? directpath;

  FTPModel(
      {this.ftpAddress,
        this.ftpPort,
        this.ftpUserid,
        this.ftpPassword,
        this.directpath});

  FTPModel.fromJson(Map<String, dynamic> json) {
    ftpAddress = json['FtpAddress'];
    ftpPort = json['FtpPort'];
    ftpUserid = json['FtpUserid'];
    ftpPassword = json['FtpPassword'];
    directpath = json['Directpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FtpAddress'] = ftpAddress;
    data['FtpPort'] = ftpPort;
    data['FtpUserid'] = ftpUserid;
    data['FtpPassword'] = ftpPassword;
    data['Directpath'] = directpath;
    return data;
  }
}
