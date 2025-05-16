import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class FirestoreService {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(TaskModel task) async {
    await tasksCollection.doc(task.id.toString()).set(task.toJson());
  }

  Stream<List<TaskModel>> getTasksStream() {
    return tasksCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>)).toList());
  }
}