class AllTimeBlncModel {
  int? openingBalance;
  String? closingBalance;

  AllTimeBlncModel({this.openingBalance, this.closingBalance});

  AllTimeBlncModel.fromJson(Map<String, dynamic> json) {
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
