import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as UI;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:tqrfamily_bysaz_flutter/utils/app_loader.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

import '../../main.dart';
import '../../repository/branding_repo/branding_type_repo/b_new_req.dart';
import '../../repository/branding_repo/ftp_repo/ftp_repo.dart';
import '../../repository/branding_repo/ftp_repo/image_repo.dart';
import '../../repository/branding_repo/save_branding_repo/save_branding_repo.dart';
import '../../utils/utils.dart';
import '../model/b_new_req_btypemodel.dart';
import '../model/b_new_req_model.dart';
import '../model/ftp_image_model.dart';
import '../model/ftp_model.dart';
import '../model/schemesave_validation_model.dart';

class BrandingController extends GetxController {
  final ImagePicker picker = ImagePicker();
  var nameController = TextEditingController();
  var shopNameController = TextEditingController();
  var contact1Controller = TextEditingController();
  var contact2Controller = TextEditingController();
  var addressController = TextEditingController();
  var name = ''.obs;
  var shopName = ''.obs;
  var contact1 = ''.obs;
  var contact2 = ''.obs;
  var address = ''.obs;
  RxBool isSave = false.obs;
  final brandingTypeList = ['Sign board', 'Bill board', 'Simple flex'].obs;
  RxString? selectedValue = 'Branding Type'.obs;
  RxString? langValue = 'Select Language'.obs;
  var languageList = ['English', 'Urdu'].obs;
  UI.TextDirection directionLtr = UI.TextDirection.ltr;
  UI.TextDirection directionRtr = UI.TextDirection.rtl;
  BrandingNewRequest brandingNewRequest = BrandingNewRequest();
  SaveBrandingRepo saveBrandingRepo = SaveBrandingRepo();
  FTPRepo ftpRepo = FTPRepo();
  var nBTypeModel = <NewBTypeModel>[].obs;
  var bNewRequestModel = <BNewRequestModel>[].obs;
  var scSaveValidationModel = <SchemeSaveValidationModel>[].obs;
  var ftpModel = <FTPModel>[].obs;
  var ftpImageModel = <FtpImageModel>[].obs;
  List<dynamic> scSaveValidationList = [];
  List<dynamic> nBTypeList = [];
  List<dynamic> bNewReqList = [];
  List<dynamic> ftpList = [];
  List<dynamic> ftpImageList = [];
  var galleryImage = 'no image'.obs;
  var cameraImage = 'no image'.obs;
  double? progress1;
  var isFtpConnected = false.obs;
  FTPConnect? ftpConnect;
  bool? ftpConnectionSuccessful;
  File uploadFrontFile = File('');
  File uploadBackFile = File('');
  var frontImage = 'nogImage.jpg'.obs;
  //var frontImage1 = 'nogImage1.jpg'.obs;
  var newBImage = 'nocImage.jpg'.obs;
  RxBool fImGSelect = false.obs;
  RxBool bImGSelect = false.obs;
  // var newBImage1 = 'nocImage1.jpg'.obs;
  var isFTP = false.obs;
  ImageNameRepo imageNameRepo = ImageNameRepo();
  Random random = Random();
  var rNum = 4465;
  DateTime now = DateTime.now();
  var userNum = box.read('userNumber') ?? '';
  int? hour;
  int? minute;
  int? second;
  int? millisecond;

  void generateGRandomNum() {
    hour = now.hour;
    minute = now.minute;
    second = now.second;
    millisecond = now.millisecond;
    var currentTime = hour.toString() +
        minute.toString() +
        second.toString() +
        millisecond.toString();

    rNum = random.nextInt(9999);
    if (rNum < 1000) {
      rNum = rNum + 1000;
      // frontImage.value = 'frontImage_$currentTime$rNum.jpg';
      debugPrint('>>>>>>otp num: $rNum  ${frontImage.value}');
    } else {
      //frontImage.value = 'frontImage_$currentTime$rNum.jpg';
    }
  }

  void generateCRandomNum() {
    hour = now.hour;
    minute = now.minute;
    second = now.second;
    millisecond = now.millisecond;
    var currentTime = hour.toString() +
        minute.toString() +
        second.toString() +
        millisecond.toString();

    rNum = random.nextInt(9999);
    if (rNum < 1000) {
      rNum = rNum + 1000;
      //  newBImage.value = 'newBImage_$currentTime$rNum.jpg';
      debugPrint('>>>>>>otp num: $rNum  ${newBImage.value}');
    } else {
      // newBImage.value = 'newBImage_$currentTime$rNum.jpg';
      debugPrint('>>>>>>  ${newBImage.value}<<<<<');
    }
  }

