import 'package:flutter/material.dart';
import 'package:notemakngapp/helper/database.dart';
import 'package:notemakngapp/helper/notemodel.dart';
import 'package:notemakngapp/screen/updateNote.dart';

import '../constant/colors.dart';
import 'addNoteScreen.dart';

class HomePage extends StatefulWidget {
  final routname = '/HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedGridState> _gridkey = GlobalKey<AnimatedGridState>();
  Animation<double>? animation;
  List<NoteModel> notelist = [];
  var db = DatabaseHelper();
  bool isloading = false;
  bool removing = false;
  void getdata() async {
    setState(() {
      isloading = true;
    });
    var data = await db.getnotes();
    setState(() {
      notelist = data;
    });
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    db.open();
    getdata();

    super.initState();
  }

  void delete(int id) async {
    var result = await db.deleteNote(id);
    db.open();
    if (result) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Note deleted successfull!'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    getdata();
                    Navigator.pop(context);
                  },
                  child: Text('done'))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Note App'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: SafeArea(
          child: isloading
              ? Center(child: SizedBox())
              : AnimatedGrid(
                  key: _gridkey,
                  initialItemCount: notelist.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 2.8,

                      // maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5),
                  itemBuilder: (context, index, animation) {
                    return ScaleTransition(
                      scale: CurvedAnimation(
                        parent: animation,
                        curve: removing ? Curves.easeInOut : Curves.bounceOut,
                      ),
                      child: Card(
                        color: changeColor(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notelist[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    notelist[index].subtitle,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Done :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                      notelist[index].done == true
                                          ? Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              Icons.check_circle,
                                              color: Colors.grey,
                                            )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateNoteScreen(
                                                      id: notelist[index]
                                                          .id!
                                                          .toInt(),
                                                      subtitle:
                                                          notelist[index]
                                                              .subtitle,
                                                      title:
                                                          notelist[index].title,
                                                      done:
                                                          notelist[index].done),
                                            ));
                                      },
                                      child: Icon(Icons.edit)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        delete(notelist[index].id!.toInt());
                                      },
                                      child: Icon(Icons.delete)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNoteScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
