import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatefulWidget {
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkForUpdate();
    });
    super.initState();
  }

  AppUpdateInfo? _updateInfo;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool _updateDialogShown = false;

  bool isLoading = false;

  Future<void> checkForUpdate() async {
    try {
      setState(() {
        isLoading = true;
      });
      _updateInfo = await InAppUpdate.checkForUpdate();

      // Check if an update is available and the update dialog hasn't been shown yet
      if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable &&
          !_updateDialogShown) {
        setState(() {
          isLoading = false;
        });
        _showUpdateDialog();
      } else {
        setState(() {
          isLoading = false;
        });
        // No update available, navigate to SplashScreen
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // showSnack(e.toString());
    }
  }

  void _showUpdateDialog() {
    if (_updateInfo != null &&
        _updateInfo!.updateAvailability == UpdateAvailability.updateAvailable) {
      _updateDialogShown = true;
      showDialog(
        context: context,
        barrierDismissible: false, // Set this to false to prevent dismissing the dialog by tapping outside
        builder: (context) => WillPopScope( // Wrap the dialog with WillPopScope to prevent dismissing the dialog with the back button
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            title: Text(
              'Update Available',
              style: TextStyle(color: Colors.black),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'A new version is available',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'New Version: ${_updateInfo!.availableVersionCode}',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _launchAppStore();
                },
                child: Text('Update Now'),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _launchAppStore() async {
    final url = 'https://play.google.com/store/apps/details?id=com.sazent.tqrfamily';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // showSnack('Could not open the Play Store');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text('No updates available'),
      ),
    );
  }
}
