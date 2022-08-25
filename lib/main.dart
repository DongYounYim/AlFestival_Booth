import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer';
import 'Init.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BoothApp());
}

class BoothApp extends StatefulWidget {
  const BoothApp({Key? key}) : super(key: key);

  @override
  State<BoothApp> createState() => _BoothAppState();
}

class _BoothAppState extends State<BoothApp> {
  bool isLoading = true;
  bool isLogin = false;
  void initState() {
    FirebaseAuth.instance.authStateChanges()
    .listen((User? user) { 
      if (user == null) {
        log('logout');
        setState(() {
          isLogin = false;
        });
      } else {
        log('login');
        setState(() {
          isLogin = true;
        });
      }
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    return ScreenUtilInit(
      designSize: const Size(1080, 810),
      builder: ((context, child) {
        return MaterialApp(
          title: 'AI_SW_Booth',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: isLogin ? const Home() : const Init()
        );
      }),
    );
  }
}

