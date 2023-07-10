
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../Models/News_model.dart';
import '../repo/Repository.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final Repository _repository;

  ApiBloc(this._repository) : super(ApiInitial()) {
    on<ApiEvent>((event, emit) async {
      emit(ApiInitial());
      try{
        final items = await _repository.getapi();
        print(items);
        emit(ApiLoaded(items));
      }catch(e){
        emit(ApiError(e.toString()));
      }
    });
  }
}
