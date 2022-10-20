import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  //텍스트필트 빈 값을 저장할 변수
  String inputText = "";

  //특정 이벤트가 발생하였을 때, 현재 입력된 값에 접근하고 싶을 때도 있다. 이때 사용하는 것이 TextEditingController.
  TextEditingController textController = TextEditingController();

  // 텍스트를 받아오기 위한 선언
  final idController = TextEditingController();
  final pwController = TextEditingController();

  // 상태위젯 상태변수로 선언
  DateTime? currentBackPressTime;

  final formKey = GlobalKey<FormState>();

  bool textfieldCheck = false;

  var _isChecked = false;

  // 캐싱을 위한 선언
  String _id = '';
  String _pw = '';

  // // 위젯이 생성될 때 처음으로 호출되고, 단 한번만 호출된다.
  // @override
  // void initState() {
  //   super.initState(); // initState()를 사용할 때 반드시 사용해야 한다.
  // }


  @override
  Widget build(BuildContext context) {
    //상태바 색상 설정
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      behavior: HitTestBehavior.opaque,
      child: Form(
        key: this.formKey,
        child: Material(
          color: Color(0xffF5F5F5),
          child: WillPopScope(
            onWillPop: () async {
              DateTime now = DateTime.now();
              //상태변화가 없거나,새로 상태가 변경됐을 때, 5초간격보다 클 때, [스낵바 띄우기 + "시간 초기화" ]
              if (currentBackPressTime == null ||
                  now.difference(currentBackPressTime!) > Duration(seconds: 5)) {
                //시간초기화
                currentBackPressTime = now;
                //백키처리 스낵바
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Icons.notification_important,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '뒤로가기 버튼을 한 번 더 누르시면 종료됩니다.',
                            //컨텍스트의 주제
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        height: 250.h - MediaQuery.of(context).padding.top,
                        width: 400.w,
                        alignment: Alignment.topCenter,
                        decoration: (const BoxDecoration(
                          color: Colors.transparent,
                        )),
                        child: Row(
                          children: [
                            //큰차이점 = Inkwell은 터치시 이벤트 효과가 들어간다.
                            Container(
                              padding: EdgeInsets.only(left: 20, top: 100),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "본인 확인을 위해 \n"
                                    "아이디를 입력해 주세요",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15.w, bottom: 20.w),
                                child: Text("아이디"),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15.w),
                                height: 60.h,
                                width: 250.w,
                                child: TextFormField(
                                  //autovalidateMode 는 FormField가 가지고 있는 속성을 상속받은 것인데, validator에 지정된 유효성 검사에서 반환된 에러 메시지를 자동으로 띄워주는 역할을 한다.
                                  // (사실 validator만 설정하면 되는 줄 알고 엄청 헤맸는데, autovalidateMode의 기본값은 autovalidateMode.disabled였다...)
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (String? val) {
                                    if (val!.length < 1) {
                                      return "아이디 필수";
                                    }
                                    if (val.length < 2) {
                                      return '아이디는 두 글자 이상 입력.';
                                    }
                                    return null;
                                  },
                                  onTap: () {

                                  },
                                  scrollPadding: EdgeInsets.only(bottom: 20),
                                  // scrollPadding: EdgeInsets.only(
                                  //     bottom: MediaQuery.of(context).viewInsets.bottom),
                                  textInputAction: TextInputAction.next,
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: idController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-z0-9]'))
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "아이디를 입력하세요.",
                                    hintStyle: TextStyle(
                                        fontSize: 15.w, color: Color(0xffA3A3A3)),
                                    contentPadding: EdgeInsets.only(left: 10.w),
                                    //테두리두께
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffCBCBCB), width: 2.0),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                    ),

                                    //텍스트필드 선택시 포커스 라인
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffCBCBCB), width: 2.0),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                  ),
                                  maxLines: 1,
                                  minLines: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                Container(
                  margin: EdgeInsets.only(bottom: 200),
                  // height: 50,
                  width: 200,
                  color: Colors.blueAccent,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        Container(
                          child: _passWord(context),
                        );
                      });
                   },
                    child: Text("확 인",
                    style: TextStyle(fontSize: 20),),
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(
                            horizontal:11.w,
                            vertical:14.h)),
                  ),
                )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  height: 70.h,
                  color: Colors.blueAccent,
                  child: ElevatedButton(
                    child: Text(
                      "회 원 가 입 하 기",
                      style: TextStyle(
                          fontSize: 20.w,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                    ), onPressed: () {  },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  //확인버튼
  Widget okBtn(BuildContext context) {
    //위젯모양을 둥글게,
    //ClipRRect를 사용.ClipRRect는 2가지 속성이 있다 borderRadius와 child다.
    return ClipRRect(
      borderRadius:
      BorderRadius.all(
          Radius.circular(3)),
      child: Container(
        margin: EdgeInsets.only(bottom: 200),
        height: 50,
        width: 150,
        color: Colors.blueAccent,
        child: TextButton(
          onPressed: () {

          },
          child: Text("확 인"),
          style: TextButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets
                  .symmetric(
                  horizontal:
                  11.w,
                  vertical:
                  14.h)),
        ),
      ),
    );
  }



  //비밀번호
  Widget _passWord(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15.w, bottom: 20.w),
          child: Text("비밀번호"),
        ),
        Container(
          margin: EdgeInsets.only(right: 15.w),
          height: 60.h,
          width: 250.w,
          child: TextFormField(
            onSaved: (String? val) {},
            onChanged: (text) {
              _pw = text;
            },
            autovalidateMode: AutovalidateMode.always,
            validator: (String? val) {
              if (val!.length < 1) {
                return "비밀번호 필수";
              }
              if (val.length < 4) {
                return '비밀번호는 네 글자 이상 입력.';
              }
              return null;
            },
            scrollPadding: EdgeInsets.only(
                bottom:
                MediaQuery.of(context).viewInsets.bottom),
            textInputAction: TextInputAction.next,
            textAlignVertical: TextAlignVertical.center,
            controller: pwController,
            decoration: InputDecoration(
              hintText: "비밀번호를 입력하세요.",
              hintStyle: TextStyle(
                  fontSize: 15.w, color: Color(0xffA3A3A3)),
              contentPadding: EdgeInsets.only(left: 10.w),
              //테두리두께
              border: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(2.0)),
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffCBCBCB), width: 2.0),
                borderRadius:
                BorderRadius.all(Radius.circular(5.0)),
              ),

              //텍스트필드 선택시 포커스 라인
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffCBCBCB), width: 2.0),
                borderRadius:
                BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            maxLines: 1,
            minLines: 1,
          ),
        )
      ],
    );
  }

  //이름
  Widget _name() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Text("이 름"),
        ),
        Container(
          margin: EdgeInsets.only(right: 15.w),
          height: 50.h,
          width: 250.w,
          child: TextField(
            scrollPadding: EdgeInsets.only(
                bottom:
                MediaQuery.of(context).viewInsets.bottom),
            textInputAction: TextInputAction.next,
            textAlignVertical: TextAlignVertical.center,
            // controller: textController,
            // inputFormatters: [
            //   FilteringTextInputFormatter.allow(
            //       RegExp('[ㄱ-ㅎ가-힣]'))
            // ],
            decoration: InputDecoration(
              hintText: "실명을 입력하세요.",
              hintStyle: TextStyle(
                  fontSize: 15.w, color: Color(0xffA3A3A3)),
              contentPadding: EdgeInsets.only(left: 10.w),
              //테두리두께
              border: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(2.0)),
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffCBCBCB), width: 2.0),
                borderRadius:
                BorderRadius.all(Radius.circular(5.0)),
              ),

              //텍스트필드 선택시 포커스 라인
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffCBCBCB), width: 2.0),
                borderRadius:
                BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            maxLines: 1,
            minLines: 1,
          ),
        )
      ],
    );
  }



  //휴대폰번호
  Widget _phonNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Text("휴대폰 번호"),
        ),
        Container(
          margin: EdgeInsets.only(right: 15.w),
          height: 50.h,
          width: 250.w,
          child: TextFormField(
            scrollPadding: EdgeInsets.only(
                bottom:
                MediaQuery.of(context).viewInsets.bottom),
            textInputAction: TextInputAction.next,
            textAlignVertical: TextAlignVertical.center,
            // controller: textController,
            keyboardType: TextInputType.phone,

            // inputFormatters: [
            //   FilteringTextInputFormatter.allow(
            //       RegExp(r'^([0-9]{3})-?([0-9]{4})-?([0-9]{4})$'))
            // ],
            //11자리 제한
            inputFormatters: [
              LengthLimitingTextInputFormatter(11)
            ],
            decoration: InputDecoration(
              hintText: " '-' 구분 없이 입력.",
              hintStyle: TextStyle(
                  fontSize: 15.w, color: Color(0xffA3A3A3)),
              contentPadding: EdgeInsets.only(left: 10.w),
              //테두리두께
              border: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(2.0)),
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffCBCBCB), width: 2.0),
                borderRadius:
                BorderRadius.all(Radius.circular(5.0)),
              ),

              //텍스트필드 선택시 포커스 라인
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffCBCBCB), width: 2.0),
                borderRadius:
                BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            maxLines: 1,
            minLines: 1,
          ),
        )
      ],
    );
  }


}
