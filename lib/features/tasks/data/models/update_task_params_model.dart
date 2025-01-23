import 'package:equatable/equatable.dart';

import 'status_model.dart';

class UpdateTaskParamsModel extends Equatable {
  final int id;
  final String? description;
  final String? title;
  final StatusModel? status;
  final DateTime? dueDate;

  const UpdateTaskParamsModel({
    required this.id,
    this.description,
    this.title,
    this.status,
    this.dueDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'title': title,
      'status': status?.toJson(),
      'dueDate': dueDate?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, description, title, status, dueDate];
}
