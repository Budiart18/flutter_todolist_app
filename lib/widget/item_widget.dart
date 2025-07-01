// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_todolist_app/model/todo_item.dart';
import 'package:flutter_todolist_app/utils/network_manager.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.todoItem,
    required this.handleRefresh,
  }) : super(key: key);
  final TodoItem todoItem;
  final Function() handleRefresh;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: todoItem.isDone ? Colors.grey : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(todoItem.title),
                  SizedBox(height: 5),
                  Text(todoItem.description),
                ],
              ),
            ),
            SizedBox(width: 5),
            if (!todoItem.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  await NetworkManager().updateData(
                    todoItem.copyWith(isDone: true),
                  );
                  handleRefresh();
                },
                child: Icon(Icons.check),
              ),
            SizedBox(width: 8),
            if (!todoItem.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  await NetworkManager().deleteData(
                    todoItem,
                  );
                  handleRefresh();
                },
                child: Icon(Icons.delete_forever),
              ),
          ],
        ),
      ),
    );
  }
}
