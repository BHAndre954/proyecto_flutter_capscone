// lib/material_item.dart

class MaterialItem {
  final String title;
  final String description;
  final String type; // 'pdf', 'video', 'link'
  final String url;

  MaterialItem({
    required this.title,
    required this.description,
    required this.type,
    required this.url,
  });
}

