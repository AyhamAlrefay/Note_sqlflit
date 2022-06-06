import 'package:flutter/material.dart';
import 'package:sqflite_flutter/sqliteDb.dart';

class EditNotes extends StatefulWidget {
  final note;
  final color;
  final id;
  final title;

  EditNotes({Key? key, this.note, this.color, this.id, this.title})
      : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController notesController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  var idController;

  SqliteDb sqliteDb = SqliteDb();

  @override
  void initState() {
    notesController.text = widget.note;
    colorController.text = widget.color;
    titleController.text = widget.title;
    idController = widget.id;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit notes"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Form(
            key: formState,
            child: Column(
              children: [
                TextFormField(
                  controller: notesController,
                  decoration: InputDecoration(
                    hintText: 'notes',
                  ),
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                ),
                TextFormField(
                  controller: colorController,
                  decoration: InputDecoration(
                    hintText: 'color',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  color: Colors.blue,
                  child: MaterialButton(
                    onPressed: () async {
                      // int response=await sqliteDb.insertData('''
                      // UPDATE notes SET
                      //  `note` = "${notesController.text}",
                      //  `color`= "${colorController.text}",
                      //  `title` ="${titleController.text}"
                      // WHERE id=$idController
                      // ''');
                      int response = await sqliteDb.update(
                          "notes",
                          {
                            "note": "${notesController.text}",
                            "color": "${colorController.text}",
                            "title": "${titleController.text}",
                          },
                          "id=$idController");

                      print("response: $response");
                      if (response > 0) {
                        Navigator.pushReplacementNamed(context, 'showNotes');
                      }
                    },
                    child: Text("Edit note"),
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
