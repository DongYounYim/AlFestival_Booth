import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/MainButton.dart';

final BtnItem = [
  [
    'qrcode',
    'QR 인식',
  ],
  [
    'map',
    '한마당 맵',
  ],
  [
    'logout',
    '로그아웃',
  ],
  [
    'quit',
    '종료하기',
  ]
];

final dummyData = [
  {
    'content_id': '1',
    'content_img': 'dummy',
    'title': 'aa',
    'complete': true,
  },
  {
    'content_id': '2',
    'content_img': 'dummy',
    'title': 'aa',
    'complete': false,
  },
  {
    'content_id': '3',
    'content_img': 'dummy',
    'title': 'aa',
    'complete': false,
  },
  {
    'content_id': '4',
    'content_img': 'dummy',
    'title': 'aa',
    'complete': false,
  },
  {
    'content_id': '5',
    'content_img': 'dummy',
    'title': 'aa',
    'complete': false,
  },
  {
    'content_id': '6',
    'content_img': 'dummy',
    'title': 'aa',
    'complete': false,
  },
  {
    'content_id': '7',
    'content_img': 'dummy',
    'title': 'aa',
    'complete': false,
  },
  {
    'content_id': '8',
    'content_img': 'dummy',
    'title': 'aa',
    'complete': false,
  },
  {
    'content_id': '9',
    'content_img': 'dummy',
    'title': 'aa',
    'complete': false,
  }
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/background1.jpg"),
          fit: BoxFit.cover,
        )),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Booth',
                      style:
                          TextStyle(fontSize: 80, fontWeight: FontWeight.w700),
                    ),
                    const Text('Stamp',
                        style: TextStyle(
                            fontSize: 80, fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      '남은시간 : 00:00:00',
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      '[도장 모으는 방법]',
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.all(30),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return MainButton(
                              id: BtnItem[index][0], label: BtnItem[index][1]);
                        },
                      ),
                    ),
                  ]),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: 9,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.3,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                height: 150,
                                width: 200,
                                color: Color(0xffFEE57E),
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/stampFalse.png")),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                  width: 200,
                                  color: Color(0xff515151),
                                  child: const Text(
                                    "title",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          );
                        })
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
