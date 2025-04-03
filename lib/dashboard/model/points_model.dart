class PointsModel {
  String? walletBalance;

  PointsModel({this.walletBalance});

  PointsModel.fromJson(Map<String, dynamic> json) {
    walletBalance = json['WalletBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['WalletBalance'] = walletBalance;
    return data;
  }
}
