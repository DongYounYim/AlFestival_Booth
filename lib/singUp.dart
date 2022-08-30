import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // firebase email signUp
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // uid
  String userid = '';
  // firestore
  CollectionReference user = FirebaseFirestore.instance.collection('users');
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
  // name inputBox Widget
  Widget _nameInputWidget() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'name'
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '이름을 입력하세요';
        }
        return null;
      },
    );
  }
  _signUp() async {
    if(_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    try {
      UserCredential res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text
      );
      userid = res.user!.uid;
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = '비밀번호 보안이 약합니다.';
      } else if (e.code == 'email-already-in-use') {
        message = '사용 중인 이메일 입니다.';
      } else {
        message = '알 수 없는 오류 발생';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        )
      );
    }
    user.doc(userid).set({
      'uid': userid,
      'name': _nameController.text,
      'email': _emailController.text,
      'clear': false,
      'getItem': false,
      'progress': {
        'booth1': false,
        'booth2': false,
        'booth3': false,
        'booth4': false,
        'booth5': false,
        'booth6': false,
        'booth7': false,
        'booth8': false,
        'booth9': false
      }
    }).then((value) async {
      log('정보 입력 성공');
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, 
          password: _passwordController.text
        ).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
        });
      } catch (e) {
        log('로그인 에러발생');
      }
    })
    .catchError((error) => log('Failed to add user: $error'));
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0.w),
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
                  _nameInputWidget(),
                  SizedBox(height: 10.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: ElevatedButton(
                          onPressed: () {
                             _signUp();
                          },
                          child: Text('회원가입', style: TextStyle(fontSize: 18.sp),)
                        )
                      ),
                      SizedBox(
                        width: 150.w,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('초기화면으로', style: TextStyle(fontSize: 18.sp),)
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 220.h)
                ],
              )
            )
          ),
        ),
      )
      )
    )
    );
  }
}