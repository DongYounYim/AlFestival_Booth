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
  openHowto() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('부스 체험 도장 받는 법'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('1. 오른쪽 부스 내역에서 부스 설명을 읽어본다.'),
              Text('2. 맘에드는 부스를 고르고 한마당 맵을 열어봐서 찾아간다.'),
              Text('3. 부스 운영장에서 부스를 체험한다.'),
              Text('4. 체험한 부스 내 운영자에게 qr코드 인식을 통해 체험 인증을 받는다.'),
              Text('5. 모든 부스를 체험하고 상품 수령 버튼을 통해 상품을 수령한다.')
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            )
          ],
        );
      }
    );
  }
  openDetail(name, subject, detail) async {
    // Detail Dialog open
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200.h,
                child: Image(image: AssetImage('assets/images/$name.jpg')),
              ),
              SizedBox(height: 20.h),
              Text(subject, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 20.h),
              Text(detail, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
            ],
          ),
          content: const SizedBox(height: 0),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('도장 받으러 가기', style: TextStyle(fontSize: 12.sp),),
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
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/images/background1.jpg"),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Booth',
                            style:
                                TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
                          ),
                          Text('Stamp',
                              style: TextStyle(
                                  fontSize: 28.sp, fontWeight: FontWeight.w700)),  
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () => openHowto(),
                        child: Text(
                          '도장 모으는 방법',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.8,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return MainButton(
                            id: btnItem[index][0], label: btnItem[index][1], isClear: isClear, setResultQR: setResultQR);
                      },
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Expanded(
                    child: GridView.count(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 20.h,
                        children: initdata.map((value) => 
                        InkWell(
                          // todo 부스 디테일로 이동 
                          onTap: () => openDetail(value['booth_name'], value['subject'], value['description']),
                          child: Column(
                            children: [
                              Container(
                                height: 125.h,
                                width: 160.w,
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
                                width: 160.w,
                                height: 40.h,
                                color: const Color(0xff515151),
                                child: Center(
                                  child: Text(
                                    value['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: value['title'].length > 8 ? 12.sp : 18.sp,
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
                  ),
                ],
              )
            )
          ),
        )
      );
    }
  }
}