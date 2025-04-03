class ThisMonthBlncModel {
  String? openingBalance;
  String? closingBalance;

  ThisMonthBlncModel({this.openingBalance, this.closingBalance});

  ThisMonthBlncModel.fromJson(Map<String, dynamic> json) {
    openingBalance = json['OpeningBalance'];
    closingBalance = json['ClosingBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OpeningBalance'] = openingBalance;
    data['ClosingBalance'] = closingBalance;
    return data;
  }
}
