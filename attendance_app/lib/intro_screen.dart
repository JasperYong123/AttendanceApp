// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Introduction Page"),
      ),

      body: Column(
        children: [
          ElevatedButton(
            onPressed: (){
                Navigator.of(context).maybePop();
            },
            child: Text("Proceed To Home Page"),
          ),
        Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("Hello, this is the introduction page for this attendence app. \n The app is used to record the attendance of user.\n "),
            )
            ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Center(
              child: Text("To continue to the home page press the button above \n The format of the list can be switch my pressing the Change Time format button at the top of the page\n")
              ),
        ),
        Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("The button at the left bottom corner of the screen is used to add records\n"),
            )
            ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("An Indicator will show at the buttom of the screen if the record has been successfully added\n"),
            )
            ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("When the button is pressed you will be brought to another page to enter the details of the record\n"),
            )
            ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("Press save once all fields have been filled or press cancel if you no longer wish to add a record\n"),
            )
            ),
            Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("You can use the search bar at the top to find users with the keyword you enter\n"),
            )
            ),          
            Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("An Indicator will appear at the bottom of the screen if you scroll to the end of the list\m"),
            )
            ),          
            Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("Pressing the arrow button beside each entry will bring you to a page where you can preview the record\n"),
            )
            ),Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("The edit function has not been implemented and therefore press cancel when u are done previewing the record\n"),
            )
            ),          
            Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text("Pressing save will add a new entry with the following fields\n"),
            )
            ),         
        ]),
    );
  }
}
