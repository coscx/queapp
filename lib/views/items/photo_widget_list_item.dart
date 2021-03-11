import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/res/style/shape/techno_shape.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'package:flutter_geen/app/res/style/shape/coupon_shape_border.dart';
import 'package:flutter_geen/blocs/collect/collect_bloc.dart';
import 'package:flutter_geen/blocs/collect/collect_state.dart';
import 'package:flutter_geen/blocs/detail/detail_bloc.dart';
import 'package:flutter_geen/blocs/detail/detail_event.dart';
import 'package:flutter_geen/blocs/home/home_bloc.dart';
import 'package:flutter_geen/blocs/home/home_event.dart';
import 'package:flutter_geen/components/permanent/circle_image.dart';
import 'package:flutter_geen/components/permanent/circle_text.dart';
import 'package:flutter_geen/components/permanent/feedback_widget.dart';
import 'package:flutter_geen/components/permanent/tag.dart';
import 'package:flutter_geen/views/dialogs/delete_category_dialog.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/views/dialogs/delete_category_dialog.dart';
import 'package:flutter_geen/views/pages/home/PreviewImagesWidget.dart';
import 'package:flutter_geen/views/pages/widget_detail/widget_detail_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:left_scroll_actions/cupertinoLeftScroll.dart';
import 'package:left_scroll_actions/leftScroll.dart';
import 'package:lottie/lottie.dart';
class PhotoWidgetListItem extends StatelessWidget {
  final bool hasTopHole;
  final bool hasBottomHole;
  final bool isClip;
  final bool showBadge;
  final Map<String,dynamic>  photo;
  PhotoWidgetListItem(
      {
      this.hasTopHole = true,
      this.hasBottomHole = false,
      this.isClip = true,
      this.photo,
      this.showBadge
      });

  final List<int> colors = Cons.tabColors;

  @override
  Widget build(BuildContext context) {
    return CupertinoLeftScroll(
      buttonWidth: 60.w,
      bounce: true,
      child: Container(
        //height: 60,
        color: Colors.white,
        alignment: Alignment.center,
        child: Container(
          margin:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: Stack(
              children: <Widget>[
                Material(
                    color: Theme.of(context).primaryColor.withAlpha(33),
                    shape: true ? TechnoShapeBorder(color: Theme.of(context).primaryColor.withAlpha(100)) : null,
                    child:
                    isClip
                        ? ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: CouponShapeBorder(
                              hasTopHole: hasTopHole,
                              hasBottomHole: hasBottomHole,
                              hasLine: false,
                              edgeRadius: 25.w,
                              lineRate: 0.20)),
                      child: buildContent( context),
                    )
                        : Container(
                        padding:  EdgeInsets.only(top: 10.h,bottom: 10.h,left: 10.w,right: 10.w),
                        child:
                        Column(
                          children: [
                            FeedbackWidget(
                              onPressed: () {
                                BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(photo));
                                Navigator.pushNamed(context, UnitRouter.widget_detail);
                              },
                              child:  buildContent( context),
                            ),

                            //buildMiddle(context),

                          ],
                        ))

                ),
                _buildCollectTag(Theme.of(context).primaryColor, showBadge)
              ]
          )
      ),
      ),
      buttons: <Widget>[

        LeftScrollItem(
          text: 'Delete',
          color: Colors.red,
          onTap: () {
            print('delete');
          },
        ),
        LeftScrollItem(
          text: 'Edit',
          color: Colors.orange,
          onTap: () {
            print('edit');
          },
        ),
      ],
      onTap: () {
        print('tap row');
      },
    );
  }
