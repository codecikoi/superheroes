import 'package:json_annotation/json_annotation.dart';
import 'package:superheroes/model/biography.dart';
import 'package:superheroes/model/powerstats.dart';
import 'package:superheroes/model/server_image.dart';

part 'superhero.g.dart';

@JsonSerializable()
class Superhero {
  final String name;
  final Biography biography;
  final ServerImage image;
  final String id;
  final Powerstats powerstats;

  Superhero({
    required this.biography,
    required this.name,
    required this.image,
    required this.id,
    required this.powerstats,
  });


  factory Superhero.fromJson(final Map<String, dynamic> json) =>
      _$SuperheroFromJson(json);

  Map<String, dynamic> toJson() => _$SuperheroToJson(this);

  @override
  String toString() {
    return 'Superhero{name: $name, biography: $biography, image: $image, id: $id, powerstats: $powerstats}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Superhero &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          biography == other.biography &&
          image == other.image &&
          id == other.id &&
          powerstats == other.powerstats;

  @override
  int get hashCode =>
      name.hashCode ^
      biography.hashCode ^
      image.hashCode ^
      id.hashCode ^
      powerstats.hashCode;
}
