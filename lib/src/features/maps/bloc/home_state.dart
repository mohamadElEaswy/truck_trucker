part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}


class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState{}



class MapLoading extends HomeState{}
class MapError extends HomeState{}
class MapSuccess extends HomeState{
  final List<LocationModel> data;
  MapSuccess({required this.data});
}