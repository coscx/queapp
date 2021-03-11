
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/big_data_menu_entity.dart';
import 'package:flutter_geen/blocs/bigdata/big_data_bloc.dart';
import 'package:flutter_geen/blocs/bigdata/big_data_state.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/storage/dao/local_storage.dart';
import 'package:flutter_geen/views/items/web_brows.dart';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';

// 去除安卓滚动视图水波纹


/// 该页头部为自定义手势实现的与斗鱼安卓APP相同效果，而不是像首页那样直接调用Flutter封装好的[AppBar]的交互。
// 所有Widget继承的抽象类
abstract class DYBase {
  static final baseSchema = 'http';
  static final baseHost = 'dou.guguteam.com';
  static final basePort = '80';
  static final baseWsPort = '1236';
  static final baseUrl = '${DYBase.baseSchema}://${DYBase.baseHost}:${DYBase.basePort}';
  // 默认斗鱼主题色
  static final defaultColor = Color(0xffff5d23);
  // 初始化设计稿尺寸
  static final double dessignWidth = 375.0;
  static final double dessignHeight = 1335.0;

}


// 页面总结构
class FocusPage extends StatefulWidget with DYBase {
  double headerHeightMax;
  FocusPage() {
    headerHeightMax =  55;
  }

  @override
  _FocusPage createState() => _FocusPage(headerHeightMax);
}

class _FocusPage extends State<FocusPage> with DYBase, TickerProviderStateMixin {
  double _headerHeight;
  double _headerOpacity = 1.0;
  Tween<double> _opacityTween, _heightTween;
  bool _isAnimating = false;
  PointerDownEvent _pointDownEvent;

  _FocusPage(this._headerHeight);

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    BlocProvider.of<BigDataBloc>(context).add(EventGetBigData());
  }

  List<Widget> _colorBlock(BigDataMenuEntity menu) {
    var res = <Widget>[];
    var list = menu.data;
    for (int i = 0; i < list.length; i++) {
      res.add(InkWell(
        onTap: () async {
          // BlocProvider.of<DataBloc>(context).add(EventGetData());
          // Navigator.pushNamed(context, UnitRouter.index_page);
          var ss = await LocalStorage.get("token");
          var sss =ss.toString();
          int coordinates = await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return  WebViewPageUI(
              title: list[i].name,
              url: list[i].url+"?token="+sss,
            );
          }));
          if(coordinates==100){
            ///这里填上当接收回调成功后要执行的操作
          }
        },
        child:Container(
            margin: EdgeInsets.only(top: (10), left: (10), right: (10)),
            height: (110),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(width: (2), color: Color(list[i].color)),
            ),
            child: Center(
              child:  Text(
               list[i].name,
                style: TextStyle(
                  color: Color(list[i].color),
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

  void _onPointerMove(PointerMoveEvent e) {
    var nextHeight = _headerHeight + e.delta.dy;

  }

  void _onPointerDown(PointerDownEvent e) {
    _pointDownEvent = e;
  }

  void _onPointerUp(PointerUpEvent e) {
    double headerHeightNow = _headerHeight,
        headerOpacityNow = _headerOpacity,
        direction;  // header动画方向，1-展开；0-收起

    // 快速滚动捕获，触摸松开间隔小于300ms直接根据滚动方向伸缩header
    if (
    (_pointDownEvent != null) &&
        (e.timeStamp.inMilliseconds - _pointDownEvent.timeStamp.inMilliseconds < 300)
    ) {
      if (e.position.dy > _pointDownEvent.position.dy) {
        direction = 1;
      } else {
        direction = 0;
      }
    }
    // 滚动松开时header高度一半以下收起
    else if (_headerHeight < (widget.headerHeightMax / 2 + (15))) {
      direction = 0;
    }
    // 超过一半就完展开
    else {
      direction = 1;
    }

    setState(() {
      if (direction == 0) {

        _headerOpacity = 0;
      } else {
        _headerHeight = widget.headerHeightMax;
        _headerOpacity = 1;
      }
      _heightTween = Tween(
        begin: headerHeightNow, end: _headerHeight,
      );
      _opacityTween = Tween(
        begin: headerOpacityNow, end: _headerOpacity,
      );
      _isAnimating = true;
    });
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
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("大数据",style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold)),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: BlocBuilder<BigDataBloc, BigDataState>(builder: _buildContent),


    ));
  }


  Widget _buildContent(BuildContext context, BigDataState state) {
    if (state is GetBigDataSuccess) {
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
                  children: _colorBlock(state.big),
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