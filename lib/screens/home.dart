import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screens/SignIn.dart';
import 'package:todo_app/services/AuthenticationService.dart';
import 'package:todo_app/utils/Constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _todos = new List();
  var _completed = new List();

  String _day = DateFormat('EEEE').format(DateTime.now()).toString();
  String _dayInMonth = DateFormat('dd').format(DateTime.now()).toString();
  String _monthInYear = DateFormat('MMM').format(DateTime.now()).toString();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) _todos.add("Item " + i.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.lightPrimary,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 60, left: 30, right: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _day,
                            style: TextStyle(
                                color: Constants.clearWhite,
                                fontSize: Constants.titleFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _dayInMonth + " " + _monthInYear,
                            style: TextStyle(
                                color: Constants.clearWhite,
                                fontSize: Constants.subtitleFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => showProfile(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: Icon(Icons.person_rounded,
                              size: 50.0, color: Constants.clearWhite),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        Text(
                          _todos.isEmpty
                              ? "It's quiet in here. \nLet's add some _todos? \nTap the '+' icon to add a Todo."
                              : "Tap the '+' icon to add a Todo.",
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
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          padding: EdgeInsets.only(bottom: 75),
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: _todos.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(
                                  _todos[index],
                                  style: TextStyle(
                                    fontSize: Constants.normalFontSize,
                                  ),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: false,
                                onChanged: (bool value) {
                                  if (value == true) {
                                    setState(() {
                                      _completed.add(_todos[index]);
                                      _todos.removeAt(index);
                                      print("Todo marked as complete.");
                                    });
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        Positioned(
                          child: FloatingActionButton(
                            child: Icon(Icons.add),
                            backgroundColor: Constants.lightPrimary,
                            onPressed: () {
                              print("Add Button clicked");
                            },
                          ),
                          top: -50,
                          right: 30,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => showCompletedTodos(),
                                child: Container(
                                  width: 200,
                                  height: 75,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Constants.lightPrimary,
                                        size: 35.0,
                                      ),
                                      Text(
                                        "Show Completed",
                                        style: TextStyle(
                                          color: Constants.lightPrimary,
                                          fontSize: Constants.normalFontSize,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showProfile() async {
    final bool isSignedIn =
        await context.read<AuthenticationService>().isSignedIn();

    String email = "";
    if (isSignedIn)
      email = await context.read<AuthenticationService>().getEmail();

    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Signed in as:"),
        content: Text(email),
        actions: [
          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: Text("Sign out"),
                color: Colors.redAccent,
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String input = "";
        return AlertDialog(
          title: Text("Add a Todo"),
          content: TextField(
            onChanged: (String value) {
              input = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  setState(() {
                    _todos.add(input);
                  });
                },
                child: Text("Add"))
          ],
        );
      },
    );
  }

  void showCompletedTodos() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Completed Todos"),
        content: Container(
          height: 200.0,
          width: 300.0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _completed.length > 0 ? _completed.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_completed[index]),
              );
            },
          ),
        ),
        actions: [
          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  _completed.clear();

                  final snackBar = SnackBar(
                      content: Text('Completed Todo List cleared.',
                          style: TextStyle(color: Colors.green)),
                      duration: Duration(seconds: 5));
                  Scaffold.of(context).showSnackBar(snackBar);

                  Navigator.pop(context);
                },
                child: Text("Clear Completed"),
                color: Colors.redAccent,
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
