import 'package:flutter/material.dart';

class ViewTask extends StatefulWidget {
  String title;
  String description;

   ViewTask( {Key? key, required this.title,required this.description}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title,style: const TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 15,
            ),
            Text(widget.description,style: const TextStyle(fontSize: 16,fontStyle: FontStyle.italic),)
          ],
        ),
      ),
    );
  }
}
