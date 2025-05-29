class UserModel {
  final String name;
  final int age;
  final String location;
  final String imageUrl;
  final double latitude;
  final double longitude;

  UserModel({
    required this.name,
    required this.age,
    required this.location,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  /// 🔄 Create a new instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      age: json['age'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  /// 📦 Convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'location': location,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  /// ✏️ Clone with changes
  UserModel copyWith({
    String? name,
    int? age,
    String? location,
    String? imageUrl,
    double? latitude,
    double? longitude,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  /// 🔁 Equality override for comparison (optional)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age &&
          location == other.location &&
          imageUrl == other.imageUrl &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode =>
      name.hashCode ^
      age.hashCode ^
      location.hashCode ^
      imageUrl.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
}
