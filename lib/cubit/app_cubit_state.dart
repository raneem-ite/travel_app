import 'package:equatable/equatable.dart';
import 'package:flutter_cubit/model/data_model.dart';

abstract class CubitState extends Equatable {}

class InitialState extends CubitState {
  @override
  List<Object?> get props => [];
}

class WelcomeState extends CubitState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends CubitState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends CubitState {
  LoadedState(this.placesState);
  final List<DataModel> placesState;
  @override
  List<Object?> get props => [placesState];
}

class DetailState extends CubitState {
  DetailState(this.place);
  final DataModel place;
  @override
  List<Object?> get props => [place];
}
