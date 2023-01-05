import 'package:flutter/material.dart';
import 'package:superheroes/resources/superheroes_colors.dart';

class SuperheroPage extends StatelessWidget {
  final String id;

  const SuperheroPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SuperheroesColors.background,
      body: Container(),
    );
  }
}
