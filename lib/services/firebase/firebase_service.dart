import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sleeping_app/packages.dart';

class FirebaseService {
  getUserData({required String docId}) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(docId).get();
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    firebaseController.userName.value = userData['name'];
    firebaseController.userEmail.value = userData['email'];
    firebaseController.accountType.value = userData['accountType'];
    firebaseController.userEmail.value = userData['userId'];
    Get.log(
        'log: ${userData['name']} , ${userData['email']} , ${userData['accountType']}, ${userData['userId']}');
  }
}
