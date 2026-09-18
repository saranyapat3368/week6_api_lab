class Item {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;

  const Item({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final title = json['title'] as String;
    // Cast ผ่าน num ก่อนเรียก .toDouble() เพื่อรองรับทั้ง int และ double
    final price = (json['price'] as num).toDouble();

    // เติม TODO ครบถ้วน:
    final description = json['description'] as String;
    final category = json['category'] as String;
    // ดึงจาก key 'image' ใน JSON ใส่ให้ imageUrl
    final imageUrl = json['image'] as String;

    return Item(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      imageUrl: imageUrl,
    );
  }
}