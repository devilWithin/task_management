import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
  });

  factory ServerFailure.localized({
    required String messageAr,
    required String messageEn,
  }) {
    return Intl.getCurrentLocale() == 'ar'
        ? ServerFailure(message: messageAr)
        : ServerFailure(message: messageEn);
  }
}
