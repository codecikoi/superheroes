import 'package:json_annotation/json_annotation.dart';

import 'alignment_info.dart';

part 'biography.g.dart';

@JsonSerializable()
class Biography {
  final List<String> aliases;
  final String PlaceOfBirth;
  final String fullName;
  final String alignment;

  Biography({
    required this.aliases,
    required this.PlaceOfBirth,
    required this.fullName,
    required this.alignment,
  });

  factory Biography.fromJson(final Map<String, dynamic> json) =>
      _$BiographyFromJson(json);

  Map<String, dynamic> toJson() => _$BiographyToJson(this);

  AlignmentInfo? get alignmentInfo => AlignmentInfo.fromAlignment(alignment);
}
