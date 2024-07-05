import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cpm/utils/colors.dart';
import 'package:cpm/widgets/appbar.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  int number = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar("tasks of the project"),
      backgroundColor: mySecondColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(parent: null),
                  itemCount: number, // Example item count
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        color: const Color(0xFFFDFCFD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 10,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Task Title"),
                              const SizedBox(
                                height: 30,
                              ),
                              Text("Startdate: ${DateTime.now().toString()}"),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                  "EndDate: ${DateTime.now().toString()}"), // Include the date
                            ],
                          ),
                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context) {
                              return [
                                const PopupMenuItem(
                                  value: "view_more",
                                  child: Text("View More"),
                                ),
                                const PopupMenuItem(
                                  value: "create_task",
                                  child: Text("Create Task Item"),
                                ),
                              ];
                            },
                            onSelected: (value) {
                              if (value == "view_more") {
                                // Handle View More option
                                if (kDebugMode) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text("add your task item"),
                                          content: Text(""),
                                        );
                                      });
                                  print("View More selected");
                                }
                              } else if (value == "create_task") {
                                // Handle Create Task Item option
                                if (kDebugMode) {
                                  print("Create Task Item selected");
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
