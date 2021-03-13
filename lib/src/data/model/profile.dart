import 'dart:convert';

class Profile {
  final String name;
  final String profile_picture;
  final String nim;
  Profile({
    this.name,
    this.profile_picture,
    this.nim,
  });

  Profile copyWith({
    String name,
    String profile_picture,
    String nim,
  }) {
    return Profile(
      name: name ?? this.name,
      profile_picture: profile_picture ?? this.profile_picture,
      nim: nim ?? this.nim,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_picture': profile_picture,
      'nim': nim,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'],
      profile_picture: map['profile_picture'],
      nim: map['nim'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() =>
      'Profile(name: $name, profile_picture: $profile_picture, nim: $nim)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.name == name &&
        other.profile_picture == profile_picture &&
        other.nim == nim;
  }

  @override
  int get hashCode => name.hashCode ^ profile_picture.hashCode ^ nim.hashCode;
}
