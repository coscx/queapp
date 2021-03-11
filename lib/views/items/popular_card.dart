import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularCard extends StatelessWidget {

  final Map<String, dynamic> photo;
  const PopularCard({
    Key key,
    this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //onTap: (){},
      child: Container(
        width: ScreenUtil().screenWidth*0.98,
        //height: 150.h,
        margin: EdgeInsets.only(top: 10.h,bottom: 10.h,left: 10.w,right: 10.w),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.18),
              blurRadius: 8.w,
              offset: Offset(0, 1),
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            ImageCard(
              imageSource: photo['head_img'],
            ),

            ContentCard(
              title: photo['name'],
              location: photo['gender']==1?"男":"女",
              description: photo['np_province_name'] +photo['np_city_name'],
              age: photo['age'].toString(),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Content List
class ContentCard extends StatelessWidget {
  const ContentCard({
    Key key,
    @required this.title,
    @required this.location,
    @required this.description,
    @required this.age,
  }) : super(key: key);

  final String title, location, description,age;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.2,
      height: 150.h,
      margin: EdgeInsets.only(left: 120.w, top: 10.h),
      padding: EdgeInsets.all(5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Row(
            children: <Widget>[
              Text(
                this.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp,
                ),
              ),

              SizedBox(width: 5.w),
              Text(
                this.location,
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                this.age+"岁",
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 28.sp,
                color: Colors.green,
              ),
              Text(
                this.description,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 30.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget Image List
class ImageCard extends StatelessWidget {
  final String imageSource;
  const ImageCard({
    Key key,
    @required this.imageSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 160.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.w),
          bottomLeft: Radius.circular(15.w),
        ),
      ),
      child: this.imageSource!=""?CachedNetworkImage(imageUrl: this.imageSource,
        fit: BoxFit.cover,
      ):Image.asset("assets/packages/images/ic_user_none_round.png"),
    );
  }
}