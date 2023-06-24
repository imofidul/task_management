import 'package:elred_todo/data/modal/task_model.dart';
import 'package:elred_todo/data/respository/task_repository.dart';
import 'package:flutter/cupertino.dart';

import '../util/app_util.dart';

class TaskProvider extends ChangeNotifier{
  List<TaskModal> tasks=[];
  int businessTaskCount=0;
  int personalTaskCount=0;
  double fractionComplete=0;
  int taskCompleted=0;
  int percentageInt=0;

  final TaskRepository _repository=TaskRepository.instance;
  TaskProvider(){
    getAllTask();
  }
  Future<void> getAllTask() async {
   tasks=await  _repository.getAllTask();
   buildUIData();
    notifyListeners();
  }
  Future<void> saveTask(TaskModal taskModal)async
  {
    await _repository.addTask(taskModal);
    getAllTask();
  }
  Future<void> updateTask(TaskModal taskModal)async
  {
    await _repository.updateTask(taskModal);
    getAllTask();
  }
  void deleteTask(TaskModal taskModal)
  {
    _repository.deleteTask(taskModal);
    getAllTask();
  }
  void buildUIData() {
     personalTaskCount = tasks
        .where((element) =>
    element.type == TaskType.personal.name)
        .toList()
        .length;
     businessTaskCount = tasks
        .where((element) =>
    element.type == TaskType.business.name)
        .toList()
        .length;
     taskCompleted = tasks
        .where((element) => element.isDone ?? false)
        .toList()
        .length;
     percentageInt = 0;
     fractionComplete = 0;
    if (tasks.isNotEmpty) {
      double percentage =
          (taskCompleted / tasks.length) * 100;
      percentageInt = percentage.toInt();

      int totalTask = tasks.length;
      int completedTask = tasks
          .where((element) => element.isDone ?? false)
          .toList()
          .length;
      if (totalTask != 0) {
        fractionComplete = completedTask / totalTask;
      }
    }
  }
}