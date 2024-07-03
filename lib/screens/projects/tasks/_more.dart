import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cpm/widgets/buttons.dart';

import '../../../constants/api/api_response.dart';
import '../../../constants/utils.dart';
import '../../../constants/widgets.dart';
import '../../../models/task.dart';
import '../../../services/projects.dart';
import '../../../utils/colors.dart';
import '../_more.dart';
import 'items/_create.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({Key? key}) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  dynamic arguments = Get.arguments;
  bool _isLoading = true;
  bool _isCreateLoading = true;
  Task? task;
  bool showQuantity = true;
  String statusValue = 'progress'; // Default status value

  Future<void> getTaskDetails() async {
    ApiResponse response = await getTaskById(arguments['taskId']);
    if (response.error == null) {
      setState(() {
        task = response.data as Task?;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      errorToast(response.error.toString());
    }
  }

  Future<void> handleUpdateTaskStatus() async {
    ApiResponse response =
        await updateTaskStatus(arguments['taskId'], statusValue);
    if (response.error == null) {
      setState(() {
        task = response.data as Task?;
        _isCreateLoading = false;
      });
      successToast("Task status updated successfully");
      getTaskDetails();
    } else {
      setState(() {
        _isCreateLoading = false;
      });
      errorToast(response.error.toString());
    }
  }

  Future<void> handleDeleteTaskItem(String? taskItemId) async {
    ApiResponse response = await deleteTaskItem(taskItemId);
    if (response.error == null) {
      setState(() {
        _isCreateLoading = false;
      });
      successToast("Task item deleted successfully");
      getTaskDetails();
    } else {
      setState(() {
        _isCreateLoading = false;
      });
      errorToast(response.error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskDetails();
  }

  String truncateText(String? text, {int maxLength = 100}) {
    if (text == null || text.length <= maxLength) return text ?? '';
    return '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myPrimaryColor,
        title: Text("${task?.title} (${task?.number})"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  ExpandableText(text: task?.description ?? ''),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.blue),
                      const SizedBox(width: 5),
                      Text(
                        "${formatDate(task?.startDate)} - ${formatDate(task?.endDate)}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Status: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87, // Gray color for "Status: "
                          ),
                        ),
                        TextSpan(
                          text: task?.status ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color:
                                Colors.orange, // Orange color for task status
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.update),
                            onPressed: () {
                              _updateStatus();
                            },
                          ),
                          const Text('Update Status'),
                        ],
                      ),
                      const Column(
                        children: [
                          // IconButton(
                          //   icon: const Icon(Icons.update),
                          //   onPressed: () {
                          //     _updateProgress();
                          //   },
                          // ),
                          // const Text('Update Progress %'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Task Items',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Get.to(() => const CreateTaskItemScreen(),
                              arguments: {'taskId': task?.id});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // ignore: prefer_is_empty
                  task?.taskItems?.length == 0
                      ? const Center(child: Text("No task item found."))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: task?.taskItems?.length ?? 0,
                          itemBuilder: (context, index) {
                            final taskItem = task?.taskItems?[index];
                            return Card(
                              child: ListTile(
                                title: Text(taskItem?.title ?? ''),
                                subtitle: Text(
                                    'type: ${truncateText(taskItem?.type ?? '')}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Text(
                                    //     'Amount: ${taskItem?.amount} ${taskItem?.unit}'),
                                    PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Text('Delete'),
                                          onTap: () => handleDeleteTaskItem(
                                              taskItem?.id),
                                        ),
                                        PopupMenuItem(
                                          child: const Text('Show More'),
                                          onTap: () =>
                                              showMoreTaskItem(taskItem!),
                                        ),
                                        // const PopupMenuItem(
                                        //   child: Text('Update'),
                                        //   // onTap: () => updateTaskItem(taskItem!),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  void showMoreTaskItem(TaskItem taskItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Task Item Details'),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('ID: ${taskItem.id}'),
                  Text('Title: ${taskItem.title}'),
                  Text('Description: ${taskItem.description}'),
                  Text('Type: ${taskItem.type}'),
                  Text('Amount: ${taskItem.amount}'),
                  Text('Quantity: ${taskItem.quantity}'),
                  Text('Unit: ${taskItem.unit}'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateStatus() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Update Task Status'),
                  RadioListTile(
                    title: const Text('Progress'),
                    value: 'progress',
                    groupValue: statusValue,
                    onChanged: (value) {
                      setModalState(() {
                        statusValue = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Pending'),
                    value: 'pending',
                    groupValue: statusValue,
                    onChanged: (value) {
                      setModalState(() {
                        statusValue = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Closed'),
                    value: 'closed',
                    groupValue: statusValue,
                    onChanged: (value) {
                      setModalState(() {
                        statusValue = value.toString();
                      });
                    },
                  ),
                  myElevatedButton('Update', () {
                    handleUpdateTaskStatus();
                    Navigator.pop(context);
                    // getTaskDetails();
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
