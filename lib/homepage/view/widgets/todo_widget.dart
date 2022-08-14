import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_demo/homepage/models/todo_model.dart';
import 'package:todo_demo/utils/color_styles.dart';
import 'package:todo_demo/utils/text_styles.dart';

class TodoWidget extends StatefulWidget {
  final TodoModel todo;
  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  bool isCompleted = false;

  @override
  void initState() {
    isCompleted = widget.todo.completed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer(builder: (context, ref, child) {
          return Checkbox(
              value: isCompleted,
              onChanged: (value) async {
                setState(() {
                  isCompleted = value!;
                });
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: appColorTheme.darkBlue);
        }),
        const SizedBox(width: 6),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            color: isCompleted
                ? appColorTheme.lightBlue.withOpacity(0.3)
                : appColorTheme.lightBlue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? appColorTheme.blue.withOpacity(0.2)
                        : appColorTheme.blue,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4)),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(widget.todo.title,
                        style: appTextTheme.dp16MedBlue.copyWith(
                            decoration: isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),
                  ),
                )
              ],
            ),
          ),
        ))
      ],
    );
  }
}
