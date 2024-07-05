import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cpm/constants/api/api_response.dart';
import 'package:cpm/constants/widgets.dart';
import 'package:cpm/services/projects.dart';
import 'package:cpm/utils/colors.dart';

import '../../../../constants/utils.dart';
import '../../../../widgets/buttons.dart';
import '../_more.dart';

class CreateTaskItemScreen extends StatefulWidget {
  const CreateTaskItemScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskItemScreen> createState() => _CreateTaskItemScreenState();
}

class _CreateTaskItemScreenState extends State<CreateTaskItemScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  dynamic arguments = Get.arguments;
  bool isLoading = false;
  String? _selectedItemType = '';
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> createTaskItem() async {
    if (formKey.currentState!.validate()) {
      final Map<String, dynamic> payload = {
        "task": arguments['taskId'],
        "title": _titleController.text,
        "description": _descriptionController.text,
        "type": _selectedItemType,
        "quantity": _quantityController.text,
        "amount": _amountController.text,
        "unit": _unitController.text,
        "attachment": getStringImage(_imageFile) ?? ''
      };

      setState(() {
        isLoading = true;
      });

      ApiResponse response = await createTaskItemApi(payload);

      setState(() {
        isLoading = false;
      });

      if (response.error == null) {
        _titleController.clear();
        _descriptionController.clear();
        _quantityController.clear();
        _amountController.clear();
        _unitController.clear();
        _selectedItemType = 'Service';
        _imageFile = null;
        successToast("Task item created successfully");
        // Handle navigation or any other action after successful creation
        Get.off(
          () => const TaskDetailScreen(),
          arguments: {'taskId': arguments['taskId']},
        );
      } else {
        errorToast(response.error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'title',
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  // validator: FormBuilderValidators.required(context),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'description',
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  // validator: FormBuilderValidators.required(context),
                ),
                const SizedBox(height: 20),
                FormBuilderDropdown(
                  name: 'type',
                  decoration: const InputDecoration(labelText: 'Type'),
                  // validator: FormBuilderValidators.required(context),
                  items: const [
                    DropdownMenuItem(
                      value: 'Product',
                      child: Text('Product'),
                    ),
                    DropdownMenuItem(
                      value: 'Service',
                      child: Text('Service'),
                    ),
                  ],
                  onChanged: (dynamic value) {
                    setState(() {
                      _selectedItemType = value;
                      if (value == 'Service') {
                        _quantityController.text = '';
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (_typeController.text != 'Service') ...[
                  _selectedItemType == 'Product'
                      ? FormBuilderTextField(
                          name: 'quantity',
                          controller: _quantityController,
                          decoration:
                              const InputDecoration(labelText: 'Quantity'),
                          // validator: FormBuilderValidators.required(context),
                          keyboardType: TextInputType.number,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                ],
                FormBuilderTextField(
                  name: 'amount',
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  // validator: FormBuilderValidators.required(context),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                _selectedItemType == 'Product'
                    ? FormBuilderTextField(
                        name: 'unit',
                        controller: _unitController,
                        decoration: const InputDecoration(labelText: 'Unit'),
                        // validator: FormBuilderValidators.required(context),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 200.0,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text('Take a photo'),
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text('Choose from gallery'),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          // borderRadius: BorderRadius.circular(75.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: _imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: 50.0,
                              color: Colors.grey[600],
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: Text(
                    'Tap to select an image (optional)',
                    style: TextStyle(fontSize: 16.0, color: Colors.black38),
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? progressIndicator(loadingText: "Creating Item...")
                    : myElevatedButton("Create", createTaskItem),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
