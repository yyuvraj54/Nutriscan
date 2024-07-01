import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutriscan/utils/utils.dart';
import '../../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'users';

  Future<void> addUser(BuildContext context,UserModel user) async {
    try {
      // Check if the user already exists
      final existingUser = await getUser(context,user!.id);
      if (existingUser == null) {
        // User doesn't exist, add them to Firestore
        await _firestore.collection(_collectionName).doc(user.id).set(user.toJson());
      } else {
        // User already exists, do nothing
        print('User with ID ${user.id} already exists');
      }
    } catch (e) {
      print('Error adding user: $e');
      throw Exception('Failed to add user');
    }
  }

  Future<UserModel?> getUser(BuildContext context, String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await _firestore.collection(_collectionName).doc(userId).get();

      if (userSnapshot.exists) {
        return UserModel.fromJson(userSnapshot.data()!);
      } else {
        showSnakBar(context,'User with ID $userId not found');
        return null;
      }
    } catch (e) {
      print('Error getting user: $e');
      throw Exception('Failed to get user');
    }
  }
  Future<bool> checkUserDataExists(String userId) async {
    try {
      DocumentSnapshot userDataSnapshot = await _firestore.collection('users').doc(userId).get();
      return userDataSnapshot.exists;
    } catch (e) {
      print('Error checking user data: $e');
      return false;
    }
  }
}
