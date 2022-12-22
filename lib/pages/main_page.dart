import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superheroes/resources/superheroes_images.dart';
import 'package:superheroes/widgets/action_button.dart';

import '../bloc/main_bloc.dart';
import '../resources/superheroes_colors.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainBloc bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: SuperheroesColors.background,
        body: SafeArea(
          child: MainPageContent(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

class MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = Provider.of<MainBloc>(context);
    return Stack(
      children: [
        MainPageStateWidget(),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () => bloc.nextState(),
            child: Text(
              "Next state".toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MainPageStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = Provider.of<MainBloc>(context);
    return StreamBuilder<MainPageState>(
        stream: bloc.observeMainPageState(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return SizedBox();
          }
          final MainPageState state = snapshot.data!;
          switch (state) {
            case MainPageState.loading:
              return LoadingIndicator();
            case MainPageState.noFavorites:
              return NoFavoritesContent();
            case MainPageState.minSymbols:
              return MinSymbolsText();
            case MainPageState.nothingFound:
            case MainPageState.loadingError:
            case MainPageState.searchResults:
            case MainPageState.favorites:
              return FavoritesContent();
            default:
              return Center(
                child: Text(
                  state.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
          }
        });
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 110.0),
        child: CircularProgressIndicator(
          color: SuperheroesColors.blue,
          strokeWidth: 4.0,
        ),
      ),
    );
  }
}

class MinSymbolsText extends StatelessWidget {
  const MinSymbolsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 110.0,
        ),
        child: Text(
          'Enter at least 3 symbols',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

class NoFavoritesContent extends StatelessWidget {
  const NoFavoritesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SuperheroesColors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset(
                SuperheroesImages.ironman,
                width: 110.0,
                height: 120.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'No favorites yet',
          style: TextStyle(
            fontSize: 32.0,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'search and add'.toUpperCase(),
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20),
        ActionButton(
          text: 'Search',
          onTap: () {},
        ),
      ],
    ));
  }
}

class FavoritesContent extends StatelessWidget {
  const FavoritesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 110),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Your favorites',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24.0,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: SuperheroesColors.cardBackground,
            ),
            child: Row(
              children: [
                Image.network(
                  'https://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
                  width: 70.0,
                  height: 70.0,
                  alignment: Alignment.topLeft,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'batman'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Bruce Wayne',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: SuperheroesColors.cardBackground,
            ),
            child: Row(
              children: [
                Image.network(
                  'https://www.superherodb.com/pictures2/portraits/10/100/85.jpg',
                  width: 70.0,
                  height: 70.0,
                  alignment: Alignment.topLeft,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ironman'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Tony Stark',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ],
    );
  }
}
