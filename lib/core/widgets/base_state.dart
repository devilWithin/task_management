import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum BaseStatus {
  initial,
  inProgress,
  success,
  failure,
}

class BaseState<T> extends Equatable {
  final BaseStatus status;
  final T? item;
  final FirebaseException? failure;

  BaseState<T> setInitialState() => BaseState<T>(
        status: BaseStatus.initial,
      );

  BaseState<T> setInProgressState() => BaseState<T>(
        status: BaseStatus.inProgress,
      );

  BaseState<T> setSuccessState(T item) =>
      BaseState<T>(status: BaseStatus.success, item: item);

  BaseState<T> setFailureState(FirebaseException failure) =>
      BaseState<T>(status: BaseStatus.failure, failure: failure);

  bool get isInProgress => status == BaseStatus.inProgress;

  bool get isFailure => status == BaseStatus.failure;

  bool get isSuccess => status == BaseStatus.success;

  const BaseState({
    this.status = BaseStatus.initial,
    this.item,
    this.failure,
  });

  BaseState<T> copyWith({
    BaseStatus? status,
    T? item,
    FirebaseException? failure,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      item: item ?? this.item,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [item, status, failure];
}
