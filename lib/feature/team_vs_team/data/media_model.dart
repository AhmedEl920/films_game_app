class MediaItem {
  final int id;
  final String name;
  final String description;

  MediaItem({
    required this.id,
    required this.name,
    required this.description,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class MediaData {
  final List<MediaItem> movies;
  final List<MediaItem> series;
  final List<MediaItem> plays;

  MediaData({
    required this.movies,
    required this.series,
    required this.plays,
  });

  factory MediaData.fromJson(Map<String, dynamic> json) {
    return MediaData(
      movies: (json['movies'] as List).map((i) => MediaItem.fromJson(i)).toList(),
      series: (json['series'] as List).map((i) => MediaItem.fromJson(i)).toList(),
      plays: (json['plays'] as List).map((i) => MediaItem.fromJson(i)).toList(),
    );
  }
}
