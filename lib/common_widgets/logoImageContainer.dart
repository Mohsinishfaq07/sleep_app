import 'package:sleeping_app/common_widgets/app_assets.dart';
import 'package:sleeping_app/packages.dart';

class LogoImageContainer extends StatelessWidget {
  const LogoImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            AppAssets.appLogo,
            height: MediaQuery.of(context).size.height * 0.22,
          ),
        ),
      ),
    );
  }
}

