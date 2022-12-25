import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:superheroes/pages/superhero_page.dart';
import 'package:superheroes/resources/superheroes_images.dart';
import 'package:superheroes/widgets/info_with_button.dart';
import 'package:superheroes/widgets/superhero_card.dart';

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
    return Stack(
      children: [
        MainPageStateWidget(),
        Padding(
          padding: EdgeInsets.only(
            top: 12,
            right: 16,
            left: 16.0,
          ),
          child: SearchWidget(),
        )
      ],
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final MainBloc bloc = Provider.of<MainBloc>(context, listen: false);
      controller.addListener(() => bloc.updateText(controller.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 20.0,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: SuperheroesColors.indigo75,
        isDense: true,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white54,
          size: 24.0,
        ),
        suffix: GestureDetector(
          onTap: () => controller.clear(),
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.white24),
        ),
      ),
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
          case MainPageState.minSymbols:
            return MinSymbolsText();
          case MainPageState.noFavorites:
            return NoFavoritesContent();
          case MainPageState.favorites:
            return SuperheroList(
              title: 'Your favorites',
              stream: bloc.observeFavoriteSuperheroes(),
            );
          case MainPageState.searchResults:
            return SuperheroList(
              title: 'Search results',
              stream: bloc.observeSearchedSuperheroes(),
            );
          case MainPageState.nothingFound:
            return NothingFoundContent();
          case MainPageState.loadingError:
            return LoadingErrorContent();

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
      },
    );
  }
}

class SuperheroList extends StatelessWidget {
  final String title;
  final Stream<List<SuperheroInfo>> stream;

  const SuperheroList({
    Key? key,
    required this.title,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SuperheroInfo>>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }
        final List<SuperheroInfo> superheroes = snapshot.data!;
        return ListView.separated(
          itemCount: superheroes.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16.0,
                  top: 90,
                  bottom: 12.0,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
            }
            final SuperheroInfo item = superheroes[index - 1];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SuperheroCard(
                name: item.name,
                realName: item.realName,
                imageUrl: item.imageUrl,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SuperheroPage(name: item.name),
                    ),
                  );
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 8.0);
          },
        );
      },
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
      imageWidth: 108.0,
      imageHeight: 119.0,
      imageTopPadding: 9.0,
    );
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
        imageWidth: 84.0,
        imageHeight: 112.0,
        imageTopPadding: 16.0);
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
        imageTopPadding: 22.0);
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
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
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
