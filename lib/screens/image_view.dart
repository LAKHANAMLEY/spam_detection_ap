import 'package:cached_network_image/cached_network_image.dart';
import 'package:spam_delection_app/lib.dart';

class ImageView extends StatelessWidget {
  final String? imageUrl;
  const ImageView({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var argument = args(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: InteractiveViewer(
        child: Center(
          child: CachedNetworkImage(
            imageUrl: argument.imageUrl ?? "",
          ),
        ),
      ),
    );
  }
}
