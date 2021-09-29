import 'package:bloc_medium/src/blocs/movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    MoviesBloc _bloc = MoviesBloc();
    _bloc.fetchAllMovies();
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  "About",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
              Divider(),
            ],
          ),
          ListTile(
            enabled: false,
            title: const Text("Version"),
            trailing: FutureBuilder(
              future: getVersionNumber(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  Text(
                snapshot.hasData ? snapshot.data.toString() : "Loading ...",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return version;
  }
}
