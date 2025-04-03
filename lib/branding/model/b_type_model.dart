class BTypeModel {
  String? item;
  String? rate;
  int? minimumAdvance;

  BTypeModel({this.item, this.rate, this.minimumAdvance});

  BTypeModel.fromJson(Map<String, dynamic> json) {
    item = json['Item'];
    rate = json['Rate'];
    minimumAdvance = json['MinimumAdvance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Item'] = item;
    data['Rate'] = rate;
    data['MinimumAdvance'] = minimumAdvance;
    return data;
  }
}
