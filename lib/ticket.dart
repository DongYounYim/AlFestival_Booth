import 'dart:developer';
import 'package:flutter/material.dart';
import 'ticket_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket extends StatefulWidget {
  const Ticket({Key? key}) : super(key: key);

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final db = FirebaseFirestore.instance;
  bool isLoading = true;
  var isgetItem = false;
  _getItem () async {
    log('ticket: getData');
    db.collection('users').doc(uid).get()
    .then((DocumentSnapshot doc) {
      var data = doc.data() as Map;
      setState(() {
        isgetItem = data['getItem'];
      });
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {log(e);});
  }
  setGetItem () async {
    await db.collection('users').doc(uid)
    .update({'getItem': true})
    .then((value) => {
      setState(() {
        isgetItem = true;
      })
    }).catchError((e) {log(e);});
  }
  Future _navigate (context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Password())
    );
    log(result);
    if (result) {
      // update
      setGetItem();
    } else {
      // 변화 없음.
    }
    return ;
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      _getItem();
      return const CircularProgressIndicator();
    } else {
      return Scaffold(
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/background2.jpg"),
                fit: BoxFit.cover,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.black,
                          iconSize: 40,
                          onPressed: () {
                            return Navigator.pop(context);
                          })),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 80),
                    child: Text('상품교환권',
                        style: TextStyle(fontSize: 50, color: Colors.black)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: (() {
                      if (isgetItem) {
                        return Image.asset('assets/images/ticket_used.png');
                      } else {
                        return InkWell(
                            onTap: () {
                              _navigate(context);
                            },
                            child: Image.asset(
                              'assets/images/ticket.png',
                            ));
                      }
                    })()),
                    isgetItem 
                    ? const Text('사용 완료된 교환권입니다.', style: TextStyle(fontSize: 50, color: Colors.grey))
                    : const Text('상품 수령 위치 : OOO', style: TextStyle(fontSize: 50, color: Colors.black))
              ]),
            )
          )
        );
    }
  }
}
