import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geen/views/pages/data/card.dart';


typedef OnPressCallback = void Function(Widget selectedItem);

Widget _buildImage(double width, double height, String url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Image.network(
      url,
      fit: BoxFit.fitHeight,
      width: width,
      height: height,
    ),
  );
}

class RecommendedCard extends StatelessWidget {
  RecommendedCard(
      {@required this.child, @required this.title, @required this.onDelete});

  final Widget child;
  final String title;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: InkWell(
        onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => IndexPage())),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          elevation: 0.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //粗体标题
                    Text(
                      title,

                    ),
                    //卡片删除图标
                    Container(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.highlight_off,
                          size: 20.0,
                        ),
                        onPressed: onDelete,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScenicCard extends StatelessWidget {
  ScenicCard(
      {@required this.price,
      @required this.title,
      @required this.imageUrls,
      @required this.score,
      @required this.address,
      this.onDelete,
      this.tags = const <Widget>[]});

  final Widget price;
  final List<Widget> tags;
  final String title;
  final List<String> imageUrls;
  final String score;
  final String address;
  final OnPressCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final imageWidth = (MediaQuery.of(context).size.width - 60.0) / 3.0;
    final imageHeight = imageWidth - 20.0;
    final tagList = <Widget>[
      price,
    ];

    if (tags.length > 0) {
      tags.forEach((tag) {
        tagList.add(SizedBox(
          width: 5.0,
        ));
        tagList.add(tag);
      });
    }

    return RecommendedCard(
      title: title,
      onDelete: () => onDelete(this),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                score,

              ),
              Text(
                address,

              )
            ],
          ),
          SizedBox(
            height: 7.0,
          ),
          Row(
            children: tagList,
          ),
          SizedBox(
            height: 7.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildImage(imageWidth, imageHeight, imageUrls[0]),
              _buildImage(imageWidth, imageHeight, imageUrls[1]),
              _buildImage(imageWidth, imageHeight, imageUrls[2]),
            ],
          ),
        ],
      ),
    );
  }
}

class BigPictureCateCard extends StatelessWidget {
  BigPictureCateCard(
      {@required this.price,
      @required this.title,
      @required this.imageUrls,
      @required this.content,
      @required this.address,
      this.onDelete,
      this.tags = const <Widget>[]});

  final Widget price;
  final List<Widget> tags;
  final String title;
  final List<String> imageUrls;
  final String content;
  final String address;
  final OnPressCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final imageWidth = (MediaQuery.of(context).size.width - 60.0) / 3.0;
    final imageHeight = imageWidth - 20.0;
    final tagList = <Widget>[
      price,
    ];

    if (tags.length > 0) {
      tags.forEach((tag) {
        tagList.add(SizedBox(
          width: 5.0,
        ));
        tagList.add(tag);
      });
    }

    return RecommendedCard(
      title: title,
      onDelete: () => onDelete(this),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///套餐包含与地址
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  content,

                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                address,

              ),
            ],
          ),
          SizedBox(
            height: 7.0,
          ),

          ///价格与标签
          Row(
            children: tagList,
          ),
          SizedBox(
            height: 7.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildImage(imageWidth * 2, imageHeight * 2, imageUrls[0]),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildImage(imageWidth, imageHeight, imageUrls[1]),
                  _buildImage(imageWidth, imageHeight, imageUrls[2]),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