  Future<void> getBrandingTypeData(BuildContext context) async {
    appLoader(context, Constants.PRIMARY_COLOR);
    var data = {
      "SPNAME": "CRMMAP_BrandingSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
      "ReportQueryValue": ["0", "1",  "${box.read('userNumber')}"]
    };
    brandingNewRequest.brandingTypeApi(data).then((value) {
      nBTypeList = jsonDecode(value);
      Get.back();
      for (var element in nBTypeList) {
        nBTypeModel.add(
          NewBTypeModel.fromJson(element),
        );
      }
    }).onError((error, stackTrace) {
      Get.back();
    });
  }

  Future<void> getNewRequestData() async {
    var data = {
      "SPNAME": "CRMMAP_BrandingSP",
      "ReportQueryParameters": ["@nType", "@nsType", "@ContactNo"],
      "ReportQueryValue": ["0", "2", "${box.read('userNumber')}"]
    };
    brandingNewRequest.bNewRequestApi(data).then((value) {
      bNewReqList = jsonDecode(value);
      for (var element in bNewReqList) {
        bNewRequestModel.add(
          BNewRequestModel.fromJson(element),
        );
      }
      nameController.text = bNewRequestModel[0].name ?? '';
      shopNameController.text = bNewRequestModel[0].shopName ?? '';
      contact1Controller.text = bNewRequestModel[0].contactNo ?? '';
      contact2Controller.text = bNewRequestModel[0].contactNo2 ?? '';
      addressController.text = bNewRequestModel[0].address ?? '';
    });
  }

