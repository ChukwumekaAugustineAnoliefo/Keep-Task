import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:my_todo_app/models/task_model.dart';
// import 'package:my_todo_app/screens/add_task_screen.dart';
// import 'package:my_todo_app/screens/login_screen.dart';
// import 'package:my_todo_app/screens/profile_screen.dart';
// import 'package:my_todo_app/screens/update_task_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:keep_task/config/routes.dart';
import 'package:keep_task/config/themes.dart';
import 'package:keep_task/firebasemodels/task_models.dart';
import 'package:keep_task/screens/update_task_screen.dart';
import 'package:ndialog/ndialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:keep_task/constants/color_constants.dart';
import 'package:keep_task/firebasemodels/user_models.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  double minuteAngle = 0;
  double secondsAngle = 0;
  double hoursAngle = 0;
  late Timer timer;
  User? user;
  int selectedValue = 0;
  DatabaseReference? taskRef;
  File? imageFile;
  bool showLocalFile = false;
  DatabaseReference? userRef;
  var taskController = TextEditingController();
  @override
  void initState() {
    timer = Timer.periodic(Duration(microseconds: 500), (timer) {
      final now = DateTime.now();

      setState(() {
        secondsAngle = (pi / 30) * now.second;
        minuteAngle = pi / 30 * now.minute;
        hoursAngle = (pi / 6 * now.hour) + (pi / 45 * minuteAngle);
      });
    });
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      taskRef = FirebaseDatabase.instance.ref().child('tasks').child(user!.uid);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Container(
              width: 385,
              height: 200,
              color: primaryColors,
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: 311,
                    child: Column(
                      children: [
                        Text('Log out'),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text('Confirmation !!!'),
                                      content:
                                          Text('Are you sure to Log Out ? '),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();

                                            FirebaseAuth.instance.signOut();
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    RouteManager.loginPage);
                                          },
                                          child: Text('Yes'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.logout)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Image.asset('assets/images/topclip.png'),
                  ),
                  Positioned(
                    top: 0,
                    child: Image.asset('assets/images/rtopclip.png'),
                  ),
                  Positioned(
                    top: 58,
                    left: 138,
                    child: Row(
                      children: [
                        // CircleAvatar(
                        //     radius: 50,
                        //     backgroundImage: showLocalFile
                        //         ? FileImage(imageFile!) as ImageProvider
                        //         : userModel!.profileImage == ''
                        //             ? const NetworkImage(
                        //                 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrQoGh518HulzrSYOTee8UO517D_j6h4AYQ&usqp=CAU')
                        //             : NetworkImage(userModel!.profileImage)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Container(
              child: Stack(children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  elevation: 30,
                  child: CircleAvatar(
                      radius: 170,
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/images/trclocks.png')),
                ),

                //seconds
                Transform.rotate(
                  child: Container(
                    child: Container(
                      height: 70,
                      width: 2,
                      decoration: BoxDecoration(
                        color: hyperTextColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // alignment: Alignment(1, 1),
                    ),
                    alignment: Alignment(0, -0.35),
                  ),
                  angle: secondsAngle,
                ),

                //minutes
                Transform.rotate(
                  child: Container(
                    child: Container(
                      height: 95,
                      width: 5,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // alignment: Alignment(1, 1),
                    ),
                    alignment: Alignment(0, -0.35),
                  ),
                  angle: minuteAngle,
                ),
                //hours
                Transform.rotate(
                  child: Container(
                    child: Container(
                      height: 70,
                      width: 7,
                      decoration: BoxDecoration(
                        color: btnColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // alignment: Alignment(1, 1),
                    ),
                    alignment: Alignment(0, -0.2),
                  ),
                  angle: hoursAngle,
                ),
                //dots
                Container(
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    // alignment: Alignment(1, 1),
                  ),
                  alignment: Alignment(0, 0),
                ),
              ]),
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 8),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
            // color: Color.fromRGBO(8, 25, 35, 1),
            alignment: Alignment(0, 0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                        'Task List')),
                Padding(
                    padding: const EdgeInsets.only(
                      top: 26,
                    ),
                    child: SizedBox(
                      height: 289,
                      child: Card(
                        elevation: 40,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Daily Task'),
                              trailing: IconButton(
                                color: primaryColors,
                                onPressed: () {
                                  bottomSheet();
                                },
                                icon: Icon(Icons.add_circle_outline, size: 22),
                              ),
                            ),
                            Flexible(
                              child: StreamBuilder<Object>(
                                  stream:
                                      taskRef != null ? taskRef!.onValue : null,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        !snapshot.hasError) {
                                      var event =
                                          snapshot.data as DatabaseEvent;

                                      var snapshot2 = event.snapshot.value;
                                      if (snapshot2 == null) {
                                        return const Center(
                                          child: Text('No Tasks Added Yet'),
                                        );
                                      }
                                      Map<String, dynamic> map =
                                          Map<String, dynamic>.from(
                                              snapshot2 as dynamic);

                                      var tasks = <TaskModel>[];

                                      for (var taskMap in map.values) {
                                        TaskModel taskModel = TaskModel.fromMap(
                                            Map<String, dynamic>.from(taskMap));

                                        tasks.add(taskModel);
                                      }

                                      return ListView.builder(
                                          itemCount: tasks.length,
                                          itemBuilder: (context, index) {
                                            TaskModel task = tasks[index];
                                            return Container(
                                              padding: EdgeInsets.all(10),
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(task.taskName),
                                                  Text(getHumanReadableDate(
                                                      task.dt)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (ctx) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Confirmation !!!'),
                                                                  content:
                                                                      const Text(
                                                                          'Are you sure to delete ? '),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(ctx)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            'No')),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          if (taskRef !=
                                                                              null) {
                                                                            await taskRef!.child(task.taskId).remove();
                                                                          }

                                                                          Navigator.of(ctx)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            'Yes')),
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.edit),
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return UpdateTaskScreen(
                                                                task: task);
                                                          }));
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  String getHumanReadableDate(int dt) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt);

    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: taskController,
                  decoration: const InputDecoration(hintText: 'Task Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String taskName = taskController.text.trim();

                    if (taskName.isEmpty) {
                      Fluttertoast.showToast(msg: 'Please provide task name');
                      return;
                    }

                    User? user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      String uid = user.uid;
                      int dt = DateTime.now().millisecondsSinceEpoch;

                      DatabaseReference taskRef = FirebaseDatabase.instance
                          .ref()
                          .child('tasks')
                          .child(uid);

                      String taskId = taskRef.push().key ?? '';

                      await taskRef.child(taskId).set({
                        'dt': dt,
                        'taskName': taskName,
                        'taskId': taskId,
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        });
  }
}
