import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/models/taskModel.dart';
import 'package:todo_list/screens/taskEditor.dart';
import 'package:todo_list/widgets/listItem.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<taskModel>(taskModelAdapter());
  box = await Hive.openBox<taskModel>("tasks");
  box.add(taskModel(
      title: "this is the first Task",
      note: "this ti the fist task the app",
      creationDate: DateTime.now()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 229, 229),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: const Color.fromARGB(255, 213, 72, 41),
        title: const Text(
          "ToDo List",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<taskModel>>(
        valueListenable: Hive.box<taskModel>("tasks").listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Task",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  formatDate(DateTime.now(), [d, ",", M, " ", yyyy]),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 19.0,
                  ),
                ),
                Divider(
                  height: 40.0,
                  thickness: 1.0,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    taskModel currentTask = box.getAt(index)!;
                    return ListItem(currentTask, index);
                  },
                )),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TaskEditor()));
        },
        focusColor: Colors.black,
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 50, 30, 0),
      ),
    );
  }
}