Widget buildCard (BuildContext context,Map<String,dynamic> img){
    return     Stack(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[

                Column(
                  children:<Widget> [
                 GestureDetector(

                onLongPress: () => _onLongPress(context,img['imagepath']),
                child: Container(
                      child: CachedNetworkImage(imageUrl: img['imagepath'],
                      width: 80.w,
                      height: 150.h,
                      ),
                      )

                )



                  ],

                ),

              ],

            ),
            padding: const EdgeInsets.all(2),
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),

          Positioned(
              top: 5.h,
              right: 5.w,
              child:
              FeedbackWidget(
                onPressed: () {
                  _deletePhoto(context,img);
                },
                child: const Icon(
                  CupertinoIcons.delete_solid,
                  color: Colors.red,
                ),
              )
          ),
        ]
    );

}

  Widget buildAiFaceCard (BuildContext context,Map<String,dynamic> img){
    return   ClipPath(
      clipper: ShapeBorderClipper(
          shape: CouponShapeBorder(
              hasTopHole: false,
              hasBottomHole: false,
              hasLine: true,
              edgeRadius: 5.w,
              lineRate: 0.10)),
      child: Stack(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[

                  Column(
                    children:<Widget> [
                      GestureDetector(

                          onLongPress: () => _onLongPress(context,img['imagepath']),
                          child: Container(
                            child: CachedNetworkImage(imageUrl: img['imagepath'],
                              width: 80.w,
                              height: 150.h,
                            ),
                          )

                      )



                    ],

                  ),

                ],

              ),
              padding:  EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
              ),
            ),


          ]
      ),
    );

  }
  _onLongPress(BuildContext context,  String img) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (c, a, s) => PreviewImagesWidget([img],initialPage: 1,)));
  }
  Widget buildMiddle (BuildContext context,){
    List<dynamic> imgList =photo['imageurl'];
    List<Widget> list = [];
    imgList.map((images) => {

      list.add( buildCard(context,images))

    }


    ).toList();
    return          Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child:
          Wrap(
          spacing: 5.w, //主轴上子控件的间距
            runSpacing: 0, //交叉轴上子控件之间的间距
            children: [
              ...list,
              buildFaceCard(context,photo['faceurl'])
            ],

          )
        ),

        buildWhereButton( context,photo['checked'])

        ]
    );
  }
  Widget buildFaceCard(BuildContext context,dynamic url){

    if (url is Map){
     return  buildAiFaceCard(context,url);
    }else{
      return Container();
    }



  }

  Widget buildWhereButton(BuildContext context,int checked){

    if (checked==1){
      return Column(
        children: [

          buildRefuseButton(context,"拒绝",Colors.red),
          build100Button(context,"通过1",Colors.green),
          build80Button(context,"通过2",Colors.blue),
          build60Button(context,"通过3",Colors.purple),
          buildHideButton(context,"隐藏",Colors.deepPurple),

        ],
      );
    }else{
      return Column(
        children: [

          buildResetButton(context,"撤回",Colors.red),


        ],
      );
    }



  }
  _deletePhoto(BuildContext context,Map<String,dynamic> img) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Container(
            width: 50.w,
            child: DeleteCategoryDialog(
              title: '删除图片',
              content: '是否确定继续执行?',
              onSubmit: () {
                BlocProvider.of<HomeBloc>(context).add(EventDelImg(img,1));
                Navigator.of(context).pop();
              },
            ),
          ),
        ));
  }
  _refuseUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            width: 50.w,
            child: DeleteCategoryDialog(
              title: '拒绝此用户',
              content: '是否确定继续执行?',
              onSubmit: () {
                BlocProvider.of<HomeBloc>(context).add(EventCheckUser(photo,1));
                Navigator.of(context).pop();
              },
            ),
          ),
        ));
  }
  _resetUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Container(
            width: 50.w,
            child: DeleteCategoryDialog(
              title: '撤回此用户的审核结果',
              content: '是否确定继续执行?',
              onSubmit: () {
                BlocProvider.of<HomeBloc>(context).add(EventResetCheckUser(photo,1));
                Navigator.of(context).pop();
              },
            ),
          ),
        ));
  }
  _hideUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            width: 50.w,
            child: DeleteCategoryDialog(
              title: '隐藏该用户',
              content: '是否确定继续执行?',
              onSubmit: () {
                BlocProvider.of<HomeBloc>(context).add(EventCheckUser(photo,5));
                Navigator.of(context).pop();
              },
            ),
          ),
        ));
  }
  Widget buildButton(BuildContext context,String txt,MaterialColor color){
    return    Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          color: color,
          onPressed: (){

          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        ),
      ],
      );
}
  Widget build100Button(BuildContext context,String txt,MaterialColor color){
    return    Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          color: color,
          onPressed: (){
            BlocProvider.of<HomeBloc>(context).add(EventCheckUser(photo,2));
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        ),
      ],
    );
  }
  Widget build80Button(BuildContext context,String txt,MaterialColor color){
    return    Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: color,
          onPressed: (){
            BlocProvider.of<HomeBloc>(context).add(EventCheckUser(photo,3));
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ],
    );
  }
  Widget build60Button(BuildContext context,String txt,MaterialColor color){
    return    Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: color,
          onPressed: (){
            BlocProvider.of<HomeBloc>(context).add(EventCheckUser(photo,4));
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ],
    );
  }
  Widget buildRefuseButton(BuildContext context,String txt,MaterialColor color){
    return    Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: color,
          onPressed: (){
            _refuseUser(context);
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ],
    );
  }
  Widget buildResetButton(BuildContext context,String txt,MaterialColor color){
    return    Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: color,
          onPressed: (){
            _resetUser(context);
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ],
    );
  }
  Widget buildHideButton(BuildContext context,String txt,MaterialColor color){
    return    Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: color,
          onPressed: (){
            _hideUser(context);
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ],
    );
  }
  Widget buildContent(BuildContext context) => Container(
        color: Colors.lightBlue.withAlpha(0),
        height: 170.h,
        padding:  EdgeInsets.only(top: 0.h, left: 0, right: 10.w, bottom: 10.h),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                buildLeading(),

                  Expanded(
                    child: Container(
                      padding:  EdgeInsets.only(top: 0.h, left: 10.h, right: 0.w, bottom: 0.h),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         // _buildTitle(),
                          _titleTop(),
                          _buildMiddles(),
                          _buildSummary(),

                        ],
                      ),
                    ),
                  ),

              ],
            ),
          ],
        ),
      );

  Widget buildLeading() => Padding(
        padding:  EdgeInsets.only(top: 10.h),
        child: Container(
          //tag: "hero_widget_image_${photo['uuid'].toString()}",
          child: (photo['head_img'] == "" || photo['head_img'] ==null)
              ? Container(
                   // width: 100.w,
                   // height: 100.h,h
                  color: Colors.transparent,
                  child: CircleText(
                    text: photo['name'],
                    size: 130.h,
                    fontSize: 50.sp,
                    color: invColor,
                    shadowColor: Colors.transparent,
                  ),
                )
              : Container(
            child: Container(
              padding:  EdgeInsets.only(left: 10.w, bottom: 1.h, top: 1.h,right: 10.w),
              child: CircleAvatar(
                foregroundColor: Colors.white10,
                radius:(70.w) ,
                child: ClipOval(
                  child: photo['head_img'] ==null ?Container():CachedNetworkImage(imageUrl: photo['head_img'],
                    fit: BoxFit.cover,
                    width: 140.w,
                    height: 140.h,

                  ),
                ),
              ),
            ),
          )
          ,
        ),
      );

  Color get invColor {
    return Colors.blue;
  }

  Widget _buildCollectTag(Color color,bool show) {
    return Positioned(
        top: 0,
        right: 40.w,
        child:Opacity(
            opacity: show? 1.0:0 ,
            child: SizedOverflowBox(
              alignment: Alignment.bottomCenter,
              size:  Size(0, 70.h),
              child: Container(
                width: 100.h,
                height: 100.h,
                margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
                child:Lottie.asset('assets/packages/lottie_flutter/medal.json'),
              ),
            ),
          )
        );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Row(
        children: <Widget>[
           SizedBox(width: 1.w),
          Expanded(
            child: Text(photo['name']+" "+(photo['gender']==1?"男":"女")+" "+photo['age'].toString()+"岁 "+""+((photo['height']==0||photo['height']==null)?"": photo['height'].toString()+"cm")+" "+(photo['status']==0?"C级":(photo['status']==1?"B级":"A级")),
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: Colors.white, offset: Offset(.3, .3))
                    ])),
          ),

          // StarScore(
          //   star: Star(emptyColor: Colors.white, size: 15, fillColor: invColor),
          //   score: data.lever,
          // ),
        ],
      ),
    );
  }
  List<String> _marriageLevel = [
    "未知",
    "未婚",
    "离异带孩",
    "离异单身",
    "离异未育",
    "丧偶",
  ];

  List<String> _hasHouseLevel = [
    "未知",
    "无房",
    "1套房",
    "2套房",
    "3套房及以上",
    "其他",
  ];

  List<String> _hasCarLevel = [
    "",
    "有车",
    "无车",
  ];

  Widget _titleTop() {
    return Padding(
      padding:  EdgeInsets.only(left: 1.w, bottom: 0.h, top: 5.h),
      child: Container(
        child: Text(photo['name']+" "+(photo['gender']==1?"男":"女")+" "+photo['age'].toString()+"岁 "+""+((photo['height']==0||photo['height']==null)?"": photo['height'].toString()+"cm")+" "+(photo['status']==0?"C级":(photo['status']==1?"B级":"A级")),
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(color: Colors.white, offset: Offset(.3, .3))
                ])),
      ),
    );
  }
  Widget _buildSummary() {
    return Padding(
      padding:  EdgeInsets.only(left: 1.w, bottom: 0.h, top: 5.h),
      child: Container(
        child: Text(
          //尾部摘要
          (photo['has_house']==null?"":_hasHouseLevel[photo['has_house']])+" "+(photo['has_car']==null?"":_hasCarLevel[photo['has_car']])+" " +(_marriageLevel[photo['marriage']]) +" 生日:" +(photo['birthday']==null ? "-":photo['birthday'].toString().substring(0,10)),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black, fontSize: 23.sp, shadows: [
            const Shadow(color: Colors.white, offset: const Offset(.5, .5))
          ]),
        ),
      ),
    );
  }
  Widget _buildMiddles() {
    return Padding(
      padding:  EdgeInsets.only(left: 1.w, bottom: 0.h, top: 5.h),
      child: Container(
        child: Text(
          //尾部摘要
         (photo['sale_name']==null?"": "红娘: "+photo['sale_name'].toString())+" 沟通"+photo['connect_count'].toString()+"次 " +(photo['appointment_count']==0?"未排约":(photo['appointment']==null?"":photo['appointment'].toString())),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black, fontSize: 23.sp, shadows: [
            const Shadow(color: Colors.white, offset: const Offset(.5, .5))
          ]),
        ),
      ),
    );
  }
}
