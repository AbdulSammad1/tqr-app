class SummaryTmModel {
  String? totalPointsIn;
  String? totalPointsOut;
  String? totalBalancePoints;

  SummaryTmModel(
      {this.totalPointsIn, this.totalPointsOut, this.totalBalancePoints});

  SummaryTmModel.fromJson(Map<String, dynamic> json) {
    totalPointsIn = json['Total Points In'];
    totalPointsOut = json['Total Points Out'];
    totalBalancePoints = json['Total Balance Points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Total Points In'] = totalPointsIn;
    data['Total Points Out'] = totalPointsOut;
    data['Total Balance Points'] = totalBalancePoints;
    return data;
  }
}
