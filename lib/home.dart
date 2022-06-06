import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter/show_screen.dart';
import 'package:sqflite_flutter/sqliteDb.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqliteDb sqliteDb=SqliteDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Home screen'),

      ),
      body:Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [MaterialButton(
            child: Text('Insert data'),
            color: Colors.red,
            textColor: Colors.white,
            onPressed: ()async{
              int response=await sqliteDb.insertData("INSERT INTO 'notes'('note','title') VALUES ('note one','title one') ");
                //await sqliteDb.insertData("INSERT INTO 'notes'('title') VALUES ('title one') ,");
                 print("response: $response");
            },
          ),
          SizedBox(height: 20,),
            MaterialButton(
              child: Text('Read data'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: ()async{
                List<Map> response =await sqliteDb.readData("SELECT * FROM 'notes'");
                print("Response = $response");
              },
            ),
            SizedBox(height: 20,),
            MaterialButton(
              child: Text('Delete data'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: ()async{
                int response =await sqliteDb.deleteData("DELETE FROM 'notes' WHERE id =2");
                print("Response = $response");
              },
            ),
            SizedBox(height: 20,),

            MaterialButton(
              child: Text('Update data'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: ()async{
                int response =await sqliteDb.updateData("UPDATE 'notes' SET 'note'='three note' WHERE id =3");
                print("Response = $response");
              },
            ),
            SizedBox(height: 20,),
            MaterialButton(
              child: Text('Show data'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowScreen()));
                },
            ),
            SizedBox(height: 20,),

            MaterialButton(
              child: Text('Delete Database'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: ()async{
              sqliteDb.myDeleteDatabase();
              print('delete database');
                },
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
