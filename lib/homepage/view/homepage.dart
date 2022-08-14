import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_demo/homepage/controllers/homepage_controller.dart';
import 'package:todo_demo/homepage/view/widgets/todo_widget.dart';
import 'package:todo_demo/utils/color_styles.dart';
import 'package:todo_demo/utils/text_styles.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appColorTheme.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          scale: 24,
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: appColorTheme.white,
        ),
        backgroundColor: appColorTheme.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Consumer(builder: (context, ref, child) {
            final viewModel = ref.watch(homeProvider);
            final todoList = viewModel.todoList;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  if (todoList.isEmpty)
                    SizedBox(
                      height: size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    ListView.separated(
                      itemCount: todoList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 12);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return TodoWidget(todo: todoList[index]);
                      },
                    ),
                  const SizedBox(height: 80),
                ],
              ),
            );
          }),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: appColorTheme.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: appColorTheme.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: InkWell(
                  onTap: () {
                    // viewModel.addTodo();
                    addTodoDialog(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: appColorTheme.darkBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: appColorTheme.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Create a new task',
                              style: appTextTheme.dp18BoldWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Future<void> addTodoDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Create New Task', style: appTextTheme.dp18BoldBlue),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: appColorTheme.darkBlue,
                    style: appTextTheme.dp16MedBlue,
                    decoration: InputDecoration(
                      hintText: 'Enter Task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: appColorTheme.darkBlue),
                      ),
                    ),
                    onChanged: (value) {
                      // viewModel.todoTitle = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                appColorTheme.red)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel', style: appTextTheme.dp16MedWhite),
                      ),
                      const SizedBox(width: 12),
                      Consumer(builder: (context, ref, child) {
                        return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  appColorTheme.darkBlue)),
                          onPressed: () {
                            log(controller.text);
                            ref.watch(homeProvider).addTodo(controller.text);
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child:
                              Text('Create', style: appTextTheme.dp16MedWhite),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