  Future<void> saveBrandingData(var brandingType, userName, shopName, contact1,
      contact2, address, language, upLoadFrontPic, uploadNew) async {
    isSave.value = true;

    print('values $upLoadFrontPic and $uploadNew');

    final appDirectory = await getApplicationDocumentsDirectory();
    final compressedImagesPath = appDirectory.path;

    var frontImagespaths = [];
    var backImagespaths = [];

    List<XFile?> compressedFrontImages =
        List<XFile?>.generate(upLoadFrontPic.length, (_) => null);
    List<XFile?> compressedBackImages =
        List<XFile?>.generate(uploadNew.length, (_) => null);

    for (var i = 0; i < 3; i++) {
      if (upLoadFrontPic[i] != '') {
        frontImagespaths.add(
            '${DateFormat('yyyyMMddHHmmss').format(DateTime.now()).toString()}_${userNum}_frontPic${i + 1}');
      } else {
        frontImagespaths.add('');
      }
      if (uploadNew[i] != '') {
        backImagespaths.add(
            '${DateFormat('yyyyMMddHHmmss').format(DateTime.now()).toString()}_${userNum}_newPic${i + 1}');
      } else {
        backImagespaths.add('');
      }
    }

    for (int i = 0; i < 3; i++) {
      // print('path $path');

      if (upLoadFrontPic[i] != '') {
        compressedFrontImages[i] =
            await FlutterImageCompress.compressAndGetFile(
          upLoadFrontPic[
              i], // Use images[i] instead of images[0] to compress each image
          '$compressedImagesPath/${frontImagespaths[i]}.jpg',
          quality: 28,
        );
      }
      if (uploadNew[i] != '') {
        compressedBackImages[i] = await FlutterImageCompress.compressAndGetFile(
          uploadNew[
              i], // Use images[i] instead of images[0] to compress each image
          '$compressedImagesPath/${backImagespaths[i]}.jpg',
          quality: 28,
        );
      }
    }

    print('front images: $frontImagespaths and $backImagespaths');

    var saveValidationData = {
      "SPNAME": "CRMMAP_BrandingSP",
      "ReportQueryParameters": [
        "@nType",
        "@nsType",
        "@ContactNo",
        "@BrandingType",
        "@Name",
        "@ShopName",
        "@ContactNo1",
        "@ContactNo2",
        "@Address",
        "@Language",
        "@UploadFrontPicture",
        "@UploadNewPicture",
        "@UploadFrontPicture2",
        "@UploadNewPicture2",
        "@UploadNewPicture3",
        "@UploadFrontPicture3"
      ],
      "ReportQueryValue": [
        "0",
        "5",
        "${box.read('userNumber')}",
        "$brandingType",
        "$userName",
        "$shopName",
        "$contact1",
        "$contact2",
        "$address",
        "$language",
        frontImagespaths[0],
        backImagespaths[0],
        frontImagespaths[1],
        backImagespaths[1],
        frontImagespaths[2],
        backImagespaths[2],
      ]
    };

    print('data is $saveValidationData');

    var ftpData = {
      "SPNAME": "CRMMAP_BrandingSP",
      "ReportQueryParameters": ["@nType", "@nsType"],
      "ReportQueryValue": ["0", "6"]
    };
    saveBrandingRepo
        .scSaveValidationApi(saveValidationData)
        .then((value) => {
              scSaveValidationList = jsonDecode(value),
              for (var element in scSaveValidationList)
                {
                  scSaveValidationModel.add(
                    SchemeSaveValidationModel.fromJson(element),
                  ),
                },

              if (scSaveValidationModel[0].status == '1')
                {
                  if (uploadFrontFile.path == '' && uploadBackFile.path == '')
                    {
                      isSave.value = false,
                      Get.back(),
                      Utils.appSnackBar(
                        title: 'Success',
                        subtitle: 'Request created successfully',
                        bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
                      ),
                    }
                  else if (uploadFrontFile.path != '')
                    {
                      //upload ftp image
                      ftpRepo.ftpApi(ftpData).then((value) async => {
                            logger.i('ftp data: $value'),
                            ftpList = jsonDecode(value),
                            for (var element in ftpList)
                              {
                                ftpModel.add(
                                  FTPModel.fromJson(element),
                                ),
                              },
                            ftpConnect = FTPConnect(
                              '${ftpModel[0].ftpAddress}',
                              user: '${ftpModel[0].ftpUserid}',
                              pass: '${ftpModel[0].ftpPassword}',
                              port: int.parse('${ftpModel[0].ftpPort}'),
                              //   debug: true,
                              timeout: 50,
                            ),

                            await ftpConnect
                                ?.connect()
                                .then((value) {})
                                .catchError((e) {
                              isSave.value = false;
                              Utils.appSnackBar(
                                title: 'Error',
                                subtitle: 'Image Upload Failed',
                              );
                              return;
                            }),

                            // if (!(ftpConnectionSuccessful!))
                            //   {

                            //   },

                            await ftpConnect
                                ?.changeDirectory(ftpModel[0].directpath),

                            print(compressedFrontImages),

                            for (int i = 0;
                                i < compressedFrontImages.length;
                                i++)
                              {
                                // print('path $path');

                                if (compressedFrontImages[i] != null)
                                  {
                                    print(compressedFrontImages[i]?.path),
                                    await ftpConnect?.uploadFile(File(
                                        compressedFrontImages[i]?.path ?? '')),
                                  },

                                if (compressedBackImages[i]?.path != null)
                                  {
                                    print(compressedBackImages[i]?.path),
                                    await ftpConnect?.uploadFile(File(
                                        compressedBackImages[i]?.path ?? '')),
                                  }
                              },

                            isSave.value = false,
                            Get.back(),
                            Utils.appSnackBar(
                              title: 'Success',
                              subtitle: 'Request created successfully',
                              bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
                            ),

                            // ftpConnect
                            //     ?.uploadFile(File(frontImage!.path))
                            //     .then((value) async {
                            //   await ftpConnect
                            //       ?.uploadFile(File(newImage!.path));
                            //   isSave.value = false;
                            //   Get.back();
                            //   Utils.appSnackBar(
                            //     title: 'Success',
                            //     subtitle: 'Request created successfully',
                            //     bgColor:
                            //         Constants.PRIMARY_COLOR.withOpacity(0.8),
                            //   );
                            // }
                            // ),
                          }),
                    }
                }
              else
                {
                  isSave.value = false,
                  Utils.appSnackBar(
                    title: 'Error',
                    subtitle: '${scSaveValidationModel[0].message}',
                  ),
                },
              // debugPrint('>>>>>>save validation data: $value'),
            })
        .onError((error, stackTrace) => {
              isSave.value = false,
              // logger.w('------------> save validation error: $error'),
            });
  }

  dynamic newPath;

