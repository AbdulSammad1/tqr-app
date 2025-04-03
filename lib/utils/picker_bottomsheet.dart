import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/AppDimensions.dart';
import 'package:tqrfamily_bysaz_flutter/utils/Fonts/font_weights.dart';

import 'app_text.dart';
import 'constants.dart';

class PickerBottomSheet extends StatelessWidget {
  final VoidCallback? onCameraClick, onGalleryClick;

  const PickerBottomSheet({Key? key, this.onGalleryClick, this.onCameraClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_camera,color: Constants.PRIMARY_COLOR,),
              title:  AppText(
               text: 'Camera',
                fontSize: AppDimensions.FONT_SIZE_18,
                color: Constants.BLACK_COLOR,
                fontWeight: FontWeights.regular,
              ),
              onTap: onCameraClick,
            ),
            ListTile(
              leading: Icon(Icons.photo_library,color: Constants.PRIMARY_COLOR,),
              title:  AppText(
                text:'Gallery',
                fontSize: AppDimensions.FONT_SIZE_18,
                color: Constants.BLACK_COLOR,
                fontWeight: FontWeights.regular,),
              onTap: onGalleryClick,
            ),
            SizedBox(
              height: Get.height * 0.08,
            )
          ],
        ),
      ),
    );
  }
}