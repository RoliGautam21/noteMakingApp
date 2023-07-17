import 'package:flutter/material.dart';
import 'package:notemakngapp/helper/notemodel.dart';
import 'package:notemakngapp/screen/homePage.dart';

import '../helper/database.dart';

class UpdateNoteScreen extends StatefulWidget {
  final int id;
  final String? subtitle;
  final String title;
  final bool done;
  const UpdateNoteScreen(
      {super.key,
      required this.id,
      this.subtitle,
      required this.title,
      required this.done});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  bool done = false;
  String? isdone;
  var db = DatabaseHelper();
  int? id;
  TextEditingController titlecontroller = TextEditingController();

  final subtitecontroller = TextEditingController();
  void settingata() {
    setState(() {
      id = widget.id;
      titlecontroller.text = widget.title;
      subtitecontroller.text = widget.subtitle ?? '';
      done = widget.done;
    });
  }

  @override
  void initState() {
    settingata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Note '),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    hintText: 'Title',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: subtitecontroller,
                  decoration: InputDecoration(
                    hintText: 'subtitle',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Done : '),
                  Switch(
                      value: done,
                      onChanged: (value) {
                        setState(() {
                          done = value;
                          isdone = value == true ? '1' : '0';
                        });
                        print('$isdone');
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  print('$done');
                  var result = await db.updateNote(NoteModel(
                      id: id,
                      title: titlecontroller.text,
                      done: done,
                      subtitle: subtitecontroller.text));
                  if (result) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Note saved successfull!'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));
                                },
                                child: Text('done'))
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(' Save'))
          ],
        ),
      )),
    );
  }
}
