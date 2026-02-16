part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomePageLoadState extends HomeInitial {
  @override
  List<Object> get props => [];
}

class FetchHomeDataState extends HomeInitial {
  final List<ActivitySectionData> listActivityData;

  FetchHomeDataState({
    required this.listActivityData,
  });

  @override
  List<Object> get props => [listActivityData];
}
