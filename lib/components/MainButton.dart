import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainButton extends StatefulWidget {
  const MainButton({Key? key, required this.id, required this.label})
      : super(key: key);
  final String id;
  final String label;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool _active = false;

  logout() {
    FirebaseAuth.instance.signOut();
  }

  _setActive() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _setActive(),
      onTapUp: (details) => {
        _setActive(),
        if (widget.id == 'logout') {logout()}
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: _active
                ? null
                : [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ]),
        width: 120,
        height: 60,
        child: Text(
          widget.label,
          style: TextStyle(color: Color(0xffA7CCF8), fontSize: 20),
        ),
      ),
    );
  }
}
