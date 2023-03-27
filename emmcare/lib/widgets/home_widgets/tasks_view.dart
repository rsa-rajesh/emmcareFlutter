import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../../view_model/tasks_view_view_model.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  TasksViewViewModel tasksViewViewModel = TasksViewViewModel();
  @override
  void initState() {
    tasksViewViewModel.fetchTasksListApi();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return refresh();
        },
        child: ChangeNotifierProvider<TasksViewViewModel>(
          create: (BuildContext context) => tasksViewViewModel,
          child: Consumer<TasksViewViewModel>(
            builder: (context, value, _) {
              switch (value.tasksList.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case Status.ERROR:
                  return AlertDialog(
                    icon: Icon(Icons.error_rounded, size: 30),
                    title: Text(
                      // value.tasksList.message.toString(),
                      "Oops Something Went Wrong!",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              refresh();
                            },
                            child: Text(
                              'Refresh',
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: StadiumBorder(),
                            ),
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: Text('Abort'),
                          ),
                        ],
                      )
                    ],
                  );

                case Status.COMPLETED:
                  if (value.tasksList.data!.tasks!.length == 0) {
                    return Center(
                        child: Text(
                      "No Tasks!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ));
                  } else {
                    return ListView.builder(
                      itemCount: value.tasksList.data!.tasks!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Text(value.tasksList.data!.tasks![index].task
                              .toString()),
                        );
                      },
                    );
                  }

                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> refresh() async {
    setState(() {
      tasksViewViewModel.fetchTasksListApi();
    });
  }
}
