import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cpm/constants/api/api_response.dart';
import 'package:cpm/constants/utils.dart';
import 'package:cpm/constants/widgets.dart';
import 'package:cpm/models/project.dart';
import 'package:cpm/screens/projects/tasks/_more.dart';
import 'package:cpm/services/projects.dart';
import 'package:cpm/utils/colors.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetailScreen> {
  dynamic arguments = Get.arguments;
  bool isLoading = true;
  ProjectDetail? project;

  Future<void> getProjectDetails() async {
    ApiResponse response = await getProjectById(arguments['projectId']);
    if (response.error == null) {
      setState(() {
        project = response.data as ProjectDetail?;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      errorToast(response.error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getProjectDetails();
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
        title: const Text("Project Details"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project?.title ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ExpandableText(text: project?.description ?? ''),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.blue),
                        const SizedBox(width: 5),
                        Text(
                          "${formatDate(project?.startDate)} - ${formatDate(project?.endDate)}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        const SizedBox(width: 5),
                        Text(
                          "${project?.region ?? ''}, ${project?.district ?? ''},  ${project?.ward ?? ''}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Status: ${project?.status ?? ''}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const Divider(height: 30, color: Colors.black54),
                    const Text(
                      "Assigned Tasks",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    project?.tasks?.isEmpty ?? true
                        ? const Text("No tasks available")
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: project?.tasks?.length ?? 0,
                            itemBuilder: (context, index) {
                              final task = project?.tasks?[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const TaskDetailScreen(),
                                    arguments: {'taskId': task?.id},
                                  );
                                },
                                child: Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${task?.number}-${task?.title}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // const SizedBox(height: 5),
                                        // ExpandableText(
                                        //     text: task?.description ?? ''),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_today,
                                                color: Colors.blue),
                                            const SizedBox(width: 5),
                                            Text(
                                              "${formatDate(task?.startDate)} - ${formatDate(task?.endDate)}",
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Text(
                                            //   "Progress%: ${task?.progressPercentage ?? '0'}",
                                            //   style: const TextStyle(
                                            //     fontSize: 14,
                                            //     fontWeight: FontWeight.bold,
                                            //     color: Colors.black87,
                                            //   ),
                                            // ),
                                            Text(
                                              "Status: ${task?.status ?? ''}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLength;

  const ExpandableText({
    Key? key,
    required this.text,
    this.maxLength = 100,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final truncatedText =
        truncateText(widget.text, maxLength: widget.maxLength);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isExpanded ? widget.text : truncatedText,
          style: const TextStyle(fontSize: 14),
        ),
        if (widget.text.length > widget.maxLength)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Show less' : 'Show more',
              style: const TextStyle(color: Colors.blue),
            ),
          ),
      ],
    );
  }

  String truncateText(String text, {int maxLength = 100}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
