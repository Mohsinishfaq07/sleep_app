import 'package:sleeping_app/packages.dart';

class ConnectButton extends StatelessWidget {
  final String image;
  final VoidCallback ontap;
  const ConnectButton({
    required this.image,
    required this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        color: Colors.transparent,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 44,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12),
              child: Image.asset(
                image,
                height: 40,
              ),
            )),
      ),
    );
  }
}
