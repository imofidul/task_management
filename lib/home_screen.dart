import 'package:elred_todo/add_task_screen.dart';
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
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddOrUpdateTaskScreen()));
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            Text("Logout"),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("Your\nThings",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        Text("13\n personal",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            )),
                        Text("13\n business",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ))
                      ],
                    ),
                  ),
                  background: Image.network(
                    "https://picsum.photos/200",
                    fit: BoxFit.cover,
                  )),
              bottom: TabBar(
                tabs: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Tab(text: "Sept 5,2015")),
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
                      return Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Inbox"),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (_, indax) => GestureDetector(
                              child: ListTile(
                                title:
                                    Text("${taskProvider.tasks[indax].name}"),
                                subtitle: Text(
                                    "${taskProvider.tasks[indax].description}"),
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
