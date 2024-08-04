import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:chatting_app/models/image_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<ImageModel>> getImages() {
    return _firestore.collection('images').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ImageModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Stream<List<ImageModel>> getFavoriteImages() {
    return _firestore.collection('images').where('isFavorite', isEqualTo: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ImageModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> updateFavoriteStatus(String id, bool isFavorite) async {
    await _firestore.collection('images').doc(id).update({'isFavorite': isFavorite});
  }

  Future<void> uploadImage(File imageFile, String username, String caption) async {
    final user = _auth.currentUser;
    if (user != null) {
      final ref = _storage.ref().child('images').child('${DateTime.now().toIso8601String()}.jpg');
      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();
      await _firestore.collection('images').add({
        'imageUrl': imageUrl,
        'userId': user.uid,
        'username': username,
        'caption': caption,
        'isFavorite': false,
      });
    }
  }

  Future<void> deleteImage(String imageId, String imageUrl) async { // Ensure both imageId and imageUrl are accepted
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('images').doc(imageId).get();
      if (doc.exists && doc.data()!['userId'] == user.uid) {
        // Delete image file from storage
        final ref = _storage.refFromURL(imageUrl);
        await ref.delete();
        
        // Delete document from Firestore
        await _firestore.collection('images').doc(imageId).delete();
      } else {
        throw Exception("You can only delete your own images.");
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
