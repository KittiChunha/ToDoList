// ignore_for_file: file_names
import 'package:hive/hive.dart';
import 'package:todo_list/main.dart';

part 'taskModel.g.dart';

@HiveType(typeId: 0)
class taskModel extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? note;

  @HiveField(2)
  DateTime? creationDate;

  @HiveField(3)
  bool? done;

  taskModel({this.title, this.note, this.creationDate, this.done});
}
