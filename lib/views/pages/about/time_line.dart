import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/blocs/home/home_state.dart';
import 'package:flutter_geen/blocs/timeline/time_bloc.dart';
import 'package:flutter_geen/blocs/timeline/time_state.dart';
import 'package:flutter_geen/components/permanent/feedback_widget.dart';
import 'package:flutter_geen/model/time_line_model_entity.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/blocs/detail/detail_bloc.dart';
import 'package:flutter_geen/blocs/detail/detail_event.dart';
class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final PageController pageController =
  PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;
  TimeLineModelEntity timeline;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      timelineModel(TimelinePosition.Left),
      timelineModel(TimelinePosition.Center),
      timelineModel(TimelinePosition.Right)
    ];

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageIx,
            onTap: (i) => pageController.animateToPage(i,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_left),
                title: Text("左"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_center),
                title: Text("中"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_right),
                title: Text("右"),
              ),
            ]),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PageView(
          onPageChanged: (i) => setState(() => pageIx = i),
          controller: pageController,
          children: pages,
        ));
  }

  timelineModel(TimelinePosition position) {

   return BlocBuilder<TimeBloc, TimeState>(builder: (ctx, state) {

     if (state is GetTimeLineSuccess){

       timeline=state.timeLine;

       return   Timeline.builder(
           itemBuilder: centerTimelineBuilder,
           itemCount: state.timeLine.data.timeLine.length,
           physics: position == TimelinePosition.Left
               ? ClampingScrollPhysics()
               : BouncingScrollPhysics(),
           position: position);
     }

     return Container();

    });

  }


  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = timeline.data.timeLine[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        Card(
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(doodle.iconBackground),
                const SizedBox(
                  height: 8.0,
                ),
                Text(doodle.time, style: textTheme.caption),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  doodle.content,
                  style: textTheme.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                FeedbackWidget(

                  onPressed: () {
                    //BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(null,null));
                    //Navigator.pushNamed(context, UnitRouter.widget_detail, arguments: doodle);
                  } ,
                  child: doodle.user !=null?Row(
                    children:<Widget> [

                      ClipOval(
                        child: Image(
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          image: FadeInImage.assetNetwork(
                            placeholder:'assets/images/ic_launcher.png',
                            image:doodle.user.img,
                          ).image,
                        ),
                      ),
                      Text(
                        doodle.user.userName,
                        style: textTheme.title,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ):Container(),
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        position:
        i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == timeline.data.timeLine.length,
        iconBackground: Colors.blue,
        icon: Icon(
          Icons.category,
          color: Colors.white,
        ));
  }
}