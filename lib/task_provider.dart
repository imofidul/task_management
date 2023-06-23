import 'package:elred_todo/task_model.dart';
import 'package:elred_todo/task_repository.dart';
import 'package:flutter/cupertino.dart';

class TaskProvider extends ChangeNotifier{
  List<TaskModal> tasks=[];
  final TaskRepository _repository=TaskRepository.instance;
  TaskProvider(){
    getAllTask();
  }
  Future<void> getAllTask() async {
   tasks=await  _repository.getAllTask();
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
}