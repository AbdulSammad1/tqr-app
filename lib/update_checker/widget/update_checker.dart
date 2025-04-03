import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../res/routes/route_name.dart';
import '../../splash/splash_screen.dart';

class UpdateChecked extends StatefulWidget {
  final Function() navigateToScreen; // Callback function to navigate to the desired screen

  UpdateChecked({required this.navigateToScreen});

  @override
  State<UpdateChecked> createState() => _UpdateCheckedState();
}

class _UpdateCheckedState extends State<UpdateChecked> {
  AppUpdateInfo? _updateInfo;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool _updateDialogShown = false;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    try {
      _updateInfo = await InAppUpdate.checkForUpdate();

      // Check if an update is available and the update dialog hasn't been shown yet
      if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable && !_updateDialogShown) {
        _showUpdateDialog();
      } else {
        // No update available, navigate to the desired screen
        widget.navigateToScreen();
      }
    } catch (e) {
      showSnack(e.toString());
      widget.navigateToScreen(); // Handle the error and navigate to the desired screen
    }
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  // Method to show the update message dialog
  void _showUpdateDialog() {
    if (_updateInfo != null) {
      _updateDialogShown = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Update Available', style: TextStyle(color: Colors.black),),
          content: Text('A new version is available. Update now?', style: TextStyle(color: Colors.black),),
          actions: [
            TextButton(onPressed: () {
              widget.navigateToScreen();
            }, child: Text('ignore')),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Perform the immediate update if the user chooses to update now
                if (_updateInfo!.updateAvailability == UpdateAvailability.updateAvailable) {
                  InAppUpdate.performImmediateUpdate().catchError((e) {
                    showSnack(e.toString());
                    return AppUpdateResult.inAppUpdateFailed;
                  });
                }
              },
              child: Text('Update Now'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
  