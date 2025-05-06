import 'package:hive_flutter/adapters.dart';

class ToDODatabase {

  List toDoList = [];

  final _mybox = Hive.box('mybox');

  // run this function in the first time i use this app
  void createInitialData() {
    toDoList = [
      ['Make the bed', false],
      ['Go to the gym', false],
      ['Buy groceries', false],
    ];
  }
  // load the data from database
  void loadData() {
    toDoList = _mybox.get('TODOLIST');
  }
  // update the database
  void updateDataBase() {
    _mybox.put('TODOLIST', toDoList);
  }
}
