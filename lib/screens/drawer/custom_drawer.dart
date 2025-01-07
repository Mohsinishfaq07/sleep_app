import 'package:sleeping_app/common_widgets/BottomSheets/password_sheet.dart';
import 'package:sleeping_app/common_widgets/BottomSheets/update_password.dart';
import 'package:sleeping_app/packages.dart';

class CustomDrawer extends StatefulWidget {
    CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
 
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
        child: Container(
          color: Colors.blue[900], // Dark blue background
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                ),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text('Home', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle navigation
                  Navigator.pop(context);
                },
              ),
              
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title:
                    const Text('Settings', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle navigation
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.white),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () {
                  firebaseController.accountType == 'google'
                      ? authService.signOutGoogle()
                      : authService.logout();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.white),
                title: const Text('Delete Account',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Get.bottomSheet(PasswordSheet(
                    deleteAccountFunction: () {
                      firebaseController.accountType == 'google'
                          ? authService.deleteGoogleAccount()
                          : authService.deleteUserAccount(
                              password: authController.password.value);
                    },
                  ), backgroundColor: Colors.black);
                },
              ),
              firebaseController.accountType == 'google'
                  ? const SizedBox.shrink()
                  : ListTile(
                      leading: const Icon(Icons.update, color: Colors.white),
                      title: const Text('Update Password',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Get.bottomSheet(UpdatePassword(
                          updatePassFunction: () {
                            authService.updatePassword(
                                authController.password.value,
                                authController.newPassword.value);
                          },
                        ),
                            backgroundColor: Colors.black,
                            isScrollControlled: true);
                      },
                    ),
            ],
          ),
        ),
      
    );
  }
}
 

