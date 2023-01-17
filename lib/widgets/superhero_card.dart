import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:superheroes/model/alignment_info.dart';
import 'package:superheroes/resources/superheroes_colors.dart';
import 'package:superheroes/resources/superheroes_images.dart';

import '../bloc/main_bloc.dart';

class SuperheroCard extends StatelessWidget {
  final SuperheroInfo superheroInfo;
  final VoidCallback onTap;

  const SuperheroCard({
    Key? key,
    required this.onTap,
    required this.superheroInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70.0,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: SuperheroesColors.indigo,
        ),
        child: Row(
          children: [
            _AvatarWidget(superheroInfo: superheroInfo),
            SizedBox(width: 12.0),
            NameAndRealNameWidget(superheroInfo: superheroInfo),
            if (superheroInfo.alignmentInfo != null)
              AlignmentWidget(alignmentInfo: superheroInfo.alignmentInfo!),
          ],
        ),
      ),
    );
  }
}

class AlignmentWidget extends StatelessWidget {
  final AlignmentInfo alignmentInfo;

  const AlignmentWidget({
    Key? key,
    required this.alignmentInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        color: alignmentInfo.color,
        alignment: Alignment.center,
        child: Center(
          child: Text(
            alignmentInfo.name.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class NameAndRealNameWidget extends StatelessWidget {
  final SuperheroInfo superheroInfo;

  const NameAndRealNameWidget({
    Key? key,
    required this.superheroInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            superheroInfo.name.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            superheroInfo.realName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  final SuperheroInfo superheroInfo;

  const _AvatarWidget({
    Key? key,
    required this.superheroInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white24,
      height: 70,
      width: 70,
      child: CachedNetworkImage(
        imageUrl: superheroInfo.imageUrl,
        height: 70,
        width: 70,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) {
          return Container(
            alignment: Alignment.center,
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: SuperheroesColors.blue,
              value: progress.progress,
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Center(
            child: Image.asset(
              SuperheroesImages.unknown,
              height: 62,
              width: 20,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
