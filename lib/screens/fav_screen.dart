import 'package:chatting_app/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatting_app/widgets/image_widget.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Images'),
      ),
      body: Consumer<CustomImageProvider>( // Use CustomImageProvider
        builder: (context, imageProvider, child) {
          final favoriteImages = imageProvider.images.where((image) => image.isFavorite).toList();

          if (favoriteImages.isEmpty) {
            return Center(child: Text('No favorite images.'));
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemCount: favoriteImages.length,
            itemBuilder: (context, index) {
              final image = favoriteImages[index];
              return ImageWidget(
                image: image,
                onFavoriteToggle: () {
                  // Handle favorite toggle
                },
                onDelete: () async {
                  await Provider.of<CustomImageProvider>(context, listen: false).deleteImage(image.id, image.imageUrl); // Pass both id and imageUrl
                },
              );
            },
          );
        },
      ),
    );
  }
}
