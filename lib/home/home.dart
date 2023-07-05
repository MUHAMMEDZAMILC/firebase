import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key,this.name});
  String? name;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(widget.name!),
        ),
      ),
    );
  }
}