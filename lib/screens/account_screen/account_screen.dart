import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleeping_app/common_widgets/dialogue_boxes.dart';
import 'package:sleeping_app/custom_widgets/custom_bottom_sheet.dart';
import 'package:sleeping_app/packages.dart';
import 'package:sleeping_app/screens/reminders/set_reminders.dart';
import 'package:sleeping_app/screens/reminders/view_reminders.dart';
import 'package:sleeping_app/screens/mood_display_screen/mood_display_Screen.dart';
import 'package:sleeping_app/screens/profile_screen/profile_screen.dart';

import 'package:sleeping_app/screens/theme_screen/theme_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text('User not signed in'),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title:
              const Text("Profile Page", style: TextStyle(color: Colors.white)),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            if (snapshot.hasData && snapshot.data!.exists) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 120.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _accountInfoContainer(
                          info: 'Profile Details',
                          secondaryWidget: const SizedBox.shrink(),
                          context: context,
                          onTap: () {
                            Get.to(() => const ProfileScreen());
                          }),
                      // Center(
                      //   child: _accountInfoContainer(
                      //       info: 'Name: ${userData['name']}',
                      //       secondaryWidget: GestureDetector(
                      //         onTap: () {
                      //           showCustomBottomSheet(
                      //             sheetWidget: AccountInfoChangeSheet(
                      //               onPress: () {
                      //                 _updateUserName();
                      //               },
                      //               buttonTitle: 'Update Name',
                      //               hintText: 'New Name',
                      //               onTextFieldChange: (val) {
                      //                 globalController.userName.value = val;
                      //               },
                      //               showSecondTextField: false,
                      //             ),
                      //           );
                      //         },
                      //         child: const Icon(
                      //           Icons.edit,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //       context: context),
                      // ),
                      _accountInfoContainer(
                          info: 'Set Reminders',
                          secondaryWidget: const SizedBox.shrink(),
                          context: context,
                          onTap: () {
                            Get.to(() => const SetReminderScreen(
                                  showBackButton: true,
                                ));
                          }),
                      _accountInfoContainer(
                          info: 'View Reminders',
                          secondaryWidget: const SizedBox.shrink(),
                          context: context,
                          onTap: () {
                            Get.to(() => const ViewSleepingGoalsScreen());
                          }),
                      _accountInfoContainer(
                          info: 'Mode History Viewer',
                          secondaryWidget: const SizedBox.shrink(),
                          context: context,
                          onTap: () async {
                            Get.to(() => MoodDisplayScreen());
                            //  showMoodDialogue();
                            // bool dateFoundInMood =
                            //     await moodService.checkIfPresentDateInCache();
                            // if (dateFoundInMood) {
                            //   Get.log('date already in mood');
                            // } else {
                            //   Get.log('adding date in cache');
                            //   moodService.addMoodToCache(DateTime.now(), '😐');
                            // }
                          }),
                      _accountInfoContainer(
                          info: 'Themes',
                          secondaryWidget: const SizedBox.shrink(),
                          context: context,
                          onTap: () {
                            Get.to(() => const ThemeScreen(
                                  showBackButton: true,
                                ));
                          }),
                      // _accountInfoContainer(
                      //     info: 'Email: ${userData['email']}',
                      //     secondaryWidget: const SizedBox.shrink(),
                      //     context: context),
                      // _accountInfoContainer(
                      //     info: 'Account Type: ${userData['accountType']}',
                      //     secondaryWidget: const SizedBox.shrink(),
                      //     context: context),
                      // if (userData['accountType'] == 'email')
                      //   _accountInfoContainer(
                      //       info: 'Change Password',
                      //       secondaryWidget: GestureDetector(
                      //         onTap: () {
                      //           showCustomBottomSheet(
                      //             sheetWidget: AccountInfoChangeSheet(
                      //               onPress: () {
                      //                 changePassword();
                      //               },
                      //               buttonTitle: 'Change Password',
                      //               hintText: 'New Password',
                      //               onTextFieldChange: (val) {
                      //                 globalController.userNewPass.value = val;
                      //               },
                      //               showSecondTextField: true,
                      //               onSecondTextFieldChange: (val) {
                      //                 globalController.userOldPass.value = val;
                      //               },
                      //               hintText2: 'Old Password',
                      //             ),
                      //           );
                      //         },
                      //         child: const Icon(
                      //           Icons.edit,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //       context: context),
                      _accountInfoContainer(
                          info: 'Logout',
                          secondaryWidget: const SizedBox.shrink(),
                          context: context,
                          onTap: () {
                            firebaseController.accountType.value == 'google'
                                ? authService.signOutGoogle()
                                : authService.logout();
                          }),
                      _accountInfoContainer(
                          info: 'Delete Account',
                          secondaryWidget: GestureDetector(
                            onTap: () {
                              firebaseController.accountType.value == 'google'
                                  ? authService.deleteGoogleAccount()
                                  : showCustomBottomSheet(
                                      sheetWidget: AccountInfoChangeSheet(
                                        onPress: () {
                                          Get.log(firebaseController
                                              .accountType.value);
                                          authService.deleteUserAccount(
                                              password: globalController
                                                  .userOldPass.value);
                                        },
                                        buttonTitle: 'Delete Account',
                                        hintText: 'Your Password',
                                        onTextFieldChange: (val) {
                                          globalController.userOldPass.value =
                                              val;
                                        },
                                        showSecondTextField: false,
                                      ),
                                    );
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          context: context),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('No user data found'),
              );
            }
          },
        ));
  }

  Widget _accountInfoContainer(
      {required String info,
      required Widget secondaryWidget,
      required BuildContext context,
      Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10.0, right: 10.0),
        width: MediaQuery.sizeOf(context).width - 20,
        decoration: const BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                info,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              secondaryWidget
            ],
          ),
        ),
      ),
    );
  }

  _updateUserName() {
    if (globalController.userName.value.isEmpty) {
      Get.snackbar('Alert', 'Please enter your new name',
          backgroundColor: Colors.red);
    } else {
      showProcessingDialog(title: 'Updating...');

      try {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'name': globalController.userName.value});
        Navigator.pop(Get.context!);
        Navigator.pop(Get.context!);
        Get.snackbar('Alert', 'Your name has been updated',
            backgroundColor: Colors.green);
        globalController.userName.value = '';
      } catch (e) {
        Get.back();
        Get.snackbar('Alert', 'Some error occurred please try again',
            backgroundColor: Colors.red);
      }
    }
  }

  changePassword() async {
    if (globalController.userOldPass.value.isEmpty ||
        globalController.userNewPass.value.isEmpty) {
      Get.snackbar('Alert', 'Please enter your password',
          backgroundColor: Colors.red);
    } else if (globalController.userOldPass.value.length < 5 ||
        globalController.userNewPass.value.length < 5) {
      Get.snackbar('Alert', 'Please enter strong password',
          backgroundColor: Colors.red);
    } else {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'no-user',
          message: 'No user is signed in.',
        );
      }

      try {
        // Get the user's email
        final email = user.email;
        if (email == null) {
          throw FirebaseAuthException(
            code: 'no-email',
            message: 'Email not available for this user.',
          );
        }

        final credential = EmailAuthProvider.credential(
            email: email, password: globalController.userOldPass.value);
        await user.reauthenticateWithCredential(credential);

        await user.updatePassword(globalController.userNewPass.value);

        Get.log("Password updated successfully");
        Get.snackbar('Alert', 'Password Updated',
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1));
        globalController.userNewPass.value = '';
        globalController.userOldPass.value = '';
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
        });
      } catch (e) {
        Get.log("Error changing password: ${e.toString()}");
        Get.snackbar('Alert', 'Error changing password try again',
            backgroundColor: Colors.red);
        rethrow;
      }
    }
  }
}
