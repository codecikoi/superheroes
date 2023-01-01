// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'superhero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Superhero _$SuperheroFromJson(Map<String, dynamic> json) => Superhero(
      biography: Biography.fromJson(json['biography'] as Map<String, dynamic>),
      name: json['name'] as String,
      image: ServerImage.fromJson(json['image'] as Map<String, dynamic>),
      id: json['id'] as String,
      powerstats:
          Powerstats.fromJson(json['powerstats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuperheroToJson(Superhero instance) => <String, dynamic>{
      'name': instance.name,
      'biography': instance.biography.toJson(),
      'image': instance.image.toJson(),
      'id': instance.id,
      'powerstats': instance.powerstats.toJson(),
    };
