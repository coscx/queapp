import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/storage/dao/widget_dao.dart';
import 'package:flutter_geen/repositories/itf/widget_repository.dart';

import 'collect_event.dart';
import 'collect_state.dart';



class CollectBloc extends Bloc<CollectEvent, CollectState> {
  final WidgetRepository repository;

  CollectBloc({@required this.repository});

  @override
  CollectState get initialState => CollectState(widgets: []); //初始状态

  @override
  Stream<CollectState> mapEventToState(
    CollectEvent event,
  ) async* {
    if (event is ToggleCollectEvent) {
      await repository.toggleCollect(event.id);
      final widgets = await repository.loadCollectWidgets();
      yield CollectState(widgets: widgets);
    }
    if( event is EventSetCollectData){
      final widgets = await repository.loadCollectWidgets();
      yield CollectState(widgets: widgets);
    }
  }
}
