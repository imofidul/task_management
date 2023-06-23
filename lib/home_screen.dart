import 'package:elred_todo/add_task_screen.dart';
import 'package:elred_todo/app_color.dart';
import 'package:elred_todo/app_util.dart';
import 'package:elred_todo/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        child: Icon(Icons.add,color: AppColor.white,),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddOrUpdateTaskScreen()));
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
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned:true,
              snap: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title:  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text("Your\nThings",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        Consumer<TaskProvider>(builder: (_,provider,child){
                          int personalCount=provider.tasks.where((element) => element.type==TaskType.personal.name).toList().length;
                          return Text("$personalCount\n personal",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ));
                        },),
                        Consumer<TaskProvider>(builder: (_,provider,child){
                          int personalCount=provider.tasks.where((element) => element.type==TaskType.business.name).toList().length;
                          return  Text("$personalCount\n business",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ));
                        },),


                      ],
                    ),
                  ),
                  background: Image.network(
                    "https://picsum.photos/200",
                    fit: BoxFit.cover,
                  )),
              bottom: TabBar(
                labelColor: AppColor.white,
                unselectedLabelColor: AppColor.headingColor,
                tabs: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child:  Tab(text: AppUtil.getFormattedDate(DateTime.now())),),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Tab(text: "68% done")),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  Consumer<TaskProvider>(builder: (_, taskProvider, child) {
                    if (taskProvider.tasks.isEmpty) {
                      return const Text("No task found");
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0,top: 16),
                          child: Text("INBOX",style: TextStyle(color: AppColor.textColor),),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (_, indax) => GestureDetector(
                              child: ListTile(
                                title:
                                    Text("${taskProvider.tasks[indax].name}",style: TextStyle(color: AppColor.headingColor),),
                                subtitle: Text(
                                    "${taskProvider.tasks[indax].description}",style: TextStyle(color: AppColor.subHeadingColor)),
                                leading: Icon(Icons.task),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddOrUpdateTaskScreen(
                                      taskModal: taskProvider.tasks[indax],
                                    ),
                                  ),
                                );
                              },
                            ),
                            itemCount: taskProvider.tasks.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                          ),
                        )
                      ],
                    );
                  }),
                  Center(child: Text('Tab 2 Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
