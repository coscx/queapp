import 'package:equatable/equatable.dart';
import 'package:flutter_geen/model/github/issue_comment.dart';
import 'package:flutter_geen/model/github/issue.dart';

/// 说明: 

abstract class PointCommentState extends Equatable{

}

class PointCommentInitial extends PointCommentState{


  @override
  List<Object> get props => [];
}

class PointCommentLoading extends PointCommentState{
  final Issue issue;

  PointCommentLoading(this.issue);

  @override
  List<Object> get props => [issue];
}

class PointCommentLoaded extends PointCommentState{

 final Issue issue;
 final List<IssueComment> comments;

 PointCommentLoaded(this.issue,this.comments);

  @override
  List<Object> get props => [issue,comments];

 @override
  String toString() {
    return 'PointCommentLoaded{issue: $issue, comments: $comments}';
 }
}


class PointCommentLoadFailure extends PointCommentState{

 final String error;

 PointCommentLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}