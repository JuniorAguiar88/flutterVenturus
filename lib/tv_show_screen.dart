import 'package:flutter/material.dart';
import 'package:flutter_application_2/tv_show_card.dart';
import 'package:flutter_application_2/tv_show_model.dart';
import 'package:provider/provider.dart';

class TvShowScreen extends StatefulWidget {
  const TvShowScreen({super.key});

  //final List<TvShow> tvShows;
  //final Function(TvShow) removeTvShow;

  @override
  State<TvShowScreen> createState() => TvShowScreenState();
}

class TvShowScreenState extends State<TvShowScreen> {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<TvShowModel>(context);

    return ListView.builder(
      itemCount: model.tvShows.length,
      itemBuilder: (context, index) => Consumer<TvShowModel>(
        builder: (context, model, child) =>
            TvShowCard(tvShow: model.tvShows[index], index: index),
      ),
    );
  }
}
