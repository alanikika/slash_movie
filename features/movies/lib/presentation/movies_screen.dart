import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies/presentation/bloc/bloc.dart';
import 'package:shared/common/image_path.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Modular.get<MoviesBloc>().add(LoadMovies(isInitial: true));
    return SafeArea(
      left: false,
      right: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesInitial) {
              return const Text("Movies Initial");
            } else if (state is MoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoviesHasData) {
              debugPrint(" ${state.data.length}");
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: state.data[index].mediumCoverImage ?? "-",
                          height: 120.0,
                          width: 90.0,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Image.asset(ImagePath.appIcon),
                        ),
                        const SizedBox(width: 16.0),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              const SizedBox(
                                height: 8.0,
                              ),
                             /* Row(
                                children: [
                                  for (int i = 0;
                                      i < state.data[index].genres!.length;
                                      i++)
                                    Text(
                                      i != index
                                          ? state.data[index].genres![i] + " | "
                                          : state.data[index].genres![i],
                                    ),
                                ],
                              )*/
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
}
