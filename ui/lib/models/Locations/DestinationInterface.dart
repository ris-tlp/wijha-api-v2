class Destination {
  String name;
  String imageUrl;
  // String coordinates;
  String description;
  bool imageNet;

  Destination({
    required this.name,
    required this.imageUrl,
    // required this.coordinates,
    required this.description,
    this.imageNet = true,
  });

}