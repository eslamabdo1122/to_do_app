import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/to_do_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');

  ToDODatabase db = ToDODatabase();

  @override
  void initState() {
    super.initState();
    if (_mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        String newTask = '';
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: const Color.fromARGB(255, 250, 250, 255),
          title: const Text(
            '✨ Add a New Task ✨',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 15, 76, 129),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                onChanged: (value) {
                  newTask = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter task name...',
                  hintStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 240, 248, 255),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 15, 76, 129),
                      width: 2,
                    ),
                  ),
                ),
                style: const TextStyle(color: Colors.black87, fontSize: 18),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                if (newTask.trim().isNotEmpty) {
                  setState(() {
                    db.toDoList.add([newTask, false]);
                    db.updateDataBase();
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 15, 76, 129),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add Task',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDataBase();
    });
  }

  void edeitTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String newTask = db.toDoList[index][0];
        return AlertDialog(
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: const Color.fromARGB(255, 250, 250, 255),
          title: const Text(
            'Edit Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 15, 76, 129),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                controller: TextEditingController(text: newTask),
                onChanged: (value) {
                  newTask = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter task name...',
                  hintStyle: const TextStyle(
                    color: Colors.black45,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 240, 248, 255),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 15, 76, 129),
                      width: 2,
                    ),
                  ),
                ),
                style: const TextStyle(color: Colors.black87, fontSize: 18),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                if (newTask.trim().isNotEmpty) {
                  setState(() {
                    db.toDoList[index][0] = newTask;
                    db.updateDataBase();
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 15, 76, 129),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 61, 94),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          iconSize: 30,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            iconSize: 30,
            onPressed: () {},
          ),
        ],
        title: const Text(
          'TODO',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            // letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: Colors.black54,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: createNewTask,
        child: Icon(Icons.add, color: Colors.white, size: 40),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            isChecked: db.toDoList[index][1],
            onChanged: (value) {
              setState(() {
                db.toDoList[index][1] = value!;
                db.updateDataBase();
              });
            },
            deleteFunction: (p0) => deleteTask(index),
            editFunction: (p0) => edeitTask(index),
          );
        },
      ),
    );
  }
}
