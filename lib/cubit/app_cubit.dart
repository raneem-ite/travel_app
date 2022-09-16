import 'package:bloc/bloc.dart';
import 'package:flutter_cubit/cubit/app_cubit_state.dart';
import 'package:flutter_cubit/model/data_model.dart';
import 'package:flutter_cubit/services/data_services.dart';

class AppCubits extends Cubit<CubitState> {
  AppCubits() : super(InitialState()) {
    emit(WelcomeState());
  }
  late DataServices data = DataServices();
  late List<DataModel> places;
  void getData() async {
    try {
      emit(LoadingState());
      places = await data.getInfo();
      places.isNotEmpty ? emit(LoadedState(places)) : emit(LoadingState());
    } catch (e) {}
  }

  void getDetails(DataModel data) {
    emit(DetailState(data));
  }

  void goHome() {
    emit(LoadedState(places));
  }
}
