import 'package:flutter/material.dart';
import 'package:kalle_project_attempt02/models/global.dart';
import 'package:kalle_project_attempt02/models/widgets/intray_todo_widget.dart';
import 'package:kalle_project_attempt02/models/classes/task.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];
  @override
  Widget build(BuildContext context) {
    taskList = getList();
    return Container(
      color: darkGreyColor,
      child: _buildReorderableListSimple(context),
    );
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId.toString()),
      title: IntrayTodo(
        title: item.title,
      ),
    );
  }

  Widget _buildReorderableListSimple(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent
      ),
      child: ReorderableListView(
      // handleSide: ReorderableListSimpleSide.Right,
      // handleIcon: Icon(Icons.access_alarm),
      padding: EdgeInsets.only(top: 300.0),
      children:
        taskList.map((Task item) => _buildListTile(context, item)).toList(),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          Task item = taskList[oldIndex];
          taskList.remove(item);
          taskList.insert(newIndex, item);
        });
      },
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Task item = taskList.removeAt(oldIndex);
      taskList.insert(newIndex, item);
    });
  }
  
  List<Task> getList() {
    for (int i=0; i < 10; i++) {
      taskList.add(Task("My first todo" + i.toString(), false, i.toString()));
    }
    return taskList;
  }



}
