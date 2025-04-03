class NotificationModel {
  String? date;
  String? attachment;
  String? notification;
  bool? isSeen;

  NotificationModel({this.date, this.attachment, this.notification, this.isSeen});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    attachment = json['Attachment'];
    notification = json['Notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['Attachment'] = attachment;
    data['Notification'] = notification;
    return data;
  }
}
