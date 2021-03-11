
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/blocs/user/user_bloc.dart';
import 'package:flutter_geen/blocs/user/user_event.dart';
import 'package:flutter_geen/blocs/user/user_state.dart';
import 'package:flutter_geen/views/pages/home/home_page.dart';
import 'package:flutter_geen/storage/dao/local_storage.dart';
import 'package:flutter_geen/blocs/peer/peer_bloc.dart';
import 'package:flutter_geen/blocs/peer/peer_event.dart';
import 'package:flt_im_plugin/conversion.dart';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';
// 页面总结构
class UserPage extends StatefulWidget {

  UserPage();

  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> with TickerProviderStateMixin {
  double _headerHeight;
  double _headerOpacity = 1.0;
  Tween<double> _opacityTween, _heightTween;
  bool _isAnimating = false;
  PointerDownEvent _pointDownEvent;

  _UserPage();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    BlocProvider.of<UserBloc>(context).add(EventGetUser());
  }

  List<Widget> _colorBlock(Map<String, dynamic> menu) {
    var res = <Widget>[];
    var list = menu['data'];
    for (int i = 0; i < list.length; i++) {
      res.add(InkWell(
        onTap: () async {
          var memberId = await LocalStorage.get("memberId");
          if(memberId != "" && memberId != null){
            memberId=memberId.toString();
          }
          BlocProvider.of<PeerBloc>(context).add(EventFirstLoadMessage(memberId,list[i]['id'].toString()));
          final Conversion model = Conversion.fromMap({"memId":memberId,"cid":list[i]['id'].toString(),"name":list[i]['relname']+"("+list[i]['id'].toString()+")"});
          Navigator.pushNamed(context, UnitRouter.to_chats, arguments: model);
        },
        child:Container(
            margin: EdgeInsets.only(top: (10), left: (10), right: (10)),
            height: (110),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(width: (2), color: Colors.black),
            ),
            child: Center(
              child:  Text(
                list[i]['relname'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: (38),
                  fontWeight: FontWeight.bold,
                ),
              ),

            )
        ),
      ));
    }



    return res;
  }

  /// 在[ListView]之上无法通过[GestureDetector]进行手势捕获，因为部分手势（如上下滑）会提前被[ListView]所命中。
  /// 所以在整个页面的最外层使用底层[Listener]监听原始触摸事件，判断手势需要自己取坐标计算。
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(
            brightness: Brightness.light,
          ),
        ),
        child:Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("用户",style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: BlocBuilder<UserBloc, UserState>(builder: _buildContent),


        ));
  }


  Widget _buildContent(BuildContext context, UserState state) {
    if (state is GetUserSuccess) {
      return       Container(
        child:Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ScrollConfiguration(
                behavior: DyBehaviorNull(),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  children: _colorBlock(state.user),
                ),
              ),
            ),
          ],
        ),
      ) ;

    }

    return
      Container(
        color: Colors.white,
      );
  }
}