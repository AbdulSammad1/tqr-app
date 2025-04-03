class PointHistoryModel {
  int? requestNo;
  String? requestDate;
  String? requestbyNo;
  String? requestbyName;
  int? requestedPoint;

  PointHistoryModel(
      {this.requestNo,
        this.requestDate,
        this.requestbyNo,
        this.requestbyName,
        this.requestedPoint});

  PointHistoryModel.fromJson(Map<String, dynamic> json) {
    requestNo = json['RequestNo'];
    requestDate = json['RequestDate'];
    requestbyNo = json['RequestbyNo'];
    requestbyName = json['RequestbyName'];
    requestedPoint = json['RequestedPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RequestNo'] = requestNo;
    data['RequestDate'] = requestDate;
    data['RequestbyNo'] = requestbyNo;
    data['RequestbyName'] = requestbyName;
    data['RequestedPoint'] = requestedPoint;
    return data;
  }
}
