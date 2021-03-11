import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geen/big_datas_entity.dart';
import 'package:flutter_geen/blocs/data/data_bloc.dart';
import 'package:flutter_geen/blocs/data/data_state.dart';

class ItemModel {
  String title;
  Color bgColor;
  String routeName;
  ItemModel({this.title, this.bgColor, this.routeName});
}

var list = [
  ItemModel(
    title: '开眼',
    bgColor: Color(0xff164396),
    routeName: '/ranklist',
  ),
  ItemModel(
    title: 'OnBoarding',
    bgColor: Colors.pinkAccent,
    routeName: '/onboarding',
  ),
  ItemModel(
    title: 'ListView',
    bgColor: Colors.blueAccent,
    routeName: '/furniture_list',
  ),
  ItemModel(
    title: 'Carousel-01',
    bgColor: Color(0xffed5c48),
    routeName: '/furniture_detail',
  ),
  ItemModel(
    title: 'Carousel-02',
    bgColor: Color(0xff53b28f),
    routeName: '/city',
  ),
  ItemModel(
    title: 'Carousel-03',
    bgColor: Color(0xff7254b2),
    routeName: '/cardlist',
  ),
  ItemModel(
    title: '...',
    bgColor: Color(0xff59bfee),
    routeName: '/',
  ),
  ItemModel(
    title: '...',
    bgColor: Color(0xffb0a4e3),
    routeName: '/',
  ),
  ItemModel(
    title: '...',
    bgColor: Color(0xff80edae),
    routeName: '/',
  ),
  ItemModel(
    title: '...',
    bgColor: Color(0xffff0097),
    routeName: '/',
  ),
  ItemModel(
    title: '...',
    bgColor: Color(0xff80edae),
    routeName: '/',
  ),
  ItemModel(
    title: '...',
    bgColor: Color(0xffff0097),
    routeName: '/',
  ),
];
class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff232540),
      appBar: AppBar(
        title: Text('数据总览'),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body:BlocBuilder<DataBloc, DataState>(builder: _buildContent),



    );
  }
}



Widget _buildContent(BuildContext context, DataState state) {
  if (state is GetDataSuccess) {
    return Container(
      color: Colors.white,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        children: getList(context,state.big),
      ),
    ) ;

  }

  return
    Container(
      color: Colors.white,
    );
}
List<Widget> getList(context,BigDatasEntity big) {
  List<Widget> _list = [];
  var list = big.data;
  for (int i = 0; i < list.length; i++) {
    _list.add(getItem(context, list[i]));
  }
  return _list;
}

Widget getItem(context, BigDatasData item) {
  return InkWell(
    onTap: (){
      //Navigator.pushNamed(context, item.);
    },
    child: Container(
      // color: Color(item.color),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(width: (2), color: Color(item.color)),
            color: Color(item.color),
            ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
                  item.num.toString(),
                  style: TextStyle(fontSize: 38.0, fontWeight:FontWeight.bold,color: Colors.white),
                )),
            Center(
                child: _getText(item)),

          ],

        )),
  );
}

Widget _getText( BigDatasData item) {
   if (item.single==1){
     return Text(
       item.name+":男"+item.boy.toString()+"女:"+item.girl.toString(),
       style: TextStyle(fontSize: 12.0, color: Colors.white),
     );
   }
   if (item.single==2){
     return Text(
       item.name+":"+item.boy.toString(),
       style: TextStyle(fontSize: 12.0, color: Colors.white),
     );
   }
   return Text(
     item.name,
     style: TextStyle(fontSize: 12.0, color: Colors.white),
   );
}
