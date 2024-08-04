class ImageModel {
  final String id;
  final String imageUrl;
  final String userId;
  final String username;
  final String caption;
  bool isFavorite;

  ImageModel({
    required this.id,
    required this.imageUrl,
    required this.userId,
    required this.username,
    required this.caption,
    this.isFavorite = false,
  });

  factory ImageModel.fromMap(Map<String, dynamic> data, String id) {
    return ImageModel(
      id: id,
      imageUrl: data['imageUrl'],
      userId: data['userId'],
      username: data['username'],
      caption: data['caption'],
      isFavorite: data['isFavorite'] is bool ? data['isFavorite'] : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'userId': userId,
      'username': username,
      'caption': caption,
      'isFavorite': isFavorite,
    };
  }
}
