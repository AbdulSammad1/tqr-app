import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tqrfamily_bysaz_flutter/main.dart';
import 'package:tqrfamily_bysaz_flutter/my_account/controller/account_controller.dart';
import 'package:tqrfamily_bysaz_flutter/my_account/widget/text_field_widget.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';

import '../../common/custome_appbar.dart';
import '../../res/routes/route_name.dart';
import '../../utils/utils.dart';

class ChangepasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';

  const ChangepasswordScreen({
    super.key,
  });

  @override
  State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  bool _isLoading = false;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              title: 'Change Password',
              color: Colors.transparent,
              width: 0,
              height: 0,
              buttonWidth: 50.w,
            ),
            SizedBox(
              height: 40.h,
            ),
            Column(
              children: [
                PasswordTextField(
                  controller: _oldPasswordController,
                  hintText: 'Old Password',
                  icon1: Icon(
                    Icons.key,
                    color: Constants.PRIMARY_COLOR,
                  ),
                  icon2: Icon(
                    Icons.visibility,
                    color: Constants.PRIMARY_COLOR,
                  ),
                  icon3: Icon(
                    Icons.visibility_off,
                    color: Constants.PRIMARY_COLOR,
                  ),
                  textInputType: TextInputType.text,
                  color: Constants.PRIMARY_COLOR,
                ),
                SizedBox(
                  height: 15.h,
                ),
                PasswordTextField(
                  controller: _newPasswordController,
                  hintText: 'New Password',
                  icon1: Icon(
                    Icons.key,
                    color: Constants.PRIMARY_COLOR,
                  ),
                  icon2: Icon(
                    Icons.visibility,
                    color: Constants.PRIMARY_COLOR,
                  ),
                  icon3: Icon(
                    Icons.visibility_off,
                    color: Constants.PRIMARY_COLOR,
                  ),
                  textInputType: TextInputType.text,
                  color: Constants.PRIMARY_COLOR,
                ),
                SizedBox(
                  height: 15.h,
                ),
                PasswordTextField(
                  controller: _confirmNewPasswordController,
                  hintText: 'Confirm Password',
                  icon1: Icon(
                    Icons.key,
                    color: Constants.PRIMARY_COLOR,
                  ),
                  icon2: Icon(
                    Icons.visibility,
                    color: Constants.PRIMARY_COLOR,
                  ),
                  icon3: Icon(
                    Icons.visibility_off,
                    color: Constants.PRIMARY_COLOR,
                  ),
                  textInputType: TextInputType.text,
                  color: Constants.PRIMARY_COLOR,
                ),
                SizedBox(
                  height: 12.h,
                ),
                GestureDetector(
                  onTap: _isLoading ? null : _changePassword,
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.PRIMARY_COLOR,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : const Text(
                            'Submit',
                            style: TextStyle(fontSize: 17),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
    });

    if (_newPasswordController.text == _confirmNewPasswordController.text) {
      try {
      List<dynamic> result = await AccountController().changePassword(
        box.read('userNumber'),
        _oldPasswordController.text,
        _newPasswordController.text,
      );

      if (result[0]["Column1"] == 'Password Changed Successfully') {
        Utils.appSnackBar(
          subtitle: result[0]["Column1"],
          bgColor: Constants.PRIMARY_COLOR
        );
        box.write('distroPassword',  _newPasswordController.text);
        //  Navigator.pop(context);
          Get.offAllNamed(
          RouteName.loginScreen,
        );
      } else if (result[0]["Column1"] == 'Old Password Invalid') {

        Utils.appSnackBar(
          subtitle: result[0]["Column1"],
        );
      }
      print(result);
    } catch (e) {
      // Handle the error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    }
    else{
       Utils.appSnackBar(
          subtitle: "Passwords doesn't match",);
          setState(() {
        _isLoading = false;
      });
    }
  }
}
