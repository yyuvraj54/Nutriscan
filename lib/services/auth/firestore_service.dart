import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'users';

  Future<void> addUser(UserModel user) async {
    try {
      // Check if the user already exists
      final existingUser = await getUser(user.id);
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

  Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await _firestore.collection(_collectionName).doc(userId).get();

      if (userSnapshot.exists) {
        return UserModel.fromJson(userSnapshot.data()!);
      } else {
        print('User with ID $userId not found');
        return null;
      }
    } catch (e) {
      print('Error getting user: $e');
      throw Exception('Failed to get user');
    }
  }
}
