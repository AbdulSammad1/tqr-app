class AccountModel {
  String? customerName;
  String? customerCategory;
  String? area;
  String? city;
  String? region;
  String? parentCustomer;

  AccountModel(
      {this.customerName,
        this.customerCategory,
        this.area,
        this.city,
        this.region,
        this.parentCustomer});

  AccountModel.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    customerCategory = json['CustomerCategory'];
    area = json['Area'];
    city = json['City'];
    region = json['Region'];
    parentCustomer = json['ParentCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerName'] = customerName;
    data['CustomerCategory'] = customerCategory;
    data['Area'] = area;
    data['City'] = city;
    data['Region'] = region;
    data['ParentCustomer'] = parentCustomer;
    return data;
  }
}
