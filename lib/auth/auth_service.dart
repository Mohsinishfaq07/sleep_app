import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sleeping_app/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:sleeping_app/common_widgets/dialogue_boxes.dart';
import 'package:sleeping_app/packages.dart';

class AuthService {
  Future<bool> checkEmailExists(String email) async {
    try {
      final collection = FirebaseFirestore.instance.collection('Users');

      final querySnapshot =
          await collection.where('email', isEqualTo: email).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking email existence: $e');
      return false; // Return false if there's an error
    }
  }

  loginUser({
    required String userEmail,
    required String userPass,
  }) async {
    authController.showLoading.value = true;
    showProcessingDialog(title: 'Login...');
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPass,
      );

      User? user = credential.user;

      if (user == null) {
        throw Exception("User is null after sign in.");
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(user.uid).get();

      if (!userDoc.exists) {
        throw Exception("User document not found.");
      }

      // Extract user data
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      firebaseController.userName.value = userData['name'];
      firebaseController.userEmail.value = userData['email'];
      firebaseController.accountType.value = userData['accountType'];
      firebaseController.userEmail.value = userData['userId'];

      Get.log(
          'log: ${userData['name']} , ${userData['email']} , ${userData['accountType']}, ${userData['userId']}');

      // Set loading to false and navigate to the home screen
      authController.showLoading.value = false;
      authController.userLoggedIn.value = true;
      Get.log('user logged in :${authController.userLoggedIn.value}');
      Get.back();
      Get.off(() => BottomNavigationBarScreen());
    } on FirebaseAuthException catch (e) {
      Get.back();
      // Handle login failure
      authController.showLoading.value = false;
      commonFunctions.showSnackBar(
        title: 'Alert',
        message: 'Check your email or password.',
        backgroundColor: Colors.grey,
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
      );
      Get.log("FirebaseAuthException: ${e.message}");
    } catch (e) {
      Get.back();
      // Handle any other exceptions
      authController.showLoading.value = false;
      Get.log("Exception: ${e.toString()}");
      commonFunctions.showSnackBar(
        title: 'Error',
        message: 'An unexpected error occurred.',
        backgroundColor: Colors.grey,
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
      );
    }
  }

  createUser(
      {required String userEmail,
      required String userPass,
      required String userName}) async {
    Get.log('starting creating function');

    if (userEmail.isEmpty) {
      commonFunctions.shoeSnackMessage(message: 'Email is Empty');
      return;
    }
    if (!userEmail.contains('@')) {
      commonFunctions.shoeSnackMessage(message: 'Email is invalid');
      return;
    }
    if (!userEmail.contains('.com')) {
      commonFunctions.shoeSnackMessage(message: 'Email is invalid');
      return;
    }
    if (userPass.isEmpty) {
      commonFunctions.shoeSnackMessage(message: 'Password is Empty');
      return;
    }
    if (userPass.length < 6) {
      commonFunctions.shoeSnackMessage(
          message: 'Password cannot be less than 6 digits');
      return;
    }
    if (userName.isEmpty) {
      commonFunctions.shoeSnackMessage(message: 'Username is empty');
      return;
    }
    showProcessingDialog(title: 'Sin up...');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPass,
      );

      Get.back();
      await storeUserData(
          name: userName,
          email: userEmail,
          pass: userPass,
          accountType: 'email');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        commonFunctions.showSnackBar(
            title: 'Alert',
            message: 'The password provided is too weak.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
        Get.back();
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.back();
        commonFunctions.showSnackBar(
            title: 'Alert',
            message: 'The account already exists for that email.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      }
    } catch (e) {
      Get.back();
      authController.showLoading.value = false;
      print(e);
    }
  }

  forgotPassword({required userEmail}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    authController.showLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.log('log:Password reset email sent');
      commonFunctions.showSnackBar(
          title: 'Alert',
          message: 'Password reset email sent.',
          backgroundColor: Colors.grey,
          colorText: Colors.black,
          duration: const Duration(seconds: 2));
      authController.showLoading.value = false;
      Navigator.pop(Get.context!);
    } catch (e) {
      Get.log('log:Failed to send password reset email');
      commonFunctions.showSnackBar(
          title: 'Alert',
          message: 'Failed to send password reset email.',
          backgroundColor: Colors.grey,
          colorText: Colors.black,
          duration: const Duration(seconds: 2));
      authController.showLoading.value = false;
    }
  }

  storeUserData(
      {required String name,
      required String email,
      required String pass,
      required String accountType}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;

      try {
        // Create a new document with userId as the document ID in the 'Users' collection
        await _firestore.collection('Users').doc(userId).set({
          'name': name,
          'email': email,
          'userId': userId, // Storing the userId explicitly if needed
          'createdAt':
              FieldValue.serverTimestamp(), // Optional: Store creation time
          'accountType': accountType,
          'gender': authController.userGender.value,
          'age': authController.userAge.value
        });
        authController.showLoading.value = false;
        Get.log('log: User data stored successfully in Firestore');
        authController.userLoggedIn.value = true;
        Get.log('user logged in :${authController.userLoggedIn.value}');
        Get.off(BottomNavigationBarScreen());
      } catch (e) {
        authController.showLoading.value = false;
        Get.log('log: Failed to store user data: $e');
        deleteUserAccount(password: pass);
        commonFunctions.showSnackBar(
            title: 'Alert',
            message: 'Please try again after some time.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      }
    } else {
      authController.showLoading.value = false;
      Get.log('log: No user is logged in');

      commonFunctions.showSnackBar(
          title: 'Alert',
          message: 'Please try again after some time.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2));
    }
  }

  updateUserData({
    required String name,
    required String email,
    required String accountType,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;

      try {
        // Create a new document with userId as the document ID in the 'Users' collection
        await _firestore.collection('Users').doc(userId).update({
          'name': name,
          'email': email,
          'userId': userId, // Storing the userId explicitly if needed
          'createdAt':
              FieldValue.serverTimestamp(), // Optional: Store creation time
          'accountType': accountType,
          'gender': authController.userGender.value,
          'age': authController.userAge.value
        });
        authController.showLoading.value = false;
        Get.log('log: User data stored successfully in Firestore');
        Get.off(BottomNavigationBarScreen());
      } catch (e) {
        authController.showLoading.value = false;
        Get.log('log: Failed to store user data: $e');
      }
    } else {
      authController.showLoading.value = false;
      Get.log('log: No user is logged in');

      commonFunctions.showSnackBar(
          title: 'Alert',
          message: 'Please try again after some time.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2));
    }
  }

  logout() async {
    authController.userLoggedIn.value = false;
    Get.log('user logged in :${authController.userLoggedIn.value}');
    await FirebaseAuth.instance.signOut();

    Get.off(const SplashScreenView());
  }

  deleteUserAccount({required String password}) async {
    authController.showLoading.value = true;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        String userId = user.uid;
        await _firestore.collection('Users').doc(userId).delete();
        final cred = EmailAuthProvider.credential(
            email: user.email!, password: password);
        await user.reauthenticateWithCredential(cred);
        await user.delete();
        Get.log('log:User account deleted successfully');
        commonFunctions.showSnackBar(
            title: 'Alert',
            message: 'Account deleted successfully.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
        authController.showLoading.value = false;
        Get.off(() => const SplashScreenView());
      } catch (e) {
        Get.log('log:Failed to delete user account:$e');
        commonFunctions.showSnackBar(
            title: 'Alert',
            message: 'Failed to delete user account.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
        authController.showLoading.value = false;
      }
    } else {
      authController.showLoading.value = false;
      Get.log('log:No user is logged in');
    }
  }

  updatePassword(String currentPassword, String newPassword) async {
    //Create an instance of the current user.
    var user = await FirebaseAuth.instance.currentUser!;
    //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.

    final cred = await EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        commonFunctions.showSnackBar(
            title: 'Alert',
            message: 'Password updated.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      }).catchError((error) {
        print(error);
        commonFunctions.showSnackBar(
            title: 'Alert',
            message: 'Password update Failed.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2));
      });
    }).catchError((err) {
      print(err);
      commonFunctions.showSnackBar(
          title: 'Alert',
          message: 'Password update Failed.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2));
    });
  }

  // google sign in
  Future<void> signUpWithGoogle() async {
    showProcessingDialog(title: 'Login...');
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        Get.back();
        print('Google sign-in cancelled');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      bool emailFound = await checkEmailExists(googleUser.email);
      if (emailFound) {
        Navigator.pop(Get.context!);
        Get.snackbar('Alert', 'account already exist',
            backgroundColor: Colors.grey);
        return;
      }

      // Reference to Firestore collection
      final usersCollection = FirebaseFirestore.instance.collection('Users');

      // Check if a user with this email already exists in the Firestore Users collection
      final querySnapshot = await usersCollection
          .where('email', isEqualTo: googleUser.email)
          .get();
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      if (querySnapshot.docs.isNotEmpty) {
        Get.log('log: User with email ${googleUser.email} already exists.');
        updateUserData(
          name: user!.displayName!,
          email: user.email!,
          accountType: 'google',
        );
        DocumentSnapshot userDoc =
            await _firestore.collection('Users').doc(user!.uid).get();
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        firebaseController.userName.value = userData['name'];
        firebaseController.userEmail.value = userData['email'];
        firebaseController.accountType.value = userData['accountType'];
        firebaseController.userEmail.value = userData['userId'];
        Get.back();
        Get.log(
            'log: ${userData['name']} , ${userData['email']} , ${userData['accountType']}, ${userData['userId']}');
        authController.userLoggedIn.value = true;
        Get.log('user logged in :${authController.userLoggedIn.value}');
        Get.off(() => BottomNavigationBarScreen());
      } else {
        if (user != null) {
          DocumentSnapshot userDoc =
              await _firestore.collection('Users').doc(user.uid).get();
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          storeUserData(
              name: userData['name'],
              email: user.email!,
              pass: user.uid,
              accountType: 'google');

          firebaseController.userName.value = userData['name'];
          firebaseController.userEmail.value = userData['email'];
          firebaseController.accountType.value = userData['accountType'];
          firebaseController.userEmail.value = userData['userId'];
          Get.back();
          Get.log(
              'log: ${userData['name']} , ${userData['email']} , ${userData['accountType']}, ${userData['userId']}');
          Get.off(() => BottomNavigationBarScreen());
          Get.log(
              'log: New user account created and data stored in Firestore.');
        }
      }
    } catch (e) {
      Get.back();
      Get.log('log: Error during Google Sign-In: $e');
    }
  }

  Future<void> deleteGoogleAccount() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Reauthenticate the user to make sure they are recently logged in
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Reauthenticate the user
        await user.reauthenticateWithCredential(credential);

        // Delete the user's Firestore document (optional)
        final usersCollection = FirebaseFirestore.instance.collection('Users');
        await usersCollection.doc(user.uid).delete();
        print('User data deleted from Firestore.');

        // Delete the user's Firebase Auth account
        await user.delete();
        Get.off(() => const SplashScreenView());
        print('User account deleted successfully from Firebase Auth.');
      } catch (e) {
        print('Failed to delete account: $e');
      }
    } else {
      print('No user is currently logged in.');
    }
  }

  signOutGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();

      await GoogleSignIn().signOut();
      authController.userLoggedIn.value = false;
      Get.log('user logged in :${authController.userLoggedIn.value}');
      Get.off(() => const SplashScreenView());
      print('User signed out successfully from Google and Firebase.');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // login with google

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        Get.log('Google sign-in cancelled');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      bool emailFound = await checkEmailExists(googleUser.email);

      if (emailFound) {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;
        if (user != null) {
          authController.userLoggedIn.value = true;
          Get.log('user logged in :${authController.userLoggedIn.value}');
          Get.off(() => BottomNavigationBarScreen());
        }
      } else {
        Get.snackbar('Alert', 'No account found', backgroundColor: Colors.grey);
      }
    } catch (e) {
      Get.log('log: Error during Google Sign-In: $e');
    }
  }
}
