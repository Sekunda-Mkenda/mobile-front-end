import 'package:cpm/constants/widgets.dart';
import 'package:cpm/models/user.dart';
import 'package:cpm/models/user_profile.dart';
import 'package:cpm/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cpm/constants/api/api_response.dart';
import 'package:cpm/constants/utils.dart';
import 'package:cpm/utils/colors.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserProfile? userProfile;
  bool isLoading = true;

  Future<void> getUserProfile() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse response = await getProfile();

    if (response.error == null) {
      setState(() {
        userProfile = response.data as UserProfile;
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
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myPrimaryColor,
        title: const Text("User Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30.0),
            onPressed: () {
              // show dropdown menu
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(1000, 80, 0, 0),
                items: [
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: const Text('My Profile'),
                    onTap: () => Get.to(() => const UserProfileScreen()),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      userProfile?.profile != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(userProfile?.profile),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/user_placeholder.jpg'),
                            ),
                      const SizedBox(height: 20),
                      Text(
                        "${userProfile?.firstName} ${userProfile?.middleName} ${userProfile?.lastName}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Email: ${userProfile?.email}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Mobile: ${userProfile?.mobile}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
