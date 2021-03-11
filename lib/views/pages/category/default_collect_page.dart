import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/app/router.dart';
import 'package:flutter_geen/blocs/bloc_exp.dart';
import 'package:flutter_geen/model/widget_model.dart';
import 'package:flutter_geen/views/items/collect_widget_list_item.dart';

/// 说明: 

class DefaultCollectPage extends StatelessWidget {

  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1 / 0.5,
  );

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CollectBloc, CollectState>(
        builder: (ctx, state) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              ),
              _buildContent(context, state)],
          );
        });
  }

  Widget _buildContent(BuildContext context, CollectState state) {
    return SliverPadding(
      padding: EdgeInsets.only(top:10, left: 10, right: 10, bottom: 40),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
                  (_, index) => Container(
                child: GestureDetector(
                    onTap: () =>
                        _toDetailPage(context, state.widgets[index]),
                    child: CollectWidgetListItem(
                      data: state.widgets[index],
                      onDeleteItemClick: (model) =>
                          _deleteCollect(context, model),
                    )),
              ),
              childCount: state.widgets.length),
          gridDelegate: gridDelegate),
    );
  }

  _deleteCollect(BuildContext context, WidgetModel model) =>
      BlocProvider.of<CollectBloc>(context)
          .add(ToggleCollectEvent(id: model.id));

  _toDetailPage(BuildContext context, WidgetModel model) {
    Map<String,dynamic> photo;
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(photo));
    Navigator.pushNamed(context, UnitRouter.widget_detail, arguments: model);
  }

}
