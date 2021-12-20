import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/presentation/bloc/bloc.dart';
import 'package:shared/common/image_path.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Modular.get<MoviesBloc>().add(LoadMovies(isInitial: true));

    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(.2),
          elevation: 0.0,
          title: Text(
            "Movie Turbo",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.blueAccent),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesInitial) {
              return const Text("Movies Initial");
            } else if (state is MoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoviesHasData) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.data.length
                    : state.data.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.data.length
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 16.0,
                          ),
                          elevation: 2.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    state.data[index].mediumCoverImage ?? "-",
                                height: 120.0,
                                width: 90.0,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(ImagePath.appIcon),
                              ),
                              const SizedBox(width: 16.0),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      state.data[index].title ?? "-",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    RatingBarIndicator(
                                      rating: (state.data[index].rating! / 2),
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 24.0,
                                      direction: Axis.horizontal,
                                    ),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                (state.data[index].genres!
                                                            .length >
                                                        3
                                                    ? 3
                                                    : state.data[index].genres!
                                                        .length);
                                            i++)
                                          Flexible(
                                            child: Text(
                                              state.data[index].genres!
                                                          .length >=
                                                      3
                                                  ? i != 2
                                                      ? state.data[index]
                                                              .genres![i] +
                                                          " | "
                                                      : state.data[index]
                                                          .genres![i]
                                                  : state
                                                      .data[index].genres![i],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: Colors.blueAccent,
                                                  ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                },
              );
            } else if (state is MoviesNoData) {
              return const Text("Movies No Data");
            } else if (state is MoviesNoInternetConnection) {
              return const Text("You Are Offline");
            } else if (state is MoviesError) {
              return Text(state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  _onScroll() {
    if (_isBottom) Modular.get<MoviesBloc>().add(LoadMovies());
  }

  bool get _isBottom {
    return _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
  }
}

/*Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    state.data[index].mediumCoverImage ?? "-",
                                height: 120.0,
                                width: 90.0,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(ImagePath.appIcon),
                              ),
                              const SizedBox(width: 16.0),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      state.data[index].title ?? "-",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    RatingBarIndicator(
                                      rating: (state.data[index].rating! / 2),
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 24.0,
                                      direction: Axis.horizontal,
                                    ),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0;
                                            i <
                                                (state.data[index].genres!
                                                            .length >
                                                        3
                                                    ? 3
                                                    : state.data[index].genres!
                                                        .length);
                                            i++)
                                          Flexible(
                                            child: Text(
                                              state.data[index].genres!
                                                          .length >=
                                                      3
                                                  ? i != 2
                                                      ? state.data[index]
                                                              .genres![i] +
                                                          " | "
                                                      : state.data[index]
                                                          .genres![i]
                                                  : state
                                                      .data[index].genres![i],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: Colors.blueAccent,
                                                  ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )*/
