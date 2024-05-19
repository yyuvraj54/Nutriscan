import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';


class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'users';

  // abhishek!!! yaha se data upload hoga firestore mai tik h..
  Future<void> addUser(UserModel user) async {
    try {
      await _firestore.collection(_collectionName).doc(user.id).set(user.toJson());
    } catch (e) {
      print('Error adding user: $e');
      throw Exception('Failed to add user');
    }
  }

  //abhishek! yaha se data milega firestore ka tik h...
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
