import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/storage/dao/widget_dao.dart';


class AppSearchBar extends StatefulWidget {


  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  TextEditingController _controller=TextEditingController();//文本控制器
  bool showClear =true;
  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Color(0xFFf8f8f8)),
        height: 38,
        child:
        TextField(
          autofocus: false, //自动聚焦，闪游标
          controller: _controller,
          maxLines: 1,
          decoration:  InputDecoration(
            hintText: '手机号、用户名...',
            hintStyle: TextStyle(
              fontSize: 14,
            ),
            suffixIcon: showClear?
            Container(
              padding: EdgeInsets.only(top: 0),
              child: IconButton(
                icon: Icon(Icons.clear,
                    color: Color(0xFF444444)
                ),
                onPressed: () {
                  // 清空搜索内容
                  _controller.clear();
                },
              ),
            )
            :Container(),
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xFF444444),
            ),
            border: InputBorder.none,
          ),
          onChanged: (str) => {
            if(str.length > 0){

            }else{

            }
          },

          onSubmitted: (str) {//提交后
            BlocProvider.of<SearchBloc>(context)
                .add(EventTextChanged(args:SearchArgs(name: str,stars: [1,2,3,4,5])));
            BlocProvider.of<GlobalBloc>(context).add(EventSearchPhotoPage(0));
            FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
//            _controller.clear();
          },
        ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
