import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superheroes/pages/superhero_page.dart';
import 'package:superheroes/resources/superheroes_images.dart';
import 'package:superheroes/widgets/action_button.dart';
import 'package:superheroes/widgets/info_with_button.dart';
import 'package:superheroes/widgets/supeerhero_card.dart';

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
          child: ActionButton(
            text: 'next state',
            onTap: () => bloc.nextState(),
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
              return NothingFoundContent();
            case MainPageState.loadingError:
              return LoadingErrorContent();
            case MainPageState.searchResults:
              return SearchResultsContent();
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
    return InfoWithButton(
      title: 'No favorites yet',
      subtitle: 'search and add',
      buttonText: 'search',
      assetImage: SuperheroesImages.ironman,
      imageWidth: 110.0,
      imageHeight: 120.0,
      imageTopPadding: 20.0,
    );
  }
}

class LoadingErrorContent extends StatelessWidget {
  const LoadingErrorContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoWithButton(
        title: 'Error happened',
        subtitle: 'please, try again',
        buttonText: 'retry',
        assetImage: SuperheroesImages.superman,
        imageWidth: 126.0,
        imageHeight: 106.0,
        imageTopPadding: 20.0);
  }
}

class NothingFoundContent extends StatelessWidget {
  const NothingFoundContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoWithButton(
        title: 'Nothing found',
        subtitle: 'search for something else',
        buttonText: 'search',
        assetImage: SuperheroesImages.hulk,
        imageWidth: 85.0,
        imageHeight: 112.0,
        imageTopPadding: 20.0);
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
          child: SuperheroCard(
            name: 'batman',
            realName: 'Bruce Wayne',
            imageUrl:
                'https://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuperheroPage(
                    name: 'Batman',
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: SuperheroCard(
            name: 'ironman',
            realName: 'Tony Stark',
            imageUrl:
                'https://www.superherodb.com/pictures2/portraits/10/100/85.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuperheroPage(
                    name: 'Ironman',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchResultsContent extends StatelessWidget {
  const SearchResultsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 110),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Search results',
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
          child: SuperheroCard(
            name: 'batman',
            realName: 'Bruce Wayne',
            imageUrl:
                'https://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuperheroPage(
                    name: 'Batman',
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: SuperheroCard(
            name: 'venom',
            realName: 'Eddie Brock',
            imageUrl:
                'https://www.superherodb.com/pictures2/portraits/10/100/22.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuperheroPage(
                    name: 'Venom',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
