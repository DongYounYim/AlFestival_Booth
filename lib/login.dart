import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool popLoading = false;
  // firebase email login
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(); //입력되는 값을 제어
  final TextEditingController _passwordController = TextEditingController();
  var count = 0;
  // email inputBox Widget
  Widget _emailInputWidget() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'email'
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '이메일 입력하세요';
        }
        return null;
      },
    );
  }
  // password inputBox Widget
  Widget _passwordInputWidget() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'password'
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '비밀번호 입력하세요';
        }
        return null;
      },
    );
  }

  _errorControl() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('알 수 없는 에러 발생',
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text('앱종료')
          )
        ],
      );}
    );
  }

  // fireabse login 시도
  _login() async {
    if(_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text
      ).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
      });
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'user-not-found') {
        message = "사용자가 존재하지 않습니다.";
      } else if (e.code == 'wrong-password') {
        message = "비밀번호가 잘못 됐습니다.";
      } else {
        message = "이메일을 확인하세요.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red, 
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    log('loginPage');
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: 
      SingleChildScrollView(
        child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          )),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(right: 30.0.w, left: 30.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 150.h),
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60.sp,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' AI ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60.sp,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Text(
                        "festival",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60.sp,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 100.0.h),
                  _emailInputWidget(),
                  SizedBox(height: 10.0.h),
                  _passwordInputWidget(),
                  SizedBox(height: 10.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: ElevatedButton(
                          onPressed: () {
                            _login();
                          }, 
                          child: Text('Login', style: TextStyle(fontSize: 18.sp),)
                        )
                      ),
                      SizedBox( 
                        width: 150.w,
                        child: ElevatedButton(
                          onPressed: () {
                            count += 1;
                            Navigator.pop(context);
                            if (count > 1) {
                              // something something
                              _errorControl();
                            }
                          },
                          child: Text('초기화면으로', style: TextStyle(fontSize: 18.sp),)
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 300.h,)
                ]
              ),
            )
          ) 
        )
      )
      )
    )
    );
  }
}