class Item {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  Item({
    required this.title,
    required this.id,
    required this.description,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
