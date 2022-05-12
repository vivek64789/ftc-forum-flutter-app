import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ftc_forum/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:ftc_forum/models/question.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository {
  final firestore.FirebaseFirestore _firestore =
      firestore.FirebaseFirestore.instance;

  UserRepository();

  var currentUser = User.empty;

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>> fetchCategories() {
    final snapshot = _firestore.collection("categories").snapshots();
    return snapshot;
  }

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>> fetchSections() {
    final snapshot = _firestore.collection("sections").snapshots();

    return snapshot;
  }

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>>
      fetchSectionsByCategoryId(String id) {
    final snapshot = _firestore
        .collection("sections")
        .where('categoryId', isEqualTo: id)
        .snapshots();

    return snapshot;
  }

 
  Future<void> createQuestion({
    required Question question,
  }) async {
    try {
      await _firestore.collection("questions").add({
        'uid': question.uid,
        'title': question.title,
        'description': question.description,
        'date': question.date,
        'section': question.section!.id,
        'category': question.category!.id,
        'imageUrl': question.imageUrl,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> uploadImage({required String id, required String name}) async {
    File imageFile;
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return "";
    }
    imageFile = File(pickedFile.path);
    print("Came here $id $name");

    String fileName = id + name + getRandString(20);
    var uploadTask = await FirebaseStorage.instance
        .ref()
        .child("uploads/$fileName")
        .putFile(imageFile);

    return uploadTask.ref.getDownloadURL().then((value) => value);
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
