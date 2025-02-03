import 'package:sleeping_app/packages.dart';
import 'package:sleeping_app/services/life_cycle/life_cycle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initializeControllers();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
  AppLifecycleService();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding:
          SplashBinding(), // Initialize the SplashController via binding
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
        primaryColor: primaryColor,
        primarySwatch: Colors.deepPurple,
      ),
      home: const SplashScreenView(),
    );
  }
}

// Bindings class to manage controller initialization
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
        () => SplashScreenController()); // Use lazy initialization
    Get.lazyPut<BottomNavigationBarController>(
        () => BottomNavigationBarController()); // Use lazy initializationz
    Get.lazyPut<SoundPlayerController>(
        () => SoundPlayerController()); // Use lazy initialization
  }
}
