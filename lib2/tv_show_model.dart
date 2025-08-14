import 'package:flutter/material.dart';
import 'package:flutter_application_2/tv_show_data.dart';

class TvShow {
  final String title;
  final String stream;
  final int rating;
  final String summary;

  TvShow({
    required this.title,
    required this.stream,
    required this.rating,
    required this.summary,
  });
}

class TvShowModel extends ChangeNotifier {
  final List<TvShow> _tvShows = favTvShowList;

  List<TvShow> get tvShows => _tvShows;

  void addTvShow(TvShow tvShow, BuildContext context) {
    _tvShows.add(tvShow);
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tvShow.title} adicionada!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void removeTvShow(TvShow tvShow, BuildContext context) {
    final index = _tvShows.indexOf(tvShow);
    _tvShows.remove(tvShow);
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tvShow.title} removida!'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'DESFAZER',
          onPressed: () {
            _tvShows.insert(index, tvShow);
            notifyListeners();
          },
        ),
      ),
    );
  }

  void editTvShow(TvShow oldTvShow, TvShow newTvShow, BuildContext context) {
    final index = _tvShows.indexOf(oldTvShow);
    _tvShows[index] = newTvShow;
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Série editada com sucesso!'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
