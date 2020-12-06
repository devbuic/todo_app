import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _checked = false;
  int _count = 20;
  String _username = "Sarmad";

  String _day = DateFormat('EEEE').format(DateTime.now()).toString();
  String _dayInMonth = DateFormat('dd').format(DateTime.now()).toString();
  String _monthInYear = DateFormat('MMM').format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.lightPrimary,
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 60, left: 30, right: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello 👋🏻\n$_username",
                      style: TextStyle(
                          color: Constants.clearWhite,
                          fontSize: Constants.titleFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _day,
                          style: TextStyle(
                              color: Constants.clearWhite,
                              fontSize: Constants.subtitleFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _dayInMonth + " " + _monthInYear,
                          style: TextStyle(
                              color: Constants.clearWhite,
                              fontSize: Constants.mintitleFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        "It's quiet in here. \nLet's add some Todos? \nTap the '+' icon to add a Todo.",
                        style: TextStyle(
                            color: Constants.clearWhite,
                            fontSize: Constants.mintitleFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.6,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 30, left: 40),
                  decoration: BoxDecoration(
                    color: Constants.clearWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    boxShadow: [BoxShadow(color: Constants.clearWhite)],
                  ),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Positioned(
                        child: Text(
                          "Your Todos",
                          style: TextStyle(
                              fontSize: Constants.subtitleFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        left: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 30),
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: _count,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text(
                                "Todo $index",
                                style: TextStyle(
                                  fontSize: Constants.normalFontSize,
                                ),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: _checked,
                              onChanged: (bool value) {
                                setState(() {
                                  _checked = value;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      Positioned(
                        child: FloatingActionButton(
                          child: Icon(Icons.add),
                          backgroundColor: Constants.lightPrimary,
                          onPressed: () {},
                        ),
                        top: -50,
                        right: 30,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
