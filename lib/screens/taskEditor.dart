import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/models/taskModel.dart';

class TaskEditor extends StatefulWidget {
  TaskEditor({this.TaskModel, super.key});
  taskModel? TaskModel;

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(
        text: widget.TaskModel == null ? null : widget.TaskModel!.title!);
    TextEditingController _taskNote = TextEditingController(
        text: widget.TaskModel == null ? null : widget.TaskModel!.note!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.TaskModel == null ? "Add a new Task" : "Update your Task",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.8,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "you Task's Title",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Your Task",
              ),
            ),
            //####################################################//
            SizedBox(
              height: 40.0,
            ),
            //####################################################//
            Text(
              "you Task's Descriprion",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 8,
              maxLines: 25,
              controller: _taskNote,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "description",
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  child: RawMaterialButton(
                    onPressed: () async {
                      var newTask = taskModel(
                        title: _taskTitle.text,
                        note: _taskNote.text,
                        creationDate: DateTime.now(),
                        done: false,
                      );
                      Box<taskModel> tasbox = Hive.box<taskModel>("tasks");
                      if (widget.TaskModel != null) {
                        widget.TaskModel!.title = newTask.title;
                        widget.TaskModel!.note = newTask.note;
                        widget.TaskModel!.save();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (((context) => HomePage()))));
                      } else {
                        await tasbox.add(newTask);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())));
                      }
                    },
                    fillColor: Colors.blueAccent.shade700,
                    child: Text(
                      widget.TaskModel == null ? "Add new Task" : "Update Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
