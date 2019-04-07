import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/models/todo.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoState();
  }
}

class TodoState extends State<TodoScreen> {
  TodoProvider myTodo = TodoProvider();
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarActions = [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/newScreen");
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            myTodo.deleteDone();
          });
        },
      )
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
          actions: <Widget>[appBarActions[tabIndex]],
        ),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder(
              future: myTodo.open().then((r) {
                return myTodo.getNotDone();
              }),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Todo item = snapshot.data[index];
                      return CheckboxListTile(
                        title: Text("${item.title}"),
                        value: item.done,
                        onChanged: (bool value) {
                          setState(() {
                            item.done = true;
                            myTodo.update(item);
                          });
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No data found.."));
                }
              },
            ),
            FutureBuilder(
              future: myTodo.open().then((r) {
                return myTodo.getDone();
              }),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Todo item = snapshot.data[index];
                      return CheckboxListTile(
                        title: Text("${item.title}"),
                        value: item.done,
                        onChanged: (bool value) {
                          setState(() {
                            item.done = false;
                            myTodo.update(item);
                          });
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No data found.."));
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blue,
          indicatorColor: Colors.blue,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.list),
              text: "Task",
            ),
            Tab(
              icon: Icon(Icons.done_all),
              text: "Completed",
            ),
          ],
          onTap: (index) {
            setState(() {
              tabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
