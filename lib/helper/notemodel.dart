import 'package:flutter/foundation.dart';
import 'package:notemakngapp/helper/database.dart';

class NoteModel {
   final int? id;
  final String title;
  final String subtitle;
  final bool done;
  NoteModel(
      {
        this.id,
      required this.title,
      required this.done,
      required this.subtitle});

  Map<String, dynamic?> toMap() {
    var map = <String, dynamic?>{
       'id':id,

      'title': title,
      'subtitle': subtitle,
      'done': done == true ? 1 : 0
    };
    print('roli    ${map['done']}');

    return map;
  }

  factory NoteModel.fromMap(Map<String, dynamic> json) {
    print('@@@     ${json['done']}');
    return NoteModel(
      id:json['id'],
        title: json['title'],
        done: json['done'].toString() == '1' ? true : false,
        subtitle: json['subtitle']);
  }
}
