import 'package:flutter/material.dart';
import 'package:notemakngapp/helper/notemodel.dart';
import 'package:notemakngapp/screen/homePage.dart';

import '../helper/database.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  bool done = false;
  String? isdone;
  var db = DatabaseHelper();
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController subtitecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note '),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titlecontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                    ),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: subtitecontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'subtitle',
                    ),
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
            Divider(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => Colors.amber)),
                onPressed: () async {
                  print('$done');
                  var result = await db.insert(NoteModel(
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
                child: Text('Add note'))
          ],
        ),
      )),
    );
  }
}
