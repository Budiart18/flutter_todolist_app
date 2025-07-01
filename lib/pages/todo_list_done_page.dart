import 'package:flutter/material.dart';
import 'package:flutter_todolist_app/model/todo_item.dart';
import 'package:flutter_todolist_app/utils/network_manager.dart';
import 'package:flutter_todolist_app/widget/item_widget.dart';

class TodoListDonePage extends StatefulWidget {
  const TodoListDonePage({super.key});

  @override
  State<TodoListDonePage> createState() =>
      _TodoListDonePageState();
}

class _TodoListDonePageState
    extends State<TodoListDonePage> {
  List<TodoItem> todos = [];
  bool isLoading = false;
  int totalDone = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    NetworkManager().getTodosIsDone(true).then((value) {
      todos = value;
      totalDone = value.length;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Todo List App")),
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "Todo List Yang sudah diselesaikan : $totalDone",
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: todos.isEmpty
                        ? Center(
                            child: Text("Tidak ada data"),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return ItemWidget(
                                todoItem: todos[index],
                                handleRefresh: () {},
                              );
                            },
                            itemCount: todos.length,
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
