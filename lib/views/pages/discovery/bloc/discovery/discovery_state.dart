

import 'package:equatable/equatable.dart';

abstract class DiscoveryState extends Equatable {
  const DiscoveryState();
}

class DiscoveryInitial extends DiscoveryState {
  @override
  List<Object> get props => [];
}
class DisMessageSuccess extends DiscoveryState {

  const DisMessageSuccess(this.message);
  final Map<dynamic,dynamic> message;

  @override
  List<Object> get props => [message];
}