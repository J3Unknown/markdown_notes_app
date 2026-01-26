import 'package:hive/hive.dart';

part 'note_data_model.g.dart';

@HiveType(typeId: 0)
class NoteDataModel{

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(6)
  bool starred;

  @HiveField(2)
  String content;

  @HiveField(3)
  String createdAt;

  @HiveField(4)
  String updatedAt;

  @HiveField(5)
  String colorHex;

  NoteDataModel({required this.id, this.starred = false, required this.title, required this.content, required this.createdAt, required this.updatedAt, required this.colorHex});
}