class PicsumImage {
  PicsumImage({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  factory PicsumImage.fromJson(Map<String, dynamic> json) {
    return PicsumImage(
      id: json['id'] as String,
      author: json['author'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      url: json['url'] as String,
      downloadUrl: json['download_url'] as String,
    );
  }

  double get aspectRatio => width == 0 ? 1 : width / height;
}

