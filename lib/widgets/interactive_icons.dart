import 'package:flutter/material.dart';

class InteractiveIcons extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const InteractiveIcons({
    Key? key,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onComment,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.white,
          ),
          onPressed: onFavoriteToggle,
        ),
        IconButton(
          icon: Icon(Icons.comment, color: Colors.white),
          onPressed: onComment,
        ),
        IconButton(
          icon: Icon(Icons.share, color: Colors.white),
          onPressed: onShare,
        ),
      ],
    );
  }
}
