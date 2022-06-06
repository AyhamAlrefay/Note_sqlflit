import 'package:flutter/material.dart';
import 'package:sqflite_flutter/sqliteDb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController notesController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  SqliteDb sqliteDb = SqliteDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add notes"),
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
                  suffixIcon: IconButton(onPressed: (){},icon: Icon(Icons.height),)
                  ,suffix: IconButton(icon:Icon(Icons.height) ,onPressed: (){},)
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
                      // INSERT INTO notes (`note`,`title`,`color`)
                      // VALUES ("${notesController.text}","${titleController.text}","${colorController.text}")
                      // ''');
                      int response = await sqliteDb.insert("notes", {
                        "note": "${notesController.text}",
                        "title": "${titleController.text}",
                        "color": "${colorController.text}"
                      });

                      print("response: $response");
                      if (response > 0) {
                        Navigator.pushReplacementNamed(context, 'showNotes');
                      }
                    },
                    child: Text("Add note"),
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
