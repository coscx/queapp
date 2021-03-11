
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/blocs/point/point_state.dart';


import 'point_comment_event.dart';
import 'point_comment_state.dart';



/// 说明:

class PointCommentBloc extends Bloc<PointCommentEvent, PointCommentState> {

  @override
  PointCommentState get initialState => PointCommentInitial();

  @override
  Stream<PointCommentState> mapEventToState(PointCommentEvent event) async* {
    if (event is EventLoadPointComment) {
      yield* _mapLoadWidgetToState(event);
    }
  }

  Stream<PointCommentState> _mapLoadWidgetToState(EventLoadPointComment event) async* {
    yield PointCommentLoading(event.point);
    try {
      final comments = await IssuesApi.getIssuesComment(event.point.number);
      comments.sort((a,b)=>a.createdAt.compareTo(b.createdAt));
      yield PointCommentLoaded(event.point,comments);
    } catch (err) {
      print(err);
      yield PointCommentLoadFailure(err);
    }
  }
}
