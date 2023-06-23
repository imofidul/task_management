import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_todo/shared_pref_manager.dart';
import 'package:elred_todo/task_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TaskRepository{
  static final TaskRepository _instance=TaskRepository._private();
  TaskRepository._private();
  static TaskRepository get instance=>_instance;
  Future<void> addTask(TaskModal taskModal)async
  {
   CollectionReference collectionReference=await getMyTaskCollectionReference();
   String id=collectionReference.doc().id;
   taskModal.id=id;
   await  collectionReference.doc(id).set(taskModal.toJson());
  }
  Future<void> updateTask(TaskModal taskModal)async
  {

    CollectionReference collectionReference=await getMyTaskCollectionReference();
    await collectionReference.doc(taskModal.id).update(taskModal.toJson());
  }
  Future<CollectionReference<Object?>> getMyTaskCollectionReference()async{
    String userId=await getUserId();
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    return firebaseFirestore.collection(collectionAllTask).doc(userId).collection(collectionMyTask);
  }
  Future<List<TaskModal>>getAllTask()async{
    CollectionReference collectionReference=await getMyTaskCollectionReference();
    QuerySnapshot querySnapshot=await collectionReference.get();
    List<TaskModal>tasks=[];
    for (var element in querySnapshot.docs) {
      tasks.add(TaskModal.fromJson(element.data() as Map<String,dynamic>));
    }
    return tasks;
  }
  Future<void>deleteTask(TaskModal taskModal)async{
    CollectionReference collectionReference=await getMyTaskCollectionReference();
    await collectionReference.doc(taskModal.id).delete();
  }
  Future<String> getUserId()async{
   String? userId=await  SharedPrefManager.instance.getData(SharedPrefManager.userId);
   return userId??"";
  }
  static const String collectionAllTask="allTask";
  static const String collectionMyTask="myTask";


}