import 'dart:convert';

class Profile {
  final String name;
  final String profile_picture;

  Profile({
    this.name,
    this.profile_picture,
  });

  Profile copyWith({
    String name,
    String profile_picture,
  }) {
    return Profile(
      name: name ?? this.name,
      profile_picture: profile_picture ?? this.profile_picture,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_picture': profile_picture,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Profile(
      name: map['name'],
      profile_picture: map['profile_picture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() =>
      'Profile(name: $name, profile_picture: $profile_picture)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Profile &&
        o.name == name &&
        o.profile_picture == profile_picture;
  }

  @override
  int get hashCode => name.hashCode ^ profile_picture.hashCode;
}
