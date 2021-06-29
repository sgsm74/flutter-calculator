import 'package:calculator/logic/model/calculator.dart';
import 'package:calculator/logic/model/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CalculatorBody extends StatelessWidget {
  const CalculatorBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    ThemeMode mode = Provider.of<ThemeModel>(context, listen: false).mode;
    ScrollController _scrollController = ScrollController();
    TextEditingController textController = TextEditingController();

    return ChangeNotifierProvider<CalculatorModel>(
      create: (context) => CalculatorModel(),
      child: Consumer<CalculatorModel>(
        builder: (context, model, __) {
          //textController.text = model.toString();
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.rtl,
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<ThemeModel>(context, listen: false)
                            .toggleMode();
                      },
                      icon: Icon(
                        mode == ThemeMode.dark
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_rounded,
                        color: Color(0xffbdbec0),
                      ),
                    ),
                  ],
                ),
              ),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: height / 3 / 3,
                  alignment: Alignment.bottomLeft,
                  child: ListView.builder(
                    //reverse: true,
                    padding: EdgeInsets.only(right: 50, left: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: model.pharases.length,
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1),
                        child: Text(
                          model.pharases[index],
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            //color: Theme.of(context).textTheme.bodyText1!.color,c
                            color: keysColor(context, model.pharases[index]),
                            fontSize: 50,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: height / 3 / 2,
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: Text(
                    model.result,
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.4),
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: GridView.builder(
                        itemCount: keys.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                              if (keys[index] == "AC") {
                                Provider.of<CalculatorModel>(context,
                                        listen: false)
                                    .clear();
                              } else if (keys[index] == "C") {
                                Provider.of<CalculatorModel>(context,
                                        listen: false)
                                    .backspace();
                              } else if (keys[index] == "=") {
                                Provider.of<CalculatorModel>(context,
                                        listen: false)
                                    .hitAssignKey();
                              } else {
                                Provider.of<CalculatorModel>(context,
                                        listen: false)
                                    .add(keys[index].toString());
                              }
                              _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                keys[index],
                                style: TextStyle(
                                  color: keysColor(context, keys[index]),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

List<String> keys = [
  "AC",
  "±",
  "%",
  "÷",
  "7",
  "8",
  "9",
  "×",
  "4",
  "5",
  "6",
  "-",
  "1",
  "2",
  "3",
  "+",
  "C",
  "0",
  ".",
  "=",
];
Color? keysColor(BuildContext context, String key) {
  List<String> others = [
    "AC",
    "±",
    "%",
  ];

  List<String> opernads = [
    "÷",
    "×",
    "-",
    "+",
    "=",
  ];
  if (opernads.contains(key))
    return Color(0xffF37878);
  else if (others.contains(key))
    return Color(0xff06FFD8);
  else
    return Theme.of(context).textTheme.bodyText1!.color;
}
