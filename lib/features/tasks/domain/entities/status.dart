import 'package:equatable/equatable.dart';
import 'package:task_management_test/features/tasks/data/models/status_model.dart';

class Status extends Equatable {
  final int id;
  final String name;

  const Status({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

extension StatusX on Status {
  StatusModel toData() => StatusModel(id: id, name: name);
}
