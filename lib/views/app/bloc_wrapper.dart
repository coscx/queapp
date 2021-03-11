import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/blocs/chat/chat_bloc.dart';
import 'package:flutter_geen/repositories/impl/catagory_db_repository.dart';
import 'package:flutter_geen/repositories/impl/widget_db_repository.dart';
import 'package:flutter_geen/storage/app_storage.dart';

/// 说明: Bloc提供器包裹层

final storage = AppStorage();

class BlocWrapper extends StatefulWidget {
  final Widget child;

  BlocWrapper({this.child});

  @override
  _BlocWrapperState createState() => _BlocWrapperState();
}

class _BlocWrapperState extends State<BlocWrapper> {
  final repository = WidgetDbRepository(storage);

  final categoryBloc = CategoryBloc(repository: CategoryDbRepository(storage));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(//使用MultiBlocProvider包裹
        providers: [
      //Bloc提供器
      BlocProvider<GlobalBloc>(
          create: (_) => GlobalBloc(storage)..add(EventInitApp())),

      BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(repository: repository)
            ..add(EventTabTap())),

      BlocProvider<DetailBloc>(
          create: (_) => DetailBloc(repository: repository)),

      BlocProvider<CategoryBloc>(
          create: (_) => categoryBloc..add(EventLoadCategory())),

      BlocProvider<CollectBloc>(
          create: (_) =>
              CollectBloc(repository: repository)..add(EventSetCollectData())),

      BlocProvider<CategoryWidgetBloc>(
          create: (_) => CategoryWidgetBloc(categoryBloc: categoryBloc)),

      BlocProvider<SearchBloc>(
          create: (_) => SearchBloc(repository: repository)),
      BlocProvider<PointBloc>(create: (_) => PointBloc()),
          BlocProvider<DataBloc>(create: (_) => DataBloc()),
          BlocProvider<BigDataBloc>(create: (_) => BigDataBloc()),
      BlocProvider<PointCommentBloc>(create: (_) => PointCommentBloc()),

          BlocProvider<LoginBloc>(create: (_) => LoginBloc()),

          BlocProvider<ChatBloc>(create: (_) => ChatBloc()),

          BlocProvider<PeerBloc>(create: (_) => PeerBloc()),
          BlocProvider<UserBloc>(create: (_) => UserBloc()),
          BlocProvider<GroupBloc>(create: (_) => GroupBloc()),
          BlocProvider<TimeBloc>(create: (_) => TimeBloc()),

        ], child: widget.child);
  }

  @override
  void dispose() {
    categoryBloc.close();
    super.dispose();
  }
}
