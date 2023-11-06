import 'package:flutter/material.dart';

class AttendanceList extends StatelessWidget {
  const AttendanceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance List')),
      body: Center(child: Text('This is the attendance list page!')),
    );
  }
}