import 'package:spam_delection_app/lib.dart';

class Circle extends StatelessWidget {
  final Color? color;

  final double? radius;

  const Circle({super.key, this.color = Colors.grey, this.radius = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
