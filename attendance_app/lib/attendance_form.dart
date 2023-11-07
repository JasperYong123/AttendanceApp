// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AttendanceForm extends StatefulWidget {
  const AttendanceForm({super.key});

  @override
  State<AttendanceForm> createState() => _AttendanceFormState();
}

class _AttendanceFormState extends State<AttendanceForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AttendanceForm'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)))),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          labelText: 'Phone No',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))))),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                      labelText: 'Date',
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)
                      )
                  ),
                  readOnly: true,
                  onTap: (){_selectDate();},
                ),
              ),Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                      labelText: 'Time',
                      filled: true,
                      prefixIcon: Icon(Icons.access_time),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)
                      )
                  ),
                  readOnly: true,
                  onTap: (){_selectTime();},
                ),
              ),
              Expanded(
                  child: ElevatedButton(
                child: Text(
                  'Save',
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  if(nameController.text.isNotEmpty && phoneController.text.isNotEmpty && dateController.text.isNotEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You successfully added a new record to the list'),
                      
                    ),
                    
                  );}
                  Navigator.pushReplacementNamed(context, '/',
                  arguments: {
                    'user': nameController.text,
                    'phone': phoneController.text,
                    'check-in':DateTime.parse(dateController.text)
                  }
                );},
              ))
            ,Expanded(
                  child: ElevatedButton(
                child: Text(
                  'Cancel',
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');},
              ))],
          ),
        ));
  }
  Future<void> _selectDate()async{
  DateTime? date = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate:DateTime(2000), 
    lastDate: DateTime(2100));

  if(date != null){
    setState(() {
      dateController.text = date.toString().split(" ")[0];
    });
  }

}
Future<void> _selectTime()async{
   DateTime dateTime = DateTime.parse(dateController.text);
  TimeOfDay? time = await showTimePicker(
    context: context, 
    initialTime: TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.dial,
    );
  if(time != null){
    Duration additionalTime = Duration(hours: time.hour, minutes: time.minute);
    DateTime newDateTime = dateTime.add(additionalTime);
    dateController.text = newDateTime.toString();
    setState(() {
      timeController.text = "${time.hour}:${time.minute}";
    });

  }
}


}


