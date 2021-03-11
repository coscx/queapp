import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geen/views/pages/utils/DyBehaviorNull.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_geen/views/pages/home/home_page.dart';
typedef FilterBarCallback = void Function(bool isSelected);

class DropMenuHeader extends StatefulWidget implements PreferredSizeWidget {
  DropMenuHeader({
    @required this.height,
    this.items,
    this.selectedIndex
  });

  double height;
  final List<ButtonModel> items;
  final int selectedIndex;
  Size get preferredSize => Size.fromHeight(height);

  @override
  _dropMenuHeaderState createState() {
    // TODO: implement createState
    return new _dropMenuHeaderState();
  }
}

class ButtonModel {
  final String text;
  final Color normalColor;
  final Color selectedColor;
  String imageName;
  bool dataSelected;
  FilterBarCallback onTap;

  ButtonModel(
      {this.text,
      this.normalColor,
      this.selectedColor,
      this.imageName =
      "assets/images/dropMenu_images/mmc_dropMenu_up_normal@2x.png",
      this.dataSelected = false,
      this.onTap});
}

class _dropMenuHeaderState extends State<DropMenuHeader> {
  int _selectedIndex ;

  @override
  void initState() {
    super.initState();
    _selectedIndex=widget.selectedIndex;
  }
  _button(ButtonModel buttonModel) {
    int index = widget.items.indexOf(buttonModel);

    // return RLKBLoCBuilder(
    //     builder: (BuildContext context, Map data, RLKBaseBLoC bloc) {
    //
    //   if (data["selectedIndex"] == 999) {
    //     _selectedIndex = 999;
    //   }
    //
    //   if(buttonModel.text == "筛选") {
    //     buttonModel.dataSelected = data["filterData"];
    //   }
      return Container(
          color: Colors.white,
          padding: EdgeInsets.all(0),
          height: 44.h,
          child: GestureDetector(
            onTap: () {
              if (_selectedIndex == index) {
                
                _selectedIndex = 999;
              } else {
                
                _selectedIndex = index;
              }
              //bloc2.headerUnSelect(0);
              buttonModel.onTap(index == _selectedIndex);
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          buttonModel.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: buttonModel.dataSelected
                                ? buttonModel.selectedColor ?? Color(0xFFF12E49)
                                : buttonModel.normalColor ?? Color(0xFF333333),
                            fontSize: 38.sp,
                          ),
                        ),
                      ),
                      index == _selectedIndex ?Icon(Icons.keyboard_arrow_up,
                        color: Colors.black,):Icon(Icons.keyboard_arrow_down,
                        color: Colors.black,)
                      ,
                      // Image(
                      //   image: AssetImage((index == _selectedIndex)
                      //       ? 'assets/images/dropMenu_images/mmc_dropMenu_down_normal@2x.png'
                      //       : 'assets/images/dropMenu_images/mmc_dropMenu_up_normal@2x.png'),
                      //   width: 20,
                      //   height: 20,
                      //   color: buttonModel.dataSelected
                      //       ? buttonModel.selectedColor ?? Color(0xFFF12E49)
                      //       : buttonModel.normalColor ?? Color(0xFF333333),
                      // ),

                      index == widget.items.length - 1
                          ? Container()
                          : Container(
                              height: widget.height,
                              color: Color(0xFFE5E5E5),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ));
    //   );
    // });
  }

  double _screenWidth;
  int _menuCount;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _menuCount = widget.items.length;

    return Container(
      height: widget.height,
      child: ScrollConfiguration(
        behavior: DyBehaviorNull(),
    child: GridView.count(
        crossAxisCount: _menuCount,
        //子Widget宽高比例
        childAspectRatio: (_screenWidth / _menuCount) / widget.height,
        children: widget.items.map<Widget>((item) {
          return _button(item);
        }).toList(),
      )),
    );
  }
}
