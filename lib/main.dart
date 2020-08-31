import 'package:cashapp/blocs/balance_bloc.dart';
import 'package:cashapp/res/size_config.dart';
import 'package:cashapp/screens/home.dart';
import 'package:cashapp/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

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
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(),
            routes: {
             // Home.route: (context) => Home(),
            },
          ),
        );
      });
    });
  }
}
