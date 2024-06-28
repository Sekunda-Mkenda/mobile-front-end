import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:login/constants/api/api_response.dart';
import 'package:login/constants/utils.dart';
import 'package:login/models/project.dart';
import 'package:login/models/projects.dart';
import 'package:login/screens/projects/_more.dart';
import 'package:login/services/projects.dart';
import 'package:login/utils/colors.dart';
import '../../constants/widgets.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  List<ProjectsData> projects = [];
  late ProjectList projectsPayload;
  bool isLoading = true;
  bool isFetchingMore = false;
  bool hasMore = true;
  final TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  final int pageSize = 10;

  Future<void> getData({String query = '', int page = 1}) async {
    if (page == 1) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isFetchingMore = true;
      });
    }

    ApiResponse response =
        await getProjects('member/projects?=page=$page&search=$query');

    if (response.error == null) {
      setState(() {
        if (page == 1) {
          projectsPayload = response.data as ProjectList;
          projects = projectsPayload.data as List<ProjectsData>;
        } else {
          projects.addAll(projectsPayload.data as List<ProjectsData>);
        }
        hasMore = projects.length == pageSize;
        currentPage = page;
        isLoading = false;
        isFetchingMore = false;
      });
    } else {
      setState(() {
        isLoading = false;
        isFetchingMore = false;
      });
      errorToast(response.error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void handleShowProjectById(String? projectId) {
    Get.to(() => const ProjectDetailScreen(),
        arguments: {'projectId': projectId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myPrimaryColor,
        title: const Text("My Projects"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30.0),
            onPressed: () {
              // show dropdown menu
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(1000, 80, 0, 0),
                items: [
                  const PopupMenuItem<String>(
                    value: 'profile',
                    child: Text('My Profile'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    onTap: logoutHander,
                    child: Text('Logout'),
                  ),
                ],
                elevation: 8.0,
              ).then((value) {
                if (value == 'profile') {
                  // Navigate to profile
                } else if (value == 'logout') {
                  // Perform logout
                }
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                hintText: 'Search projects...',
                prefixIcon: const Icon(Icons.search, size: 30),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                getData(query: value, page: 1);
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => getData(query: searchController.text, page: 1),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: projects.length + (hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == projects.length) {
                          if (isFetchingMore) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            getData(
                                query: searchController.text,
                                page: currentPage + 1);
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }
                        final project = projects[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              project.cover != null
                                  ? Image.network(project.cover!)
                                  : SizedBox(
                                      height: 200.0,
                                      width: double.infinity,
                                      child: Image.asset(
                                          'assets/project_placeholder.jpg',
                                          fit: BoxFit.cover),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: GestureDetector(
                                  onTap: () =>
                                      handleShowProjectById(project.id),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        project.title ?? '',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        project.description ??
                                            "No description available",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_today,
                                              color: Colors.blue),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${formatDate(project.startDate)} - ${formatDate(project.endDate)}",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              color: Colors.red),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Location: ${project.region}, ${project.district}",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(Icons.account_circle,
                                              color: Colors.green),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Manager: ${project.manager}",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Status: ${project.status}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
