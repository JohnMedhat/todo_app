// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todo_app/modules/cubit/cubit.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String validateText,
  required String labelText,
  required IconData prefix,
  var suffix,
  var suffixPressed,
  var onChange,
  var onSubmit,
  var onTap,
  bool isPassword = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    validator: (value) {
      if (value!.isEmpty) {
        return validateText;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(
        prefix,
      ),
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      alignLabelWithHint: true,
    ),
    onChanged: onChange,
    onFieldSubmitted: onSubmit,
    onTap: onTap,
  );
}

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red.shade900,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.delete_sweep_outlined,
                color: Colors.white,
                size: 40,
              ),
              Text('Delete')
            ],
          ),
        ),
      ),
      onDismissed: ((direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      }),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: Icon(Icons.check_box),
              color: Colors.green,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: Icon(Icons.archive),
            ),
          ],
        ),
      ),
    );

Widget tasksBuilder({
  required List<Map> tasks,
  required String tasksType,
}) =>
    tasks.isNotEmpty
        ? Container(
            color: Colors.black,
            child: ListView.separated(
                itemBuilder: (context, index) =>
                    buildTaskItem(tasks[index], context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 0.2,
                        color: Colors.grey,
                      ),
                    ),
                itemCount: tasks.length),
          )
        : Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 100,
                    color: Colors.grey,
                  ),
                  Text(
                    'There is no $tasksType tasks yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
