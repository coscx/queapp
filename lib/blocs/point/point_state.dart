import 'package:equatable/equatable.dart';
import 'package:flutter_geen/model/github/issue.dart';


/// 说明: 

abstract class PointState extends Equatable{

}

class PointLoading extends PointState{
  @override
  List<Object> get props => [];
}

class PointLoaded extends PointState{

 final List<Issue> issues;

 PointLoaded(this.issues);

  @override
  List<Object> get props => [issues];
}


class PointLoadFailure extends PointState{

 final String error;

 PointLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}