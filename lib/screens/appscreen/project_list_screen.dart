import 'package:flutter/material.dart';
import 'package:login/utils/colors.dart';
import 'package:login/widgets/appbar.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  int number = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mySecondColor,
      appBar: myAppbar(""),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Your project lists..."),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 4,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Project Title"),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text("Manager's Name"),
                              const SizedBox(
                                height: 30,
                              ),
                              Text("Date: ${DateTime.now().toString()}"),
                            ],
                          ),
                          // trailing: DropdownButton(
                          //   icon: const Icon(Icons.more_vert),
                          //   itemBuilder: (BuildContext context) {
                          //     return [
                          //       const PopupMenuItem(
                          //         value: "view_more",
                          //         child: Text("View More"),
                          //       ),
                          //       const PopupMenuItem(
                          //         value: "create_task",
                          //         child: Text("Create Task Item"),
                          //       ), // Include the date
                          //     ];
                          //   },
                          // ),
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
