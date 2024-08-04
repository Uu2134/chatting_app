import 'package:chatting_app/models/image_model.dart';
import 'package:chatting_app/widgets/interactive_icons.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app/services/firebase_services.dart';

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
          left: 10,
          bottom: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                image.username,
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                ),
              ),
              Text(
                image.caption,
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                ),
              ),
            ],
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
        Positioned(
          right: 10,
          top: 10,
          child: IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              try {
                await FirebaseService().deleteImage(image.id, image.imageUrl);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Image deleted successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete image: $e')),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
