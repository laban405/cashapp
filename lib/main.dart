import 'dart:io';

import 'package:cashapp/blocs/balance_bloc.dart';
import 'package:cashapp/res/size_config.dart';
import 'package:cashapp/screens/home.dart';
import 'package:cashapp/screens/login.dart';
import 'package:cashapp/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);

        return MultiProvider(
          providers: [
            ChangeNotifierProvider<BalanceBloc>.value(value: BalanceBloc())
          ],
          child: MaterialApp(
            title: 'Cash App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: SplashScreen.route,
            routes: {
              Home.route: (context) => Home(),
              Login.route: (context)=>Login(),
              SplashScreen.route: (context)=>SplashScreen()
            },
          ),
        );
      });
    });
  }
}
