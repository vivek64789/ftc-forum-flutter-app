import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:ftc_forum/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:ftc_forum/models/question.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/reply.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository {
  final firestore.FirebaseFirestore _firestore =
      firestore.FirebaseFirestore.instance;

  UserRepository();

  var currentUser = User.empty;

  Stream<firestore.DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile(
      String uid) {
    final snapshot = _firestore.collection("users").doc(uid).snapshots();

    return snapshot;
  }

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>> fetchCategories() {
    final snapshot = _firestore.collection("categories").snapshots();
    return snapshot;
  }

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>> fetchSections() {
    final snapshot = _firestore.collection("sections").snapshots();

    return snapshot;
  }

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>> fetchQuestions() {
    final snapshot = _firestore.collection("questions").snapshots();

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

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>>
      fetchTotalQuestionsByUserId(String uid) {
    final snapshot = _firestore
        .collection("questions")
        .where('uid', isEqualTo: uid)
        .snapshots();

    return snapshot;
  }

  Future<firestore.DocumentSnapshot<Map<String, dynamic>>> fetchCategoryById(
      String id) async {
    final snapshot = _firestore.collection("categories").doc(id);
    final result = await snapshot.get();
    return result;
  }

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>>
      fetchQuestionsBySectionId(String id) {
    final snapshot = _firestore
        .collection("questions")
        .where('section', isEqualTo: id)
        .snapshots();

    return snapshot;
  }

  Stream<firestore.DocumentSnapshot<Map<String, dynamic>>> fetchSectionById(
      String id) {
    final snapshot = _firestore.collection("sections").doc(id).snapshots();

    return snapshot;
  }

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>>
      fetchSectionsByCategoriesId(String id) {
    final snapshot = _firestore
        .collection("sections")
        .where('categoryId', isEqualTo: id)
        .snapshots();
    return snapshot;
  }

  Stream<firestore.QuerySnapshot<Map<String, dynamic>>> fetchRepliesOfQuestion(
      String id) {
    final snapshot = _firestore
        .collection("replies")
        .where('qid', isEqualTo: id)
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
        'description': question.jsonDescription,
        'date': question.date,
        'section': question.section!.id,
        'category': question.category!.id,
        'imageUrl': question.imageUrl,
        'upvotes': 0,
        'downvotes': 0,
        'upVotedBy': [],
        'downVotedBy': [],
        'replyCount': 0,
        'replies': [],
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updatePostQuestion({
    required Question question,
  }) async {
    try {
      await _firestore.collection("questions").doc(question.id).update({
        'title': question.title,
        'description': question.jsonDescription,
        'section': question.section!.id,
        'category': question.category!.id,
        'imageUrl': question.imageUrl,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createReply({
    required Reply reply,
  }) async {
    try {
      await _firestore.collection("replies").add({
        'uid': reply.uid,
        'qid': reply.qid,
        'date': DateTime.now(),
        'description': reply.jsonDescription,
        'upvotes': 0,
        'downvotes': 0,
        'upVotedBy': [],
        'downVotedBy': [],
      }).then((value) async {
        await _firestore.collection("questions").doc(reply.qid).update({
          'replies': firestore.FieldValue.arrayUnion([value.id]),
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateReply({
    required Reply reply,
  }) async {
    try {
      await _firestore.collection("replies").doc(reply.id).update({
        'description': reply.jsonDescription,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteComment({required String id, required String qid}) async {
    try {
      await _firestore
          .collection("replies")
          .doc(id)
          .delete()
          .then((value) async {
        //
        await _firestore.collection("questions").doc(qid).update({
          'replies': firestore.FieldValue.arrayRemove([id]),
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> upvoteQuestion(
      {required String questionId,
      required int updatedVote,
      required String uid}) async {
    try {
      await _firestore.collection("questions").doc(questionId).update({
        'upvotes': updatedVote,
      });
      await _firestore.collection("questions").doc(questionId).update({
        'upVotedBy': firestore.FieldValue.arrayUnion([uid]),
      });
    } catch (e) {}
  }

  Future<void> deleteQuestion({required String questionId}) async {
    print(questionId);
    try {
      await _firestore.collection("questions").doc(questionId).delete();
    } catch (e) {}
  }

  Future<void> downvoteQuestion(
      {required String questionId,
      required int updatedVote,
      required String uid}) async {
    try {
      await _firestore.collection("questions").doc(questionId).update({
        'downvotes': updatedVote,
      });
      await _firestore.collection("questions").doc(questionId).update({
        'downVotedBy': firestore.FieldValue.arrayUnion([uid]),
      });
    } catch (e) {}
  }

  Future<void> upvoteReply(
      {required String replyId,
      required int updatedVote,
      required String uid}) async {
    try {
      await _firestore.collection("replies").doc(replyId).update({
        'upvotes': updatedVote,
      });

      await _firestore.collection("replies").doc(replyId).update({
        'upVotedBy': firestore.FieldValue.arrayUnion([uid]),
      });
    } catch (e) {}
  }

  Future<void> decreaseUpvoteReply(
      {required String replyId,
      required int updatedVote,
      required String uid}) async {
    try {
      // decreasing upvotes
      await _firestore.collection("replies").doc(replyId).update({
        'upvotes': updatedVote,
      });

      // removing uid from upVotedBy

      await _firestore.collection("replies").doc(replyId).update({
        'upVotedBy': firestore.FieldValue.arrayRemove([uid]),
      });
    } catch (e) {}
  }

  Future<void> decreaseUpvoteQuestion(
      {required String questionId,
      required int updatedVote,
      required String uid}) async {
    try {
      // decreasing upvotes
      await _firestore.collection("questions").doc(questionId).update({
        'upvotes': updatedVote,
      });

      // removing uid from upVotedBy

      await _firestore.collection("questions").doc(questionId).update({
        'upVotedBy': firestore.FieldValue.arrayRemove([uid]),
      });
    } catch (e) {}
  }

  Future<void> downvoteReply(
      {required String replyId,
      required int updatedVote,
      required String uid}) async {
    try {
      await _firestore.collection("replies").doc(replyId).update({
        'downvotes': updatedVote,
      });
      await _firestore.collection("replies").doc(replyId).update({
        'downVotedBy': firestore.FieldValue.arrayUnion([uid]),
      });
    } catch (e) {}
  }

  Future<void> decreaseDownvoteReply(
      {required String replyId,
      required int updatedVote,
      required String uid}) async {
    try {
      await _firestore.collection("replies").doc(replyId).update({
        'downvotes': updatedVote,
      });
      await _firestore.collection("replies").doc(replyId).update({
        'downVotedBy': firestore.FieldValue.arrayRemove([uid]),
      });
    } catch (e) {}
  }

  Future<void> decreaseDownvoteQuestion(
      {required String questionId,
      required int updatedVote,
      required String uid}) async {
    try {
      await _firestore.collection("questions").doc(questionId).update({
        'downvotes': updatedVote,
      });
      await _firestore.collection("questions").doc(questionId).update({
        'downVotedBy': firestore.FieldValue.arrayRemove([uid]),
      });
    } catch (e) {}
  }

  Future<int> getQuestionUpvotes(String questionId) async {
    final snapshot =
        await _firestore.collection("questions").doc(questionId).get();
    return snapshot.data()!['upvotes'];
  }

  Future<int> getQuestionDownvotes(String questionId) async {
    final snapshot =
        await _firestore.collection("questions").doc(questionId).get();
    return snapshot.data()!['downvotes'];
  }

  Future<int> getReplyUpvotes(String replyId) async {
    final snapshot = await _firestore.collection("replies").doc(replyId).get();
    return snapshot.data()!['upvotes'];
  }

  Future<int> getReplyDownvotes(String replyId) async {
    final snapshot = await _firestore.collection("replies").doc(replyId).get();
    return snapshot.data()!['downvotes'];
  }

  Future<User> fetchUserById(String id) async {
    final snapshot = await _firestore.collection("users").doc(id).get();

    return User.fromJson(snapshot.data());
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

  Future<void> updateProfileImageUrl({
    required String uid,
    required String imageUrl,
  }) async {
    try {
      await _firestore.collection("users").doc(uid).update({
        'photo': imageUrl,
      });
    } catch (e) {}
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
