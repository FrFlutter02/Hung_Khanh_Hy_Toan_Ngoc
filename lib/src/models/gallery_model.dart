class GalleryModel {
  final String id;
  final String link;
  const GalleryModel({
    required this.id,
    required this.link,
  });
  Map<String, dynamic> toJson() => {'id': id, 'url': link};
}
