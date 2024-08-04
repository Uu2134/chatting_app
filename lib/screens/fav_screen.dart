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
        title: Text('Favorite Images'),
      ),
      body: StreamProvider<List<ImageModel>>.value(
        value: FirebaseService().getImages(),
        initialData: [],
        child: Consumer<List<ImageModel>>(
          builder: (context, images, child) {
            final favoriteImages = images.where((image) => image.isFavorite).toList();
            return ListView.builder(
              itemCount: favoriteImages.length,
              itemBuilder: (context, index) {
                final image = favoriteImages[index];
                return ImageWidget(
                  image: image,
                  onFavoriteToggle: () async {
                    await FirebaseService().updateFavoriteStatus(image.id, !image.isFavorite);
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
