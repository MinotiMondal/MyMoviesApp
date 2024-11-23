import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_movies_app/data/utils/string_manager.dart';
import 'package:my_movies_app/module/routes/app_pages.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return GetMaterialApp(
          //scaffoldMessengerKey: rootScaffoldMessengerKey,
          title: StringManager.applicationtitle,
          debugShowCheckedModeBanner: false,
        //  navigatorKey: navigatorKey,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          themeMode: ThemeMode.system,
          defaultTransition: Transition.cupertino,
        );
      },
    );
  }
}
