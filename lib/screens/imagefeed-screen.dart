import 'package:chatting_app/image_provider.dart';
import 'package:chatting_app/screens/fav_screen.dart';
import 'package:chatting_app/screens/setting.dart';
import 'package:chatting_app/widgets/image-picker.dart';
import 'package:chatting_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatting_app/models/image_model.dart';
import 'package:chatting_app/signin_screen.dart';

class ImageFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<CustomImageProvider>(context);
    final images = imageProvider.images;

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Feed'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              imageProvider.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: images.isEmpty
          ? Center(child: Text('No images available.'))
          : PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: images.length,
              itemBuilder: (context, index) {
                final image = images[index];
                return ImageWidget(
                  image: image,
                  onFavoriteToggle: () async {
                    await imageProvider.updateFavoriteStatus(
                      image.id,
                      !image.isFavorite,
                    );
                  },
                  onDelete: () async {
                    await imageProvider.deleteImage(image.id, image.imageUrl); // Pass both id and imageUrl
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImagePickerWidget()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Stay on the home screen
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
