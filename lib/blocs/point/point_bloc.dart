
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/api/issues_api.dart';
import 'package:flutter_geen/blocs/point/point_state.dart';


import 'point_event.dart';


/// 说明:

class PointBloc extends Bloc<PointEvent, PointState> {

  @override
  PointState get initialState => PointLoading();

  @override
  Stream<PointState> mapEventToState(PointEvent event) async* {
    if (event is EventLoadPoint) {
      yield* _mapLoadWidgetToState();
    }
  }

  Stream<PointState> _mapLoadWidgetToState() async* {
    yield PointLoading();
    try {
      final issues = await IssuesApi.getIssues();
      yield PointLoaded(issues);
    } catch (err) {
      print(err);
      yield PointLoadFailure(err);
    }
  }
}
