import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/main_button.dart';

final btnItem = [
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
    'get',
    '상품수령',
  ]
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 로그인 실패에러?  _CastError(Null check operator used on a null value)
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final db = FirebaseFirestore.instance;
  // 부스 정보 데이터
  List initdata = [];
  // 부스 성공 여부
  var eachClear = {};
  // clear 여부
  var isClear = false;
  // qr코드 인식 결과
  var resultQR = '';
  void setResultQR(res) async {
    setState(() {
      resultQR = res;
      isLoading = true;
    });
    log(resultQR);
    // db 업데이트
    await db.collection('users').doc(uid)
    .update({'progress.$resultQR': true})
    .then((value) async => 
      db.collection('users').doc(uid).get()
      .then((DocumentSnapshot ds){
        var temp = ds.data() as Map;
        var eachData = temp['progress'] as Map;
        var flag = true;
        for (var i = 1; i < 10; i++) {
          if (!eachData['booth$i']) {
            flag = false; 
          }
        }
        if (flag) {
          db.collection('users').doc(uid).update({'clear': true});
        }
      })
    )
    .catchError((error) {log(error);});
    _getData();
  }
  bool isLoading = true;
  Future _getData () async {
    // 부스에 관련 데이터 가져오기
    log('main + getData');
    var tempArr = [];
    await db.collection('booth').get()
    .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        tempArr.add(doc.data());
      }
    });
    initdata = tempArr;
    // user 데이터 가져오기
    await db.collection('users').doc(uid).get()
    .then((DocumentSnapshot doc) {
      var data = doc.data() as Map;
      eachClear = data['progress'] as Map;
      isClear = data['clear'];
    });
    setState(() {
      isLoading = false;
    });
  }
  openDetail(name, subject, detail) async {
    // 맵 Dialog open
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400.h,
                child: Image(image: AssetImage('assets/images/$name.jpg')),
              ),
              SizedBox(height: 20.h),
              Text(subject, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              SizedBox(height: 20.h),
              Text(detail, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
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
    if (isLoading) {
      _getData();
      return const CircularProgressIndicator();
    } else {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,  //overflow에러 임시해결
          body: Container(
            decoration: const BoxDecoration(
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
                        SizedBox(
                          height: 30.h,
                        ),
                        const Text(
                          '남은시간 : 00:00:00',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextButton(
                          onPressed: () => _getData(),
                          child: const Text(
                            '[도장 모으는 방법]',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          margin: const EdgeInsets.all(30),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              // Todo mainbutton에 Clear 여부넘겨주기
                              return MainButton(
                                  id: btnItem[index][0], label: btnItem[index][1], isClear: isClear, setResultQR: setResultQR);
                            },
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  flex: 2,
                  child: 
                      GridView.count(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 50.w,
                        mainAxisSpacing: 10.h,
                        children: initdata.map((value) => 
                        InkWell(
                          // todo 부스 디테일로 이동 
                          onTap: () => openDetail(value['booth_name'], value['subject'], value['description']),
                          child: Column(
                            children: [
                              Container(
                                height: 150.h,
                                width: 200.w,
                                color: const Color(0xffFEE57E),
                                // value['booth_name'] == user의 progress내의 bool값이 true 이면 도장
                                child: eachClear[value['booth_name']] 
                                  ? const Image(
                                    image: AssetImage("assets/images/stamp/stampComplete.png")
                                  )
                                  : Image(
                                    image: AssetImage("assets/images/stamp/${value['stamp']}.png"),
                                  )
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                width: 200.w,
                                height: 30.h,
                                color: const Color(0xff515151),
                                child: Center(
                                  child: Text(
                                    value['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: value['title'].length > 8 ? 16 : 22,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ), 
                                )
                              )
                            ],
                          ),
                        )).toList()  
                      )
                  )
              ],
            ),
          ),
        )
      );
    }
  }
}