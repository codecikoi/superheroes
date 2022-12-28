import 'package:json_annotation/json_annotation.dart';
import 'package:superheroes/model/biography.dart';
import 'package:superheroes/model/server_image.dart';

part 'superhero.g.dart';

@JsonSerializable()
class Superhero {
  final String name;
  final Biography biography;
  final ServerImage image;

  Superhero(
    this.biography,
    this.name,
    this.image,
  );

  factory Superhero.fromJson(final Map<String, dynamic> json) => _$SuperheroFromJson(json);

  Map<String, dynamic> toJson() => _$SuperheroToJson(this);

}
