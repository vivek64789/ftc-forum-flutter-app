import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ftc_forum/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
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
      streamSectionsByCategoryId(String id) {
    final snapshot = _firestore
        .collection("sections")
        .where('categoryId', isEqualTo: id)
        .snapshots();

    return snapshot;
  }

  Future<firestore.Query<Map<String, dynamic>>> fetchSectionsByCategoryId(
      String id) async {
    final data =
        _firestore.collection("sections").where('categoryId', isEqualTo: id);

    return data;
  }

  Future<void> createCategory({
    required String categoryName,
  }) async {
    try {
      await _firestore.collection("categories").add({
        'categoryName': categoryName,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateCategory({
    required String id,
    required String categoryName,
  }) async {
    try {
      await _firestore.collection("categories").doc(id).set({
        "categoryName": categoryName,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteCategory({
    required String id,
  }) async {
    try {
      await _firestore.collection("categories").doc(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createSection({
    required QuestionCategory category,
    required String sectionName,
    required String imageUrl,
  }) async {
    try {
      await _firestore.collection("sections").add({
        'sectionName': sectionName,
        'categoryId': category.id,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateSection({
    required String id,
    required String sectionName,
    required QuestionCategory category,
    required String imageUrl,
  }) async {
    try {
      await _firestore.collection("sections").doc(id).set({
        "sectionName": sectionName,
        "categoryId": category.id,
        "imageUrl": imageUrl,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteSection({
    required String id,
  }) async {
    try {
      await _firestore.collection("sections").doc(id).delete();
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
