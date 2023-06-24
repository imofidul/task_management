import 'package:elred_todo/add_task_screen.dart';
import 'package:elred_todo/app_color.dart';
import 'package:elred_todo/app_util.dart';
import 'package:elred_todo/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
  return  Consumer<TaskProvider>(builder: (_,provider,child){
    int personalTaskCount = provider.tasks
        .where((element) =>
    element.type == TaskType.personal.name)
        .toList()
        .length;
    int businessTaskCount = provider.tasks
        .where((element) =>
    element.type == TaskType.business.name)
        .toList()
        .length;
    int taskCompleted = provider.tasks
        .where((element) => element.isDone??false)
        .toList()
        .length;
    int percentageInt=0;
    double fractionComplete=0;
    if(provider.tasks.isNotEmpty) {
      double percentage =
          (taskCompleted / provider.tasks.length) * 100;
      percentageInt = percentage.toInt();

      int totalTask=provider.tasks.length;
      int completedTask=provider.tasks.where((element) => element.isDone??false).toList().length;
      if(totalTask!=0)
      {
        fractionComplete=completedTask/totalTask;
      }
    }
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primary,
          child: Icon(
            Icons.add,
            color: AppColor.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddOrUpdateTaskScreen()));
          },
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: const [
                Text("Logout"),
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text("Your\nThings",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            Consumer<TaskProvider>(
                              builder: (_, provider, child) {
                                int personalCount = provider.tasks
                                    .where((element) =>
                                element.type == TaskType.personal.name)
                                    .toList()
                                    .length;
                                return Text("$personalCount\n personal",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ));
                              },
                            ),
                            Text("$businessTaskCount\n business",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Text(AppUtil.getFormattedDate(DateTime.now()),style: TextStyle(fontSize: 12),)),

                            Expanded(child: Text( "$percentageInt% done",style: const TextStyle(fontSize: 12))),
                          ],
                        )
                      ],
                    ),
                  ),
                  background: Image.network(
                    "https://picsum.photos/200",
                    fit: BoxFit.cover,
                  )),
            ),
            SliverFillRemaining(
              child:provider.tasks.isEmpty?Text("No task found"):Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  LinearPercentIndicator(percent:fractionComplete ,),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16),
                    child: Text(
                      "INBOX",
                      style: TextStyle(color: AppColor.textColor),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) => GestureDetector(
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                "${provider.tasks[index].name}",
                                style: TextStyle(
                                    color: AppColor.headingColor),
                              ),
                              const Spacer(),
                            ],
                          ),
                          subtitle: Text(
                              "${provider.tasks[index].description}",
                              style: TextStyle(
                                  color: AppColor.subHeadingColor)),
                          leading: const Icon(Icons.task),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddOrUpdateTaskScreen(
                                taskModal: provider.tasks[index],
                              ),
                            ),
                          );
                        },
                      ),
                      itemCount: provider.tasks.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text("Completed "),
                        Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("$taskCompleted",style: TextStyle(color: AppColor.white),),
                            ))
                      ],
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      );
    },);

  }
}
