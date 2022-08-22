import 'package:flutter/material.dart';
import 'ticket.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final passwordTextEditController = TextEditingController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/background2.jpg"),
              fit: BoxFit.cover,
            )),
            child: Column(children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 350),
                      child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.black,
                          iconSize: 40,
                          onPressed: () {
                            Navigator.pop(context, false);
                          }))),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: SizedBox(
                          height: 100,
                          width: 200,
                          child: TextField(
                            controller: passwordTextEditController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password",
                            ),
                          )))),
              Align(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                      icon: Icon(Icons.check),
                      color: Colors.black,
                      iconSize: 20.20,
                      onPressed: () {
                        child:
                        (() {
                          if (passwordTextEditController == ticketPassword) {
                            return checkingpassword = '1';
                          }
                        }());
                      }))
            ])));
  }
}
