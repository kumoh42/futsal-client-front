abstract class NoneState {}

abstract class LoadingState {}

abstract class SuccessState<T> {
  T data;
  String? message;

  SuccessState(this.data, {this.message});
}

abstract class ErrorState {
  String message;

  ErrorState(this.message);
}
