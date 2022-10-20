import 'dart:math';

import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(new ControlleApp());
}


class ControlleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "My App",
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  bool visibilityName = true;
  bool visibilityPw = false;
  bool visibilityId = false;
  bool visibilityBtn = true;

  // FocusNode textFocus = FocusNode();
  late FocusNode pwFocusNode;
  late FocusNode idFocusNode;

  bool _visibilityPw = false;
  bool _visibilityId = false;


  // AnimationController _controller;
  // Animation<Size> _heightAnimation;


  void _changed(bool visibility, String field) {
    print("### enter _changed");
    setState(() {
      if (field == "pw"){
        print("### enter if pw");
        visibilityPw = visibility;
        print("### visibilityPw" + visibilityPw.toString());
      }

      if (field == "name"){
        visibilityName = visibility;
      }

      if (field == "id"){
        visibilityId = visibility;
      }

      if (field == "button"){
        visibilityBtn = visibility;
      }

    });
  }

// 폼이 생성될 때 호출
  @override
  void initState() {
    super.initState();
    // myFocusNode에 포커스 인스턴스 저장.
    pwFocusNode = FocusNode();
    idFocusNode = FocusNode();
  }

  // 폼이 삭제될 때 호출
  @override
  void dispose() {
    // 폼이 삭제되면 myFocusNode도 삭제됨
    pwFocusNode.dispose();
    idFocusNode.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context){

    return GestureDetector(
      onTap: () {
        // inputbox 바깥 탭 시에  "키보드 닫힘"
        //키보드가 닫히는 이유는, 새로운 포커스를 새로 잡기 때문에
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          // appBar: AppBar(backgroundColor: Colors.white),
          body: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 80, left: 20, bottom: 20),
                child: Text(
                  "본인 확인을 위해 \n"
                      "이름을 입력해 주세요",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),


              Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Column(
                    children: <Widget>[

                      //이름 텍스트필드
                      visibilityName ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            flex: 11,
                            child: TextFormField(
                              autofocus: true,
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (text){
                                _changed(true, "pw");
                                setState(() {
                                  _changed(false, "button");
                                  FocusScope.of(context).requestFocus(pwFocusNode);
                                  _visibilityPw = true;
                                  // _visible = !_visible;
                                });
                              },
                              style: Theme.of(context).textTheme.headline6,
                              decoration: InputDecoration(
                                  labelText: "이름",
                                  isDense: true
                              ),
                            ),
                          ),
                        ],
                      ) : Container(),

                      //비밀번호 텍스트필드
                      AnimatedOpacity(
                        opacity: _visibilityPw ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.easeIn,
                        child: Container(
                          child: visibilityPw ? Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                flex: 11,
                                child: TextFormField(
                                  maxLines: 1,
                                  textInputAction: TextInputAction.next,
                                  focusNode: pwFocusNode,
                                  onFieldSubmitted: (text){
                                    _changed(true, "id");
                                    setState(() {
                                      FocusScope.of(context).requestFocus(idFocusNode);
                                      _visibilityId = true;
                                    });
                                  },
                                  style: Theme.of(context).textTheme.headline6,
                                  decoration: InputDecoration(
                                      labelText: "비밀번호",
                                      isDense: true
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  color: Colors.grey[400],
                                  icon: Icon(Icons.cancel, size: 22.0,),
                                  onPressed: () {
                                    _changed(false, "pw");
                                  },
                                ),
                              ),
                            ],
                            //공간차지 x  = 사이즈박스쉬링크
                          ) : SizedBox.shrink(),
                        ),
                      ),

                      //아이디 텍스트필드
                      AnimatedOpacity(
                        opacity: _visibilityId ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.easeIn,
                        child: Container(
                          child: visibilityId ? Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                flex: 11,
                                child: TextFormField(
                                  maxLines: 1,
                                  focusNode: idFocusNode,
                                  textInputAction: TextInputAction.done,
                                  style: Theme.of(context).textTheme.headline6,
                                  onFieldSubmitted: (text) {
                                    // FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                      labelText: "아이디",
                                      isDense: true
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  color: Colors.grey[400],
                                  icon: Icon(Icons.cancel, size: 22.0,),
                                  onPressed: () {
                                    _changed(false, "id");
                                  },
                                ),
                              ),
                            ],
                            //공간차지 x  = 사이즈박스쉬링크
                          ) : SizedBox.shrink(),
                        ),
                      ),


                      //이름 입력시 "확인버튼" 활성화
                      visibilityBtn ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            flex: 11,
                            child: TextButton(
                              style: TextButton.styleFrom(backgroundColor: Colors.blue),
                              onPressed: () {
                                _changed(true, "pw");
                                setState(() {
                                  _changed(false, "button");
                                  FocusScope.of(context).requestFocus(pwFocusNode);
                                });
                              },
                              child: Text("확인", style: TextStyle(color: Colors.white),),
                            )
                          ),
                        ],
                      ) : SizedBox.shrink(),
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}
