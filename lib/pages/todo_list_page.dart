import 'package:flutter/material.dart';
import 'package:flutter_todolist_app/model/todo_item.dart';
import 'package:flutter_todolist_app/pages/form_page.dart';
import 'package:flutter_todolist_app/pages/todo_list_done_page.dart';
import 'package:flutter_todolist_app/utils/network_manager.dart';
import 'package:flutter_todolist_app/widget/item_widget.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TodoItem> todos = [];
  bool isLoading = false;
  int totalDone = 0;

  void refreshData() {
    setState(() {
      isLoading = true;
    });
    NetworkManager().getTodosIsDone(true).then((value) {
      totalDone = value.length;
      setState(() {});
    });
    NetworkManager().getTodosIsDone(false).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
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
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Todo List",
                  style: textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TodoListDonePage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Sudah diselesaikan : $totalDone",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
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
                                handleRefresh: refreshData,
                              );
                            },
                            itemCount: todos.length,
                          ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormPage();
              },
            ),
          );
          refreshData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
