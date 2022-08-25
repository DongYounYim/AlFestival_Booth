import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String ticketPassword = '1234';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final passwordTextEditController = TextEditingController();

  openError() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              const Text('비밀번호가 잘못되었습니다.', style: TextStyle(fontSize: 32))
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('비밀번호 재입력')
            )
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
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
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 300.h),
                        child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.black,
                            iconSize: 40,
                            onPressed: () {
                              return Navigator.pop(context, false);
                            }))),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h, left: 400.w, right: 400.w),
                  child: TextField(
                      controller: passwordTextEditController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "상품교환 비밀번호 입력",
                      ),
                      obscureText: true,
                    ),
                  ),
                Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.black,
                        iconSize: 40,
                        onPressed: () {
                          passwordTextEditController.text == ticketPassword 
                          ? Navigator.pop(context, true)
                          : openError();
                        }
                      )
                    )
              ]))
        )
      );
  }
}
