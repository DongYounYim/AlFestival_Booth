import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer';
import 'login.dart';
import 'singup.dart';

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    log('initPage');
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            children: [
              SizedBox(height: 220.h),
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
              SizedBox(height: 40.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 260.w),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: Size.fromHeight(50.h),
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)
                        )
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20.w),
                          const Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          SizedBox(width: 80.w),
                          Text(
                            '이메일로 로그인 하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp
                            ),
                          ),
                          SizedBox(width: 20.w)
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size.fromHeight(50.h),
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)
                        )
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20.w),
                          const Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          SizedBox(width: 80.w),
                          Text(
                            '이메일로 회원가입 및 로그인 하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp
                            ),
                          ),
                          SizedBox(width: 20.w)
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}