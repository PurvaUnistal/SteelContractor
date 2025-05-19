part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomePageLoadEvent extends HomeEvent {
  final BuildContext context;

  const HomePageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class HomePageRefreshEvent extends HomeEvent {
  final BuildContext context;

  const HomePageRefreshEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

