import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../qrscan.dart';
import '../ticket.dart';

class MainButton extends StatefulWidget {
  const MainButton({Key? key, required this.id, required this.label, required this.isClear, required this.setResultQR})
      : super(key: key);
  final String id;
  final String label;
  final bool isClear;
  final Function setResultQR;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool _active = false;

  logout() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  _setActive() {
    setState(() {
      _active = !_active;
    });
  }

  _get() async {
    if(widget.isClear) {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Ticket()),
    );
    } else {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          // if clear가 true 일 시 상품 수령화면으로 이동 아닐 시 경고 dialog
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              '아직 모든 부스를 완료하지 않았습니다. \n모든 부스를 완료한 후에 이용해 주세요.',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('확인'),
              )
            ],
          );
        }
      );
    }
  }

  Future _scan(context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScanQR()),
    );
    widget.setResultQR(result);
  }

  openMap() async {
    // 맵 Dialog open
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: const [
              Text('한마당 부스 운영 맵', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 600,
                child: Image(image: AssetImage('assets/images/Map.jpg')),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('도장 받으러 가기'),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _setActive(),
      onTapUp: (details) => {
        _setActive(),
        if (widget.id == 'logout') {logout()}
        else if (widget.id == 'get') {_get()}
        else if (widget.id == 'qrcode') {_scan(context)}
        else if (widget.id == 'map') {openMap()}
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: _active
                ? null
                : [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ]),
        width: 120,
        height: 60,
        child: Text(
          widget.label,
          style: const TextStyle(color: Color(0xffA7CCF8), fontSize: 20),
        ),
      ),
    );
  }
}
