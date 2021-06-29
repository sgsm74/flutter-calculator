import 'package:calculator/logic/model/theme.dart';
import 'package:calculator/ui/screens/calculator_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, model, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Color(0xff22252D),
              accentColor: Color(0xff272B33),
              scaffoldBackgroundColor: Color(0xff22252D),
              backgroundColor: Color(0xff292D36),
              textTheme: TextTheme(
                bodyText2: TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.white),
              ),
            ),
            theme: ThemeData(
              primaryColor: Colors.white,
              accentColor: Color(0xffF5F5f5),
              backgroundColor: Color(0xffF9F9F9),
              iconTheme: IconThemeData(
                color: Color(0xffbdbec0),
              ),
              scaffoldBackgroundColor: Colors.white,
              brightness: Brightness.light,
            ),
            themeMode: model.mode,
            home: CalculatorBody(),
          );
        },
      ),
    );
  }
}
