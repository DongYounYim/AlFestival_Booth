import 'package:flutter/material.dart';
import 'ticket_check.dart';

String ticketPassword = '1234';

String InPut_ticketPassword = '';

String checkingpassword = '0';

class ticket extends StatefulWidget {
  const ticket({Key? key}) : super(key: key);

  @override
  State<ticket> createState() => _ticketState();
}

class _ticketState extends State<ticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ticket'),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          )),
          child: Column(children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.black,
                    iconSize: 20.20,
                    onPressed: () {
                      Navigator.pop(context);
                    })),
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Text('상품교환권',
                      style: TextStyle(fontSize: 50, color: Colors.black)),
                )),
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: (() {
                      if (checkingpassword == '1') {
                        return Image.asset('assets/images/ticket_used.png');
                      } else {
                        return FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Password()),
                              );
                            },
                            child: Image.asset(
                              'assets/images/ticket.png',
                            ));
                      }
                    })())),
            Align(
                alignment: Alignment.topCenter,
                child: (() {
                  if (checkingpassword == '1') {
                    return Text('사용 완료된 교환권입니다.',
                        style: TextStyle(fontSize: 50, color: Colors.grey));
                  } else {
                    return Text('상품 수령 위치 : OOO',
                        style: TextStyle(fontSize: 50, color: Colors.black));
                  }
                })())
          ]),
        ));
  }
}
