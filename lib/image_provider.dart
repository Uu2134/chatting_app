import 'package:flutter/material.dart';
import 'package:chatting_app/services/firebase_services.dart';
import 'package:chatting_app/models/image_model.dart';

class CustomImageProvider with ChangeNotifier {
  List<ImageModel> _images = [];
  FirebaseService _firebaseService = FirebaseService();

  List<ImageModel> get images => _images;

  CustomImageProvider() {
    fetchImages();
  }

  void fetchImages() async {
    _firebaseService.getImages().listen((imagesData) {
      _images = imagesData;
      notifyListeners();
    });
  }

  Future<void> updateFavoriteStatus(String id, bool isFavorite) async {
    await _firebaseService.updateFavoriteStatus(id, isFavorite);
    fetchImages(); // Refresh images after updating favorite status
  }

  Future<void> deleteImage(String id, String imageUrl) async { // Ensure both id and imageUrl are accepted
    await _firebaseService.deleteImage(id, imageUrl);
    fetchImages(); // Refresh images after deletion
  }

  void signOut() async {
    await _firebaseService.signOut();
    _images = [];
    notifyListeners();
  }
}
