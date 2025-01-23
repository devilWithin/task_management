import 'package:equatable/equatable.dart';
import 'package:task_management_test/features/tasks/domain/entities/status.dart';

class StatusModel extends Equatable {
  final int id;
  final String name;

  const StatusModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

extension StatusModelX on StatusModel {
  Status toDomain() => Status(id: id, name: name);
}
