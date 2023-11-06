// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AttendanceList extends StatefulWidget {
  const AttendanceList({super.key});

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  int count =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: getAttendanceListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('button clicked');
        },

        child: Icon(Icons.add),

        ),
      );
    
  }
  ListView getAttendanceListView(){
    return ListView.builder(itemCount: count, itemBuilder:(context, index){
      return ListView.builder(
        itemCount:count ,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color:  Colors.white,
            elevation: 2.0,
            child:  ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(Icons.keyboard_arrow_right_rounded),
                ),
                title: Text('dummy title'),
                subtitle: Text('subtitle'),
                
            ),
          );
        });
  }
    );
  }
}