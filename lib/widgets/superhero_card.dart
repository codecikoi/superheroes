import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:superheroes/resources/superheroes_colors.dart';

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
        decoration: BoxDecoration(
          color: SuperheroesColors.cardBackground,
        ),
        child: Row(
          children: [
            Container(
              color: Colors.white24,
              width: 70.0,
              height: 70.0,
              child: CachedNetworkImage(
                imageUrl: superheroInfo.imageUrl,
                width: 70.0,
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
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    superheroInfo.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    superheroInfo.realName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
