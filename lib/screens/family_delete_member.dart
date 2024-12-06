import 'package:spam_delection_app/lib.dart';

class FamilyDeleteMember extends StatefulWidget {
  const FamilyDeleteMember({super.key});

  @override
  State<FamilyDeleteMember> createState() => _FamilyDeleteMemberState();
}

class _FamilyDeleteMemberState extends State<FamilyDeleteMember> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
