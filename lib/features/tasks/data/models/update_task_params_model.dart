import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UpdateTaskParamsModel extends Equatable {
  final String id;
  final String? description;
  final String? title;
  final DateTime? dueDate;

  const UpdateTaskParamsModel({
    required this.id,
    this.description,
    this.title,
    this.dueDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (description != null) data['description'] = description;
    if (title != null) data['title'] = title;
    if (dueDate != null) data['due_date'] = Timestamp.fromDate(dueDate!);
    return data;
  }

  @override
  List<Object?> get props => [id, description, title, dueDate];
}
