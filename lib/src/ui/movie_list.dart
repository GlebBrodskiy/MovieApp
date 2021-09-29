import 'package:flutter/material.dart';

import '../blocs/movies_bloc.dart';
import '../models/item_model.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return StreamBuilder(
      stream: bloc.allMovies,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
  return ListView.builder(
      itemCount: snapshot.data!.results.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Details(snapshot.data!, index))),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Column(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w185${snapshot.data!.results[index].poster_path}',
                  fit: BoxFit.cover,
                  height: 400,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    snapshot.data!.results[index].original_title,
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

class Details extends StatelessWidget {
  final ItemModel info;
  final int index;

  const Details(this.info, this.index, [Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: NetworkImage(
        //             'https://image.tmdb.org/t/p/w185${info.results[index].poster_path}'),
        //         fit: BoxFit.fill)),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ))),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    info.results[index].original_title,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Center(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185${info.results[index].poster_path}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${info.results[index].vote_average}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.yellow,
                  ),
                  Text('(${info.results[index].vote_count} votes)')
                ],
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Text(
                  info.results[index].overview,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
