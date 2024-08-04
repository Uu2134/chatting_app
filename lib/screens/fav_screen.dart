import 'package:chatting_app/models/image_model.dart';
import 'package:chatting_app/services/firebase_services.dart';
import 'package:chatting_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamProvider<List<ImageModel>>.value(
        value: FirebaseService().getFavoriteImages().handleError((error) {
          print('Error fetching favorite images: $error');
        }),
        initialData: [],
        child: Consumer<List<ImageModel>>(
          builder: (context, favoriteImages, child) {
            if (favoriteImages.isEmpty) {
              return Center(child: Text('No favorite images.'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1, // Adjust this ratio to fit your image aspect ratio
              ),
              itemCount: favoriteImages.length,
              itemBuilder: (context, index) {
                final image = favoriteImages[index];
                return ImageWidget(
                  image: image,
                  onFavoriteToggle: () async {
                    await FirebaseService().updateFavoriteStatus(
                      image.id,
                      !image.isFavorite,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
