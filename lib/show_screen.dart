import 'package:flutter/material.dart';
import 'package:sqflite_flutter/sqliteDb.dart';

import 'edit_notes.dart';

class ShowScreen extends StatefulWidget {
  const ShowScreen({Key? key}) : super(key: key);

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  SqliteDb sqliteDb = SqliteDb();
List notes=[];
bool isLoading=true;

  Future readData() async {
    List<Map> response = await sqliteDb.read("notes");
    //List<Map> response = await sqliteDb.readData("SELECT * FROM notes");

      notes.addAll(response);
      isLoading=false;
    if(this.mounted)
      setState(() {});
  }
@override
  void initState() {
    readData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show screen'),
      ),
      body: Container(
        child: isLoading==true?Center(child: CircularProgressIndicator(),)
        :ListView(
          children: [
             ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: notes.length,
                        itemBuilder: (context, i) {
                          return Card(
                              child: ListTile(
                            title: Text("${notes[i]['note']}"),
                            subtitle: Text("${notes[i]['title']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                              IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: ()async{
                              //  int response =await sqliteDb.deleteData("DELETE FROM notes WHERE id = ${notes[i]['id']}");
                                int response= await sqliteDb.delete("notes", "id = ${notes[i]['id']}");

                                if(response>0)
                                  notes.removeWhere((element) => element['id']==notes[i]['id']);
                                setState(() {});
                                print(response);
                              },
                              ),
                              IconButton(icon: Icon(Icons.edit,color: Colors.blue,),onPressed: ()async{
                                Navigator.push(context, MaterialPageRoute(builder: (context )=>EditNotes(note:notes[i]['note'],color:notes[i]['color'],id:notes[i]['id'],title:notes[i]['title'])));

                              },
                              ),
                            ],),
                          ));
                        }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addNotes");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
