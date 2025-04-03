class OtpModel {
  String? success;
  String? type;
  String? totalprice;
  String? totalgsm;
  String? remaincredit;
  List<Results>? results;

  OtpModel(
      {this.success,
        this.type,
        this.totalprice,
        this.totalgsm,
        this.remaincredit,
        this.results});

  OtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    type = json['type'];
    totalprice = json['totalprice'];
    totalgsm = json['totalgsm'];
    remaincredit = json['remaincredit'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['type'] = type;
    data['totalprice'] = totalprice;
    data['totalgsm'] = totalgsm;
    data['remaincredit'] = remaincredit;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? status;
  String? messageid;
  String? gsm;

  Results({this.status, this.messageid, this.gsm});

  Results.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageid = json['messageid'];
    gsm = json['gsm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['messageid'] = messageid;
    data['gsm'] = gsm;
    return data;
  }
}