  Future<void> ftpConnectMethod() async {
    var data = {
      "SPNAME": "CRMMAP_BrandingSP",
      "ReportQueryParameters": ["@nType", "@nsType"],
      "ReportQueryValue": ["0", "6"]
    };
    ftpRepo
        .ftpApi(data)
        .then((value) => {
              // logger.i('ftp data: $value'),
              ftpList = jsonDecode(value),
              for (var element in ftpList)
                {
                  ftpModel.add(
                    FTPModel.fromJson(element),
                  ),
                },
              ftpConnect = FTPConnect(
                '${ftpModel[0].ftpAddress}',
                user: '${ftpModel[0].ftpUserid}',
                pass: '${ftpModel[0].ftpPassword}',
                port: int.parse('${ftpModel[0].ftpPort}'),
                //  debug: true,
              ),
              ftpConnect?.changeDirectory(ftpModel[0].directpath),

              ftpConnect!.connect().then((value) => {
                    ftpConnect?.uploadFile(uploadFrontFile,
                        onProgress: (double? progress, int one, int two) {
                      progress1 = progress!;
                      if (progress == 100) {
                        // logger.i('progress: $progress1');
                        Utils.appSnackBar(
                          title: 'Success',
                          subtitle: 'Request created successfully',
                          bgColor: Constants.PRIMARY_COLOR.withOpacity(0.8),
                        );
                      }
                    }),
                  }),
              // logger.i('ftp connect: $ftpConnect'),
            })
        .onError((error, stackTrace) => {
              isSave.value = false,
              // logger.w('Error while connecting with ftp: $error'),
            });
  }

  Future<void> ftpImageName() async {
    var data = {
      "SPNAME": "CRMMAP_BrandingSP",
      "ReportQueryParameters": [
        "@nType",
        "@nsType",
        "@UploadFrontPicture",
        "@UploadNewPicture"
      ],
      "ReportQueryValue": ["0", "7", "", ""]
    };
    imageNameRepo.imageNameApi(data).then((value) => {
          ftpImageList = jsonDecode(value),
          for (var element in ftpImageList)
            {
              ftpImageModel.add(
                FtpImageModel.fromJson(element),
              ),
            },
          frontImage.value = ftpImageModel[0].uploadFrontPicture ?? '',
          newBImage.value = ftpImageModel[0].uploadNewPicture ?? '',
          // logger.i('frontImage: ${frontImage.value} : newImage: ${newBImage.value}'),
        });
  }

  Future<String> pickFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    String newPath = '';
    if (pickedFile != null) {
      logger.i('original imagePathG: ${pickedFile.path}');
      String dir = path.dirname(pickedFile.path);
      newPath = path.join(dir, frontImage.value);
      //  logger.i('newPath: $newPath');
      pickedFile.saveTo(newPath);
      uploadFrontFile = File(newPath);
      fImGSelect.value = true;
      // logger.i('frontImage : $uploadFrontFile');
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
    return newPath;
  }

  Future<String> pickFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    String newPath = '';
    if (pickedFile != null) {
      // cameraImage.value = pickedFile.path.split('/').last;
      logger.i('original imagePathC: ${pickedFile.path}');
      String dir = path.dirname(pickedFile.path);
      newPath = path.join(dir, frontImage.value);
      //  logger.i('newPath: $newPath');
      pickedFile.saveTo(newPath);
      uploadFrontFile = File(newPath);
      fImGSelect.value = true;
      // logger.i('newBackImg : ${uploadFrontFile.path}');
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
    // final pickedFile =
    // await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    // if (pickedFile != null) {
    //   // cameraImage.value = pickedFile.path.split('/').last;
    //   logger.i('original imagePathC: ${pickedFile.path}');
    //   String dir = path.dirname(pickedFile.path);
    //   String newPath = path.join(dir, newBImage.value);
    //   //  logger.i('newPath: $newPath');
    //   pickedFile.saveTo(newPath);
    //   uploadBackFile = File(newPath);
    //   logger.i('newBackImg : $uploadBackFile');
    // } else {
    //   if (kDebugMode) {
    //     print('No image selected.');
    //   }
    // }

    return newPath;
  }

  Future<String> pickFromGallery1() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    String newPath = '';
    if (pickedFile != null) {
      // logger.i('original imagePathG1: ${pickedFile.path}');
      String dir = path.dirname(pickedFile.path);
      newPath = path.join(dir, newBImage.value);
      //  logger.i('newPath: $newPath');
      pickedFile.saveTo(newPath);
      uploadBackFile = File(newPath);
      bImGSelect.value = true;

      // logger.i('newBImageGl1 : $uploadBackFile');
    } else {
      if (kDebugMode) {
        print('No image selected1.');
      }
    }

    return newPath;
  }

  Future<String> pickFromCamera1() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    String newPath = '';
    if (pickedFile != null) {
      // cameraImage.value = pickedFile.path.split('/').last;
      // logger.i('original imagePathC1: ${pickedFile.path}');
      String dir = path.dirname(pickedFile.path);
      newPath = path.join(dir, newBImage.value);
      //  logger.i('newPath: $newPath');
      pickedFile.saveTo(newPath);
      uploadBackFile = File(newPath);
      bImGSelect.value = true;
      // logger.i('newBackImgC1 : $uploadBackFile');
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }

    return newPath;
  }
}
