import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:tqrfamily_bysaz_flutter/main.dart';
import 'package:tqrfamily_bysaz_flutter/notification/model/notificationModel.dart';
import 'package:tqrfamily_bysaz_flutter/services/app_urls.dart';

import '../../repository/notification_repo/notification_repo.dart';

class NotificationController extends GetxController {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final NotificationRepo _notificationRepo = NotificationRepo();
  List notificationList = [].obs;
  var notificationModel = <NotificationModel>[].obs;
  var scrollController = ScrollController();
  RxInt count = 0.obs;
  Timer? timer;
  final RxBool isLoading = true.obs;
  static final onNotifications = BehaviorSubject<String?>();
  var lastNotification = ''.obs;

  void resetNotificationCount() {
    count = 0.obs;
  }

  Future getNotificationData() async {
    var data = {
      "SPNAME": "CRMMAP_WalletSP",
      "ReportQueryParameters": [
        "@nType",
        "@nsType",
        "@AllowedTo",
        "@ContactNo",
      ],
      "ReportQueryValue": [
        "0",
        "20",
        box.read('isDLogin') == true ? "Distributor" : "Retailer",
        "${box.read('userNumber')}"
      ]
    };
    try {
      var value = await _notificationRepo.notificationApi(data);
      notificationList = jsonDecode(value);
      notificationModel.value =
          notificationList.map((e) => NotificationModel.fromJson(e)).toList();
      // await getNotificationCount();
      print('hello notification');
      // count.value = notificationModel.length;
      isLoading.value = false;
      lastNotification.value = '${notificationModel.last.notification}';
    } catch (error) {
      isLoading.value = false;
      // Handle the error if needed.
    }
  }

  Future<List<dynamic>> getNotificationCount(
    String deviceId,
  ) async {
    final apiUrl = Uri.parse(AppUrls().NOTIFICATION_URL);
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'SPNAME': 'CRMMAP_WalletSP',
      'ReportQueryParameters': [
        '@nType',
        '@nsType',
        '@AllowedTo',
        '@ContactNo',
        '@DeviceId',
        '@Password',
      ],
      'ReportQueryValue': [
        "0",
        "33",
        box.read('isDLogin') == true ? "Distributor" : "Retailer",
        "${box.read('userNumber')}",
        '$deviceId-${box.read('userNumber')}',
        box.read('isDistributorLogin') == true ? box.read('distroPassword') : ''
      ]
    });

    print('password is ${box.read('distroPassword')}');

    final response = await http.post(apiUrl, headers: headers, body: body);

    print('notification device ID: $deviceId-${box.read('userNumber')}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      print('notification response: $data');
      final status = data[0]['Count'];
      print(status);

      count.value = status;

      return data;
    } else {
      throw Exception('Failed to connect to the API');
    }
  }

  Future<String> getLatestNotification() async {
    final apiUrl = Uri.parse(AppUrls().NOTIFICATION_URL);
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'SPNAME': 'CRMMAP_WalletSP',
      'ReportQueryParameters': [
        '@nType',
        '@nsType',
        '@AllowedTo',
        '@ContactNo'
      ],
      'ReportQueryValue': [
        "0",
        "36",
        box.read('isDLogin') == true ? "Distributor" : "Retailer",
        "${box.read('userNumber')}"
      ]
    });

    final response = await http.post(apiUrl, headers: headers, body: body);

    print('response: $response');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final status = data[0]['Notification'];
      print(status);

      lastNotification.value = status;

      return status;
    } else {
      throw Exception('Failed to connect to the API');
    }
  }

  Stream<int> getNotificationCountStream(BuildContext context) {
    final streamController = StreamController<int>();

    _fetchNotificationCount(streamController);

    return streamController.stream;
  }

  void _fetchNotificationCount(StreamController<int> streamController) async {
    final apiUrl = Uri.parse(AppUrls().NOTIFICATION_URL);
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'SPNAME': 'CRMMAP_WalletSP',
      'ReportQueryParameters': [
        '@nType',
        '@nsType',
        '@AllowedTo',
        '@ContactNo',
      ],
      'ReportQueryValue': [
        "0",
        "33",
        box.read('isDLogin') == true ? "Distributor" : "Retailer",
        "${box.read('userNumber')}"
      ]
    });

    final response = await http.post(apiUrl, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final status = data[0]['Count'];

      streamController.add(status);
      streamController.close();
    } else {
      streamController.addError(Exception('Failed to connect to the API'));
    }
  }

  Future<void> refreshNotificationData() async {
    await getLatestNotification().then((value) => {
          print('show notification'),
          showNotificationMethod(
            title: 'TQR Notification',
            body: lastNotification.value,
            payload: 'notification_Screen',
          ),
        });
  }

  //old code
  static Future showNotificationMethod(
      {int id = 0, String? title, String? body, String? payload}) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetail(),
      payload: payload,
    );
  }

  static Future notificationDetail() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
        icon: 'flutter_logo',
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future initialize() async {
    var androidInitialize = const AndroidInitializationSettings('flutter_logo');
    const iOS = DarwinInitializationSettings();
    final settings = InitializationSettings(
      android: androidInitialize,
      iOS: iOS,
    );

    await flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: (payload) async {
      onNotifications.add(payload.toString());
    });
  }

  @override
  void refresh() async {
    isLoading.value = true;
    notificationModel.clear();
    await getNotificationData();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getNotificationData();
  // }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }
}
