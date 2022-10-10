import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/taskModel.dart';
import 'package:todo_list/screens/taskEditor.dart';

class ListItem extends StatefulWidget {
  ListItem(this.TaskModel, this.index, {super.key});
  taskModel TaskModel;
  int index;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color.fromARGB(255, 94, 132, 181);
      }
      return Colors.red;
    }

    return Container(
        margin: EdgeInsets.only(bottom: 12.0),
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.blue.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                ),
                Expanded(
                  child: Text(
                    widget.TaskModel.title!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskEditor(
                                  TaskModel: widget.TaskModel,
                                )));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.TaskModel.delete();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black87,
              height: 20.0,
              thickness: 1.0,
            ),
            Text(
              widget.TaskModel.note!,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ));
  }
}
