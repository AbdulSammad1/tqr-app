import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../repository/item_list_repo/item_list_repo.dart';
import '../model/item_list_model.dart';

class ItemListController extends GetxController {
  ScrollController scrollController = ScrollController();
  ItemListRepository itemListRepository = ItemListRepository();
  var itemListModel = <ItemListModel>[].obs;
  List<dynamic> itemList = [];
  var dateTime = ''.obs;

  void currentDateOnly() {
    var date = DateTime.now();
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    dateTime.value = formattedDate;
  }

  void getItemList() {
    var data = {
      "SPNAME": "CRMMAP_PublicitySP",
      "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
      "ReportQueryValue": ["0", "0", "${box.read('userNumber')}"]
    };
    itemListRepository.itemListApi(data).then((value) {
      itemList = jsonDecode(value);
      itemList
          .map((e) => itemListModel.add(ItemListModel.fromJson(e)))
          .toList();
      // print('------------> Date: ${itemListModel[0].itemName}');
    }).onError((error, stackTrace) {
      // print('error: $error');
    });
  }

  @override
  void onInit() {
    getItemList();
    currentDateOnly();
    super.onInit();
  }
}
