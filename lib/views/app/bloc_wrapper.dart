import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/enums.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/storage/app_storage.dart';
import 'package:flutter_geen/views/pages/chat/bloc/chat/chat_bloc.dart';
import 'package:flutter_geen/views/pages/chat/bloc/chat_bloc_exp.dart';
import 'package:flutter_geen/views/pages/discovery/bloc/discovery_bloc_exp.dart';
import 'package:flutter_geen/views/pages/login/bloc/login/login_bloc.dart';
import 'package:flutter_geen/views/pages/user/bloc/user/user_bloc.dart';

/// 说明: Bloc提供器包裹层

final storage = AppStorage();

class BlocWrapper extends StatefulWidget {
  final Widget child;

  BlocWrapper({this.child});

  @override
  _BlocWrapperState createState() => _BlocWrapperState();
}

class _BlocWrapperState extends State<BlocWrapper> {
  //final repository = WidgetDbRepository(storage);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(//使用MultiBlocProvider包裹
        providers: [
        //Bloc提供器
        BlocProvider<GlobalBloc>(
            create: (_) => GlobalBloc(storage)..add(EventInitApp())),

            BlocProvider<ChatBloc>(create: (_) => ChatBloc()),

            BlocProvider<PeerBloc>(create: (_) => PeerBloc()),

            BlocProvider<GroupBloc>(create: (_) => GroupBloc()),

            BlocProvider<DiscoveryBloc>(create: (_) => DiscoveryBloc()),

            BlocProvider<LoginBloc>(create: (_) => LoginBloc()),

            BlocProvider<UserBloc>(create: (_) => UserBloc()),

          ], child: widget.child);
  }

  @override
  void dispose() {

    super.dispose();
  }
}
