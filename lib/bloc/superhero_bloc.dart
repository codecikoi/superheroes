import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:superheroes/exception/api_exception.dart';
import 'package:superheroes/favorite_superheroes_storage.dart';

import '../model/superhero.dart';

class SuperheroBloc {
  http.Client? client;
  final String id;

  final superheroSubject = BehaviorSubject<Superhero>();

  StreamSubscription? getFromFavoritesSubscription;
  StreamSubscription? requestSubscription;
  StreamSubscription? addToFavoriteSubscription;
  StreamSubscription? removeFromFavoriteSubscription;

  SuperheroBloc(this.client, {required this.id}) {
    getFromFavorites();
  }

  void getFromFavorites() {
    getFromFavoritesSubscription?.cancel();
    getFromFavoritesSubscription = FavoriteSuperheroesStorage.getInstance()
        .getSuperhero(id)
        .asStream()
        .listen(
      (superhero) {
        if (superhero != null) {
          superheroSubject.add(superhero);
        }
        requestSuperhero();
      },
      onError: (error, stackTrace) =>
          print('error happened in removefromFavorites: $error, $stackTrace'),
    );
  }

  void addToFavorite() {
    final superhero = superheroSubject.valueOrNull;
    if (superhero == null) {
      print('error superhero is null! it shouldnt be');
      return;
    }

    addToFavoriteSubscription?.cancel();
    addToFavoriteSubscription = FavoriteSuperheroesStorage.getInstance()
        .addFavorites(superhero)
        .asStream()
        .listen(
          (event) {
        print('added to favorite: $event');
      },
      onError: (error, stackTrace) =>
          print('error happened in addtofavorites: $error, $stackTrace'),
    );
  }


  void removeFromFavorites() {
    removeFromFavoriteSubscription?.cancel();
    removeFromFavoriteSubscription = FavoriteSuperheroesStorage.getInstance().removeFromFavorites(id).asStream().listen((event) {
      print('removed from favorites: $event');
    },
      onError: (error, stackTrace) =>
          print('error happened in removefromFavorites: $error, $stackTrace'),

    );
  }

  Stream<bool> observeIsFavorite() => FavoriteSuperheroesStorage.getInstance().observeIsFavorite(id);

  void requestSuperhero() {
    requestSubscription?.cancel();
    requestSubscription = request().asStream().listen(
        (supehero) {
          superheroSubject.add(supehero);
        },
      onError: (error, stackTrace) {
          print('error happened in requestSuperhero: $error, $stackTrace'),
  },
    );

}

Future<Superhero> request() async {
    final token = dotenv.env['SUPERHERO_TOKEN'];
    final response = await (client ??= http.Client()).get(Uri.parse('https://superheroapi.com/api/$token/$id'));
    if (response.statusCode >= 500 && response.statusCode <= 599) {
      throw ApiException(message: 'Server error happened');
    }
    if (response.statusCode >= 400 && response.statusCode <= 499) {
      throw ApiException(message: 'client error happened');
    }
    final decoded = json.decode(response.body);
    if (decoded['response'] == 'success') {
      return Superhero.fromJson(decoded);
    } else if (decoded['response'] == 'error') {
      throw ApiException(message: 'client error happened')
    }
    throw Exception('unknown error happened');
  }

  Stream<Superhero> observeSuperhero() => superheroSubject;

  void dispose() {
    client?.close();

    getFromFavoritesSubscription?.cancel();
    requestSubscription?.cancel();
    addToFavoriteSubscription?.cancel();
    removeFromFavoriteSubscription?.cancel();

    superheroSubject.close();
  }
}
