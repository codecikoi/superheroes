import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'alignment_info.dart';

part 'biography.g.dart';

@JsonSerializable()
class Biography {
  final List<String> aliases;
  final String placeOfBirth;
  final String fullName;
  final String alignment;

  Biography({
    required this.aliases,
    required this.placeOfBirth,
    required this.fullName,
    required this.alignment,
  });

  factory Biography.fromJson(final Map<String, dynamic> json) =>
      _$BiographyFromJson(json);

  Map<String, dynamic> toJson() => _$BiographyToJson(this);

  AlignmentInfo? get alignmentInfo => AlignmentInfo.fromAlignment(alignment);

  @override
  String toString() {
    return 'Biography{aliases: $aliases, placeOfBirth: $placeOfBirth, fullName: $fullName, alignment: $alignment}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Biography &&
          runtimeType == other.runtimeType &&
          ListEquality<String>().equals(aliases, other.aliases) &&
          placeOfBirth == other.placeOfBirth &&
          fullName == other.fullName &&
          alignment == other.alignment;

  @override
  int get hashCode =>
      aliases.hashCode ^
      placeOfBirth.hashCode ^
      fullName.hashCode ^
      alignment.hashCode;
}
