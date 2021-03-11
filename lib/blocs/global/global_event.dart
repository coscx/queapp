import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class EventInitApp extends GlobalEvent {
  const EventInitApp();

  @override
  List<Object> get props => [];
}

class EventSwitchFontFamily extends GlobalEvent {
  final String family;

  const EventSwitchFontFamily(this.family);

  @override
  List<Object> get props => [family];
}

class EventSwitchThemeColor extends GlobalEvent {
  final MaterialColor color;

  const EventSwitchThemeColor(this.color);

  @override
  List<Object> get props => [color];
}

class EventSwitchCoderTheme extends GlobalEvent {
  final int codeStyleIndex;

  const EventSwitchCoderTheme(this.codeStyleIndex);

  @override
  List<Object> get props => [codeStyleIndex];
}

class EventSwitchShowBg extends GlobalEvent {
  final bool show;

  const EventSwitchShowBg(this.show);

  @override
  List<Object> get props => [show];
}

class EventSwitchShowOver extends GlobalEvent {
  final bool show;

  const EventSwitchShowOver(this.show);

  @override
  List<Object> get props => [show];
}

class EventChangeItemStyle extends GlobalEvent {
  final int index;

  const EventChangeItemStyle(this.index);

  @override
  List<Object> get props => [index];
}
class EventIndexPhotoPage extends GlobalEvent {
  final int page;

  const EventIndexPhotoPage(this.page);

  @override
  List<Object> get props => [page];
}
class EventResetIndexPhotoPage extends GlobalEvent {

}
class EventSearchPhotoPage extends GlobalEvent {
  final int page;

  const EventSearchPhotoPage(this.page);

  @override
  List<Object> get props => [page];
}
class EventResetSearchPhotoPage extends GlobalEvent {

}
class EventSetIndexNum extends GlobalEvent {

}

class EventSetIndexSex extends GlobalEvent {
  final int sex;

  const EventSetIndexSex(this.sex);

  @override
  List<Object> get props => [sex];
}
class EventSetMemberId extends GlobalEvent {
  final String memberId;

  const EventSetMemberId(this.memberId);

  @override
  List<Object> get props => [memberId];
}
class EventSetCreditId extends GlobalEvent {
  final String creditId;

  const EventSetCreditId(this.creditId);

  @override
  List<Object> get props => [creditId];
}
class EventSetBar1 extends GlobalEvent {
  final int memberId;

  const EventSetBar1(this.memberId);

  @override
  List<Object> get props => [memberId];
}
class EventSetBar2 extends GlobalEvent {
  final int memberId;

  const EventSetBar2(this.memberId);

  @override
  List<Object> get props => [memberId];
}
class EventSetBar3 extends GlobalEvent {
  final int memberId;

  const EventSetBar3(this.memberId);

  @override
  List<Object> get props => [memberId];
}
class EventSetBar4 extends GlobalEvent {
  final int memberId;

  const EventSetBar4(this.memberId);

  @override
  List<Object> get props => [memberId];
}
class EventSetIndexMode extends GlobalEvent {
  final int mode;

  const EventSetIndexMode(this.mode);

  @override
  List<Object> get props => [mode];
}
