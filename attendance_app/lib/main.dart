// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:attendance_app/attendance_form.dart';
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
      // home: MyHomePage(title: "Attendance App"),
      
      routes: {
        '/': (context) => MyHomePage(title: "Attendance App"),
        '/form' : (context) => AttendanceForm("Add Record"),
        '/edit' : (context) => AttendanceForm("Edit Record"),
      },
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
  List _found = [];
  bool timeAgo = true;
  final ScrollController _scrollController = ScrollController();
  Map<dynamic, dynamic>? entry = {};

  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/attendance.json');
    final data = await json.decode(response);
    setState(() {
      _attendances = data["attendance"]; 
    });
  }
  
  void filter(String keyword){
    List results =[];
    if(keyword.isEmpty){
      results = _attendances;
    }
    else{
      results = _attendances.where((element) => element['user'].toLowerCase().contains(keyword.toLowerCase())).toList();
      
    }
    setState(() {
        _found = results;
      });
  }
  
  @override
  void initState() {
    super.initState();
    timeAgo = SharedPreference.getTimeFormatFromSharedPref();
    _attendances = SharedPreference.getListFromSharedPreferences();
    if(_attendances.isEmpty){
    readJson().then((_) {
    // Convert the date strings to DateTime objects
    for (var attendance in _attendances) {
      if(attendance['check-in'] is String){
      attendance['check-in'] = DateTime.parse(attendance['check-in']);}
    }

    // Sort the list based on the "check-in" date in ascending order
    _attendances.sort((a, b) => b['check-in'].compareTo(a['check-in']));
    
    // Now, your _attendances list should be sorted.
  });
  }
  _found = _attendances;
    
  }
  
  @override
  Widget build(BuildContext context) {

  entry = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;
  if(entry != null ){
   // print(entry!['check-in'] is String);
    setState(() {
      _attendances.add(entry);

    
    });
    SharedPreference.saveListToSharedPref(_attendances);
    
  }
  if(SharedPreference.getListFromSharedPreferences().isNotEmpty){

      _attendances = SharedPreference.getListFromSharedPreferences();
      _attendances.sort((a, b) => b['check-in'].compareTo(a['check-in']));
  }
  _found = _attendances;

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
          TextField(
            onChanged: (value) => filter(value),
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search)),
          ),
          SizedBox(
            height: 20,
          ),
          
          Expanded(
            child: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollEndNotification &&
              _scrollController.position.extentAfter == 0) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You have reached the end of the list'),
              ),
            );
          }
          return false;
        },
          
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _found.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(Icons.keyboard_arrow_right_rounded),),
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/edit',
                      arguments:_found[index]);
                    },
                    title: Text(_found[index]['user']),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Phone:${_found[index]['phone']}'),
                        timeAgo ? Text(timeago.format(_found[index]['check-in'],locale: 'en')):Text('Date:${DateFormat('dd MMM yyyy, h:mm a').format(_found[index]['check-in'])}')
                      ],
                    ),
                  ),
                );
              }),
          ),
      )],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            Navigator.pushReplacementNamed(context, '/form');
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  
}