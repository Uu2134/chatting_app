import 'package:chatting_app/models/image_model.dart';
import 'package:chatting_app/widgets/interactive_icons.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final ImageModel image;
  final VoidCallback onFavoriteToggle;

  const ImageWidget({
    Key? key,
    required this.image,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            image.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: InteractiveIcons(
            isFavorite: image.isFavorite,
            onFavoriteToggle: onFavoriteToggle,
            onComment: () {}, // Implement comment functionality
            onShare: () {}, // Implement share functionality
          ),
        ),
      ],
    );
  }
}
