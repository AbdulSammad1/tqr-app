import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tqrfamily_bysaz_flutter/utils/utils.dart';

class InternetConnectionChecker extends StatelessWidget {
  const InternetConnectionChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity = Connectivity();
    return Scaffold(
      body: StreamBuilder<ConnectivityResult>(
        stream: connectivity.onConnectivityChanged,
        builder: (_,snapshot){
          return  InternetWidget(snapshot: snapshot,widget: Text(''),);
        },
      ),
    );
  }
}

class InternetWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget;
  const InternetWidget({Key? key,required this.widget,required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(snapshot.connectionState){
      case ConnectionState.active:
        final state = snapshot.data!;
        switch(state){
          case ConnectivityResult.none:
            return Utils.appSnackBar(subtitle: 'No Internet Connection',);
          default: return widget;
        }
      default: return const Text('');
    }
  }
}
