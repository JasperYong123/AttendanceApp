// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:attendance_app/attendance_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';


import 'package:attendance_app/user_shared_preference.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: "Attendance App"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _attendances = [];
  bool timeAgo = true;



  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/attendance.json');
    final data = await json.decode(response);
    setState(() {
      _attendances = data["attendance"]; 
    });
  }
  
  
  @override
  void initState() {
    super.initState();
    timeAgo = SharedPreference.getTimeFormatFromSharedPref();
    readJson().then((_) {
    // Convert the date strings to DateTime objects
    for (var attendance in _attendances) {
      attendance['check-in'] = DateTime.parse(attendance['check-in']);
    }

    // Sort the list based on the "check-in" date in ascending order
    _attendances.sort((a, b) => a['check-in'].compareTo(b['check-in']));
    
    // Now, your _attendances list should be sorted.
  });
    
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: (){setState(() {
              timeAgo = timeAgo == false;
              SharedPreference.setTimeFormatForSharedPref(timeAgo);
            });},
            child: Text("Change Time format"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _attendances.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    onTap: (){},
                    title: Text(_attendances[index]['user']),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Phone:${_attendances[index]['phone']}'),
                        timeAgo ? Text(timeago.format(_attendances[index]['check-in'],locale: 'en')):Text('Date:${DateFormat('dd MMM yyyy, h:mm a').format(_attendances[index]['check-in'])}')
                      ],
                    ),
                  ),
                );
              }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}