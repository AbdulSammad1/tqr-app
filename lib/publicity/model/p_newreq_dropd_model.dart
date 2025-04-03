class PNewReqDropDModel {
  String? itemName;
  String? miniQty;
  String? rate;

  PNewReqDropDModel({this.itemName, this.miniQty, this.rate});

  PNewReqDropDModel.fromJson(Map<String, dynamic> json) {
    itemName = json['ItemName'];
    miniQty = json['MiniQty'];
    rate = json['Rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ItemName'] = itemName;
    data['MiniQty'] = miniQty;
    data['Rate'] = rate;
    return data;
  }
}
