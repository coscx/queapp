
/// 说明:
///
//    {
//      "widgetId": 126,
//      "name": 'Dialog基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 动画图标数据   【Widget】\n"
//          "【elevation】 : 影深  【double】\n"
//          "【backgroundColor】 : 背景色  【Color】\n"
//          "【shape】 : 形状   【ShapeBorder】",
//    }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/app/utils/Toast.dart';
import 'package:flutter_geen/storage/dao/local_storage.dart';
import 'package:flutter_geen/views/pages/home/home_page.dart';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        _buildDialog(),
      ],
    );
  }

   Widget _buildDialog() => Dialog(
    backgroundColor: Colors.white,
    elevation: 5,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Container(
      width: 50,
      child: DeleteDialog(),
    ),
  );

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: Colors.blue,
    onPressed: () {
      showDialog(context: context, builder: (ctx) => _buildDialog());
    },
    child: Text(
      'Just Show It !',
      style: TextStyle(color: Colors.white),
    ),

  );
}

class DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //_buildBar(context),
          SizedBox(height: 20,),
          _buildTitle(),
          _buildContent(),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      '温馨提示',
      style: TextStyle(color: Colors.black, fontSize: 20),
    );
  }

  Widget _buildContent() {
    return  Container(
        height: 200,
        padding: const EdgeInsets.fromLTRB(25,10,25,10),
        child:   ScrollConfiguration(
        behavior: DyBehaviorNull(),
        child:SingleChildScrollView(
                 scrollDirection: Axis.vertical,
                 child:Column(
                    children: <Widget>[
                       Text("温馨提示温馨提示温馨提示温馨馨提! \n示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温"
                          "馨提示温馨", style:  TextStyle(color: Colors.black54,fontSize: 16),),
                       Text("温馨提示温馨提示温馨提示温馨馨提! \n示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温"
                          "馨提示温馨", style:  TextStyle(color: Colors.black54,fontSize: 16),),
            Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.end,
                children: <Widget>[
              Text("和和和和和和和和", style:  TextStyle(color: Colors.black54,fontSize: 16),),
                          InkWell(
                              onTap: (){},
                              child:Text("用户服务协议", style:  TextStyle(color: Colors.blue,fontSize: 16,decoration: TextDecoration.underline,
                                decorationColor:  Colors.blue,),)),
                          Text("和", style: new TextStyle(color: Colors.black54,fontSize: 16),),
                          InkWell(
                              onTap: (){},
                              child:Text("隐私政策", style:  TextStyle(color: Colors.blue,fontSize: 16,decoration: TextDecoration.underline,
                                decorationColor:  Colors.blue,),)),
                          Text("和和和和和", style:  TextStyle(color: Colors.black54,fontSize: 16),),

                        ])

                    ],
                )
             )));
  }

  Widget _buildFooter(context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15.0, top: 10,left: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: (){
                        Fluttertoast.showToast(
                        msg: "请同意用户服务协议和隐私政策后我们才能继续为您提供服务",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        fontSize: 14.0);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.black12
                ),

                child: Text('不同意',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
            ),
            InkWell(
              onTap: () {
                LocalStorage.save("agree", '1');
                Navigator.of(context).pushReplacementNamed(UnitRouter.nav);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.blue
                ),

                child: Text('同意',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ),

          ],
        ),

    )

    ;
  }

  _buildBar(context) => Container(
    height: 30,
    alignment: Alignment.centerRight,
    margin: EdgeInsets.only(right: 10, top: 5),
    child: InkWell(
      onTap: ()=>Navigator.of(context).pop(),
      child: Icon(
        Icons.close,
        color: Color(0xff82CAE3),
      ),
    ),
  );
}
