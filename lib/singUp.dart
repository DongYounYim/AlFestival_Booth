import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    }).then((value) => log('정보 입력 성공'))
    .catchError((error) => log('Failed to add user: $error'));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text
      );
    } catch (e) {
      log('로그인 에러발생');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,  //overflow에러 임시해결
      body: SafeArea(
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
              padding: const EdgeInsets.symmetric(horizontal: 300.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    "Welcome to",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        ' AI ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Text(
                        "festival",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 70.0),
                  _emailInputWidget(),
                  const SizedBox(height: 10.0),
                  _passwordInputWidget(),
                  const SizedBox(height: 10.0),
                  _nameInputWidget(),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 220,
                        child: ElevatedButton(
                          onPressed: () {
                              _signUp();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Home())
                            );
                          },
                          child: const Text('회원가입', style: TextStyle(fontSize: 22),)
                        )
                      ),
                      SizedBox(
                        width: 220,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('초기화면으로', style: TextStyle(fontSize: 22),)
                        )
                      )
                    ],
                  )
                ],
              )
            )
          ),
        ),
      )
    );
  }
}