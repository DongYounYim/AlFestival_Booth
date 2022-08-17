import 'package:flutter/material.dart';
import 'login.dart';
import 'singUp.dart';

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 220),
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
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 280),
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
                        minimumSize: const Size.fromHeight(50),
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)
                        )
                      ),
                      child: Row(
                        children: const <Widget>[
                          SizedBox(width: 20),
                          Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          SizedBox(width: 80),
                          Text(
                            '이메일로 로그인 하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24
                            ),
                          ),
                          SizedBox(width: 20)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        minimumSize: const Size.fromHeight(50),
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)
                        )
                      ),
                      child: Row(
                        children: const <Widget>[
                          SizedBox(width: 20),
                          Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          SizedBox(width: 80),
                          Text(
                            '이메일로 회원가입 및 로그인 하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24
                            ),
                          ),
                          SizedBox(width: 20)
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