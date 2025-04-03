import 'dart:io';
import 'dart:ui' as UI;

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:tqrfamily_bysaz_flutter/my_account/screen/change_password_screen.dart';
import 'package:tqrfamily_bysaz_flutter/res/routes/routes.dart';
import 'package:tqrfamily_bysaz_flutter/signedScheme/screen/history_screen.dart';
import 'package:tqrfamily_bysaz_flutter/signedScheme/screen/signed_card_screen.dart';
import 'package:tqrfamily_bysaz_flutter/signedScheme/screen/signed_screen.dart';
import 'package:tqrfamily_bysaz_flutter/splash/splash_screen.dart';
import 'package:tqrfamily_bysaz_flutter/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'bindings/initial_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  await Firebase.initializeApp(
  );

   HttpOverrides.global = MyHttpOverrides();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgoundHandler);
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      EasyLocalization(
        startLocale: const Locale('en'),
        supportedLocales: const [Locale('en'), Locale('ur')],
        path: 'assets/lang', // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    );
  });
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgoundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final box = GetStorage();
var logger = Logger();
UI.TextDirection directionLtr = UI.TextDirection.ltr;
UI.TextDirection directionRtr = UI.TextDirection.rtl;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'SAZ Application',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            useMaterial3: true,
            scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: MaterialStateProperty.all(
                Constants.PRIMARY_COLOR,
              ),
            ),
          ),
          home: SplashScreen(),
          routes: {
            SignedSchemeCardScreen.routeName: (ctx) => SignedSchemeCardScreen(),
            SignedSchScreen.routeName: (ctx) => SignedSchScreen(),
            ChangepasswordScreen.routeName: (ctx) => ChangepasswordScreen(),
            HistoryScreen.routeName: (ctx) => HistoryScreen(),
          },
          getPages: AppRoutes.appRoutes(),
          initialBinding: InitialBinding(),
        );
      },
      // child: box.read('isRememberMe') ==1 ? const DashboardScreen() :const LoginScreen(),
    );
  }
}
