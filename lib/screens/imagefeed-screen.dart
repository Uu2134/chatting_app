import 'package:chatting_app/screens/fav_screen.dart';
import 'package:chatting_app/screens/setting.dart';
import 'package:chatting_app/services/firebase_services.dart';
import 'package:chatting_app/signin_screen.dart';
import 'package:chatting_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatting_app/models/image_model.dart';

class ImageFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Feed'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseService().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamProvider<List<ImageModel>>.value(
        value: FirebaseService().getImages(),
        initialData: [],
        child: Consumer<List<ImageModel>>(
          builder: (context, images, child) {
            if (images.isEmpty) {
              return Center(child: Text('No images available.'));
            }
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: images.length,
              itemBuilder: (context, index) {
                final image = images[index];
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
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
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
