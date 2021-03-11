import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/views/items/popular_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_geen/app/res/cons.dart';
import 'package:flutter_geen/app/res/style/shape/coupon_shape_border.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/blocs/collect/collect_bloc.dart';
import 'package:flutter_geen/blocs/collect/collect_state.dart';
import 'package:flutter_geen/blocs/detail/detail_bloc.dart';
import 'package:flutter_geen/blocs/detail/detail_event.dart';
import 'package:flutter_geen/blocs/search/search_bloc.dart';
import 'package:flutter_geen/blocs/search/search_event.dart';
import 'package:flutter_geen/components/permanent/circle_text.dart';
import 'package:flutter_geen/components/permanent/feedback_widget.dart';
import 'package:flutter_geen/components/permanent/tag.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/views/dialogs/delete_category_dialog.dart';
import 'package:flutter_geen/views/pages/home/PreviewImagesWidget.dart';
class PhotoSearchAppointWidgetListItem extends StatelessWidget {
  final bool hasTopHole;
  final bool hasBottomHole;
  final bool isClip;
  final Map<String, dynamic> photo;

  PhotoSearchAppointWidgetListItem({
    this.hasTopHole = true,
    this.hasBottomHole = false,
    this.isClip = true,
    this.photo,
  });

  final List<int> colors = Cons.tabColors;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
        child: Stack(
            children: <Widget>[
              isClip
                  ? ClipPath(
                clipper: ShapeBorderClipper(
                    shape: CouponShapeBorder(
                        hasTopHole: hasTopHole,
                        hasBottomHole: hasBottomHole,
                        hasLine: false,
                        edgeRadius: 25.w,
                        lineRate: 0.20)),
                child: buildContent(context),
              )
                  : Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context,photo['uuid']+"#"+photo['name']);
                      //BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(photo));
                      //Navigator.pushNamed(context, UnitRouter.widget_detail);
                    },
                    child: buildContent(context),
                  ),

                  //buildMiddle(context),
                  //_buildCollectTag(Theme.of(context).primaryColor)
                ],
              ),
            ]
        )
    );
  }

  Widget buildCard(BuildContext context, Map<String, dynamic> img) {
    return Stack(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[

                Column(
                  children: <Widget>[
                    GestureDetector(

                        onLongPress: () =>
                            _onLongPress(context, img['imagepath']),
                        child: Container(
                          child: CachedNetworkImage(imageUrl: img['imagepath'],
                            width: 100.w,
                            height: 180.h,
                          ),
                        )
                    )
                  ],
                ),

              ],

            ),
            padding:  EdgeInsets.all(2.w),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
          ),

          Positioned(
              top: 5.h,
              right: 5.w,
              child:
              FeedbackWidget(
                onPressed: () {
                  _deletePhoto(context, img);
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

  _onLongPress(BuildContext context, String img) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (c, a, s) => PreviewImagesWidget([img], initialPage: 1,)));
  }

  Widget buildMiddle(BuildContext context,) {
    List<dynamic> imgList = photo['imageurl'];
    List<Widget> list = [];
    imgList.map((images) =>
    {

      list.add(buildCard(context, images))
    }


    ).toList();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Expanded(child:
          Wrap(
            spacing: 5.w, //主轴上子控件的间距
            runSpacing: 0, //交叉轴上子控件之间的间距
            children: [
              ...list
            ],

          )
          ),

          buildWhereButton(context, photo['checked'])

        ]
    );
  }

  Widget buildWhereButton(BuildContext context, int checked) {
    if (checked == 1) {
      return Column(
        children: [

          buildRefuseButton(context, "拒绝", Colors.red),
          build100Button(context, "通过1", Colors.green),
          build80Button(context, "通过2", Colors.blue),
          build60Button(context, "通过3", Colors.purple),
          buildHideButton(context, "隐藏", Colors.deepPurple),

        ],
      );
    } else {
      return Column(
        children: [

          buildResetButton(context, "撤回", Colors.red),


        ],
      );
    }
  }

  _resetUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) =>
            Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w))),
              child: Container(
                width: 50.w,
                child: DeleteCategoryDialog(
                  title: '撤回此用户的审核结果',
                  content: '是否确定继续执行?',
                  onSubmit: () {
                    BlocProvider.of<SearchBloc>(context).add(
                        EventResetCheckUsers(photo, 1));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ));
  }

  _deletePhoto(BuildContext context, Map<String, dynamic> img) {
    showDialog(
        context: context,
        builder: (ctx) =>
            Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w))),
              child: Container(
                width: 50.w,
                child: DeleteCategoryDialog(
                  title: '删除图片',
                  content: '是否确定继续执行?',
                  onSubmit: () {
                    BlocProvider.of<SearchBloc>(context).add(
                        EventDelImgs(img, 1));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ));
  }

  _refuseUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) =>
            Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w))),
              child: Container(
                width: 50.w,
                child: DeleteCategoryDialog(
                  title: '拒绝此用户',
                  content: '是否确定继续执行?',
                  onSubmit: () {
                    BlocProvider.of<SearchBloc>(context).add(
                        EventCheckUsers(photo, 1));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ));
  }

  _hideUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) =>
            Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w))),
              child: Container(
                width: 50.w,
                child: DeleteCategoryDialog(
                  title: '隐藏该用户',
                  content: '是否确定继续执行?',
                  onSubmit: () {
                    BlocProvider.of<SearchBloc>(context).add(
                        EventCheckUsers(photo, 5));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ));
  }

  Widget buildButton(BuildContext context, String txt, MaterialColor color) {
    return Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          color: color,
          onPressed: () {

          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        ),
      ],
    );
  }

  Widget build100Button(BuildContext context, String txt, MaterialColor color) {
    return Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          color: color,
          onPressed: () {
            BlocProvider.of<SearchBloc>(context).add(EventCheckUsers(photo, 2));
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        ),
      ],
    );
  }

  Widget build80Button(BuildContext context, String txt, MaterialColor color) {
    return Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          color: color,
          onPressed: () {
            BlocProvider.of<SearchBloc>(context).add(EventCheckUsers(photo, 3));
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        ),
      ],
    );
  }

  Widget build60Button(BuildContext context, String txt, MaterialColor color) {
    return Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          color: color,
          onPressed: () {
            BlocProvider.of<SearchBloc>(context).add(EventCheckUsers(photo, 4));
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        ),
      ],
    );
  }

  Widget buildResetButton(BuildContext context, String txt,
      MaterialColor color) {
    return Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          color: color,
          onPressed: () {
            _resetUser(context);
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        ),
      ],
    );
  }

  Widget buildRefuseButton(BuildContext context, String txt,
      MaterialColor color) {
    return Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          color: color,
          onPressed: () {
            _refuseUser(context);
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        ),
      ],
    );
  }

  Widget buildHideButton(BuildContext context, String txt,
      MaterialColor color) {
    return Column(
      children: [

        RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          color: color,
          onPressed: () {
            _hideUser(context);
          },
          child: Text(txt,
              style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        ),
      ],
    );
  }

  Widget buildContent(BuildContext context) {

      return PopularCard(photo: photo,);
     return Container(
        color: Colors.white10.withAlpha(66),
        height: 95,
        padding: const EdgeInsets.only(top: 10, left: 0, right: 10, bottom: 5),
        child: Row(
          children: <Widget>[
            buildLeading(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTitle(),

                  _buildSummary(),

                ],
              ),
            ),
          ],
        ),
      );
}
  Widget buildLeading() => Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          //tag: "hero_widget_image_${photo['memberId'].toString()}",
          child: photo['img'] == null
              ? Material(
                  color: Colors.transparent,
                  child: CircleText(
                    text: photo['userName'],
                    size: 60.w,
                    fontSize: 30.sp,
                    color: invColor,
                  ),
                )
              : Container(
            child: CachedNetworkImage(imageUrl: photo['img'],
              width: 55.w,
              height: 100.h,
            ),
          )
          ,
        ),
      );

  Color get invColor {
    return Colors.black12;
  }

  Widget _buildCollectTag(Color color) {
    return Positioned(
        top: 0,
        right: 40.w,
        child: BlocBuilder<CollectBloc, CollectState>(builder: (_, s) {
          bool show = true;
          return Opacity(
            opacity: show ? 1.0 : 0.0,
            child: SizedOverflowBox(
              alignment: Alignment.bottomCenter,
              size: const Size(0, 20 - 6.0),
              child: Tag(
                color: color,
                shadowHeight: 6.0,
                size: const Size(15, 20),
              ),
            ),
          );
        }));
  }

  Widget _buildTitle() {
    return Expanded(
      child: Row(
        children: <Widget>[
           SizedBox(width: 1.w),
          Expanded(
            child: Text(photo['userName']+" "+photo['tel']+" "+(photo['sex']==1?"男":"女")+" "+photo['age'].toString()+"岁 "+(photo['device']==1?"安卓 ":"苹果 "),
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                    fontSize: 28.sp,
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

  Widget _buildSummary() {
    return Padding(
      padding:  EdgeInsets.only(left: 1.w, bottom: 1.h, top: 1.h),
      child: Container(
        child: Text(
          //尾部摘要
          "型号: "+photo['machine']+"版本: "+photo['version']+" "+photo['addressed'] +" "+(photo['isAi']==1?"已认证":"未认证") +" 会员:" +photo['endtime'],
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey[600], fontSize: 14.sp, shadows: [
            const Shadow(color: Colors.white, offset: const Offset(.5, .5))
          ]),
        ),
      ),
    );
  }
}
