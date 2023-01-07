
import 'dart:convert';

import 'package:rxdart/subjects.dart';

import 'model/superhero.dart';

class FavoriteSuperheroesStorage {

  static const _key = 'favorite_superheroes';

  final updater = PublishSubject<Null>;

  static FavoriteSuperheroesStorage? _instance;

  factory FavoriteSuperheroesStorage.getInstance() => _instance ??= FavoriteSuperheroesStorage._internal();

  FavoriteSuperheroesStorage._internal();

  Future<bool> addFavorites(final Superhero superhero) async {
    final rawSuperheroes = await _getRawSuperheroes();
    rawSuperheroes.add(json.encode(superhero.toJson()));
    return _setRawSuperheroes(rawSuperheroes);
  }

  Future<List<String>> _getRawSuperheroes() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(_key) ?? [];
}

Future<bool> _setRawSuperheroes(final List<String> rawSuperheroes async {
  final sp = await SharedPreferences.getInstance();
  final result = sp.setStringList(_key,  rawSuperheroes);
  updater.add(null);
  return result;
}

  Future<bool> removeFromFavorites(final String id) async {
    final superheroes = await _getSuperheroes();
    superheroes.removeWhere((superhero) => superhero.id == id);
    return _setSuperheroes(superheroes);
  }

}