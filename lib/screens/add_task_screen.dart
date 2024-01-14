// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:aryan_01/bloc/user_bloc/user_bloc.dart';
import 'package:aryan_01/custom_widget/custom_button.dart';
import 'package:aryan_01/custom_widget/custom_text_field.dart';
import 'package:aryan_01/custom_widget/gap.dart';
import 'package:aryan_01/models/task_model.dart';
import 'package:aryan_01/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


class AddTaskScreen extends StatefulWidget {
  String docId;
  String taskName;
  String description;
  bool isEditScreen;
  String? selectedCategory;
  DateTime? selectedDueDate;
  AddTaskScreen({
    Key? key,
    this.isEditScreen = false,
    this.taskName = "",
    this.docId = "",
    this.description = "",
    this.selectedCategory,
     this.selectedDueDate,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}


class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> categories = [
    'Personal',
    'Work',
    'Study',
    'Health',
    'Shopping',
    'Entertainment',
    'Fitness',
    'Finance',
    'Travel',
    'Home',
    'Family',
    'Social',
    'Hobbies',
    'Food',
    'Other',
  ];
  String selectedCategory = 'Personal';
  DateTime? selectedDueDate;

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditScreen
            ? const Text(
          "Edit Task",
          style: TextStyle(color: Colors.white),
        )
            : const Text(
          "Add Task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: widget.isEditScreen == false
          ? BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is DataAddedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFieldTitle(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Task cannot be empty";
                      }
                      return null;
                    },
                    controller: taskController,
                    fieldTitle: "Title",
                    hintText: "Enter Title",
                  ),
                  const Gap2(),
                  CustomTextFieldTitle(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Description cannot be empty";
                      }
                      return null;
                    },
                    controller: descriptionController,
                    fieldTitle: "Description",
                    hintText: "Enter Task",
                  ),
                  const Gap2(),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      hintText: 'Select a category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Gap2(),
                  TextFormField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDueDate = pickedDate;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please pick a due date'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Due Date',
                      hintText: 'Select a due date',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: selectedDueDate == null
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                    controller: TextEditingController(
                      text: selectedDueDate != null
                          ? DateFormat('yyyy-MM-dd')
                          .format(selectedDueDate!)
                          : '',
                    ),
                  ),
                  const Gap2(),
                  CustomButton(
                    textColor: Colors.white,
                    isLoading: state is UserLoadingState,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedDueDate != null) {
                          String customID = const Uuid().v4();
                          context.read<UserBloc>().add(UploadTaskEvent(
                            docId: customID,
                            task: TaskModel(
                              docID: customID,
                              task: taskController.text,
                              description: descriptionController.text,
                              isCompleted: false,
                              categorie: selectedCategory,
                              dueDate: selectedDueDate != null
                                  ? DateFormat('yyyy-MM-dd').format(selectedDueDate!)
                                  : '',
                            ),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a due date'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    buttonText: "Add",
                    buttonColor: Colors.deepPurple,
                  )

                ],
              ),
            ),
          );
        },
      )
          : BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is DataAddedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFieldTitle(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Task cannot be empty";
                      }
                      return null;
                    },
                    controller: taskController,
                    fieldTitle: "Title",
                    hintText: "Enter Title",
                  ),
                  const Gap2(),
                  CustomTextFieldTitle(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Description cannot be empty";
                      }
                      return null;
                    },
                    controller: descriptionController,
                    fieldTitle: "Description",
                    hintText: "Enter Task",
                  ),
                  const Gap2(),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      hintText: 'Select a category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Gap2(),
                  TextFormField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDueDate = pickedDate;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please pick a due date'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Due Date',
                      hintText: 'Select a due date',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: selectedDueDate == null
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                    controller: TextEditingController(
                      text: selectedDueDate != null
                          ? DateFormat('yyyy-MM-dd')
                          .format(selectedDueDate!)
                          : '',
                    ),
                  ),
                  const Gap2(),
                  CustomButton(
                    textColor: Colors.white,
                    isLoading: state is UserLoadingState,
                    onTap: () async {
                      if (_formKey.currentState!.validate() &&
                          selectedDueDate != null) {
                        context.read<UserBloc>().add(UpdateTaskEvent(
                          task: TaskModel(
                            docID: widget.docId,
                            description: descriptionController.text,
                            isCompleted: false,
                            task: taskController.text,
                            categorie: selectedCategory,
                            dueDate: selectedDueDate != null
                                ? DateFormat('yyyy-MM-dd')
                                .format(selectedDueDate!)
                                : '',
                          ),
                          docId: widget.docId,
                        ));
                      }
                    },
                    buttonText: "Add",
                    buttonColor: Colors.deepPurple,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void initializeControllers() async {
    taskController = TextEditingController();
    descriptionController = TextEditingController();

    if (widget.isEditScreen) {
      taskController = TextEditingController(text: widget.taskName);
      descriptionController = TextEditingController(text: widget.description);
      selectedCategory = widget.selectedCategory ?? "Personal";
      selectedDueDate = widget.selectedDueDate;
    }
  }
}




