part of 'api_bloc.dart';

abstract class ApiState extends Equatable {
  const ApiState();
}

class ApiInitial extends ApiState {
  @override
  List<Object> get props => [];
}

class ApiLoaded extends ApiState {
  @override
  final List<Welcome> welcome;
  ApiLoaded(this.welcome);
  @override
  List<Object?> get props => [welcome];
}

class ApiError extends ApiState {
  final String error;
  ApiError(this.error);
  @override
  List<Object> get props => [error];
}