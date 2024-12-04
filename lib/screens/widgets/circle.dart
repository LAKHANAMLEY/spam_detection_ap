import 'package:spam_delection_app/lib.dart';

class Circle extends StatelessWidget {
  final Color color;
  final double radius;
  final double margin;

  const Circle({
    super.key,
    this.color = Colors.grey,
    this.radius = 5,
    this.margin = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
