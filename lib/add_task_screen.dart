import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  addTask()async{
    FirebaseAuth auth= FirebaseAuth.instance;
     String userId= auth.currentUser!.uid;
     var time= DateTime.now();
     FirebaseFirestore.instance.collection("tasks").doc(userId).collection("my tasks").doc().set(
         {
           "title":titleController.text,
           "description":descriptionController.text,
           "time":time
         });
     Fluttertoast.showToast(msg: "Task Added");
     descriptionController.clear();
     titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor:Colors.pinkAccent ,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Add title",
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: "Add Description",
                  border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(onPressed: () {
            addTask();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.pinkAccent)),
            child: Text("Add Task"),)
        ],
      )
    );
  }
}
