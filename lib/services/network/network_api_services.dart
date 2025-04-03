import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:tqrfamily_bysaz_flutter/services/network/base_api_services.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

import '../../utils/constants.dart';
import '../exceptions/app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> post(String url, dynamic body) async {
    if(kDebugMode){
      // print('---> POST URL: $url');
    }
    dynamic responseJson;
    try {
      final response = await dio.Dio().post(
        url,
        //if data in form data then use this
        data: body,
        //if data in raw form then use this
        //data: jsonEncode(body),
        /*options: dio.Options(
          sendTimeout: 5000,
          receiveTimeout: 3000,
        ),*/
      ).timeout(const Duration(seconds: 15));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('No Internet Connection');
    } on TimeoutException {
      Utils.appSnackBar(title: 'Error', subtitle: 'Request Time Out',bgColor: Constants.SECONDRY_COLOR,);
      throw RequestTimeOutException('Request Time Out');
    } on dio.DioError {
      throw BadRequestException('Bad Request');
    } catch (e) {
      throw ServerException('Internal Server Error: $e');
    }
    /*if(kDebugMode){
      print('responsePost:-->  $responseJson');
    }*/
    return responseJson;
  }

  @override
  Future get(String url) async {
    if(kDebugMode){
      print('---> URL: $url');
    }
    dynamic responseJson;
    try {
      final response = await dio.Dio().get(
        url,
      ).timeout(const Duration(seconds: 15));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('No Internet Connection');
    } on TimeoutException {
      throw RequestTimeOutException('Request Time Out');
    } on dio.DioError {
      throw BadRequestException('Bad Request');
    } catch (e) {
      throw ServerException('Internal Server Error: $e');
    }
    if(kDebugMode){
      print('responseGet:-->  $responseJson');
    }
    return responseJson;
  }

  returnResponse(dio.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;
      case 400:
        throw InvalidUrlException;
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
