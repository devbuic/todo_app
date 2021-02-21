import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addTodo(String todo) async {
  CollectionReference todos = FirebaseFirestore.instance.collection('Todos');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  todos.add({'text': todo, 'uid': uid});
  return;
}
