import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_todo/task_model.dart';

class TaskRepository{
  static final TaskRepository _instance=TaskRepository._private();
  TaskRepository._private();
  static TaskRepository get instance=>_instance;
  Future<void> addTask(TaskModal taskModal)async
  {
   CollectionReference collectionReference=getMyTaskCollectionReference("nvbhbv");
   String id=collectionReference.doc().id;
   taskModal.id=id;
   await  collectionReference.doc(id).set(taskModal.toJson());
  }
  Future<void> updateTask(TaskModal taskModal)async
  {
    CollectionReference collectionReference=getMyTaskCollectionReference("nvbhbv");
    await collectionReference.doc(taskModal.id).update(taskModal.toJson());
  }
  CollectionReference getMyTaskCollectionReference(String userId){
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    return firebaseFirestore.collection("tasks").doc(userId).collection("myTask");
  }
  Future<List<TaskModal>>getAllTask()async{
    CollectionReference collectionReference=getMyTaskCollectionReference("nvbhbv");
    QuerySnapshot querySnapshot=await collectionReference.get();
    List<TaskModal>tasks=[];
    querySnapshot.docs.forEach((element) {
      tasks.add(TaskModal.fromJson(element.data() as Map<String,dynamic>));
    });
    return tasks;
  }
  Future<void>deleteTask(TaskModal taskModal)async{
    CollectionReference collectionReference=getMyTaskCollectionReference("nvbhbv");
    await collectionReference.doc(taskModal.id).delete();
  }
}