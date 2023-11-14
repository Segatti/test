import 'package:flutter/cupertino.dart';

class BaseViewWidget extends StatelessWidget {
  final Widget child;
  const BaseViewWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF224C5D),
            Color(0xFF358F89),
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: child,
      ),
    );
  }
}
