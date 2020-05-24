import 'dart:convert';

import 'package:marvel/models/heroes.dart';
import 'package:marvel/services/marvel_service.dart';

enum MarvelListState { feededDatasource, error, loading }

class HeroesListViewModel {
  Function didUpdate;

  List<AllHeroesReponse> dataSource = [];
  String navigationTitle = "HEROES";
  final MarvelService service;

  HeroesListViewModel({this.didUpdate, this.service});

  dataSourceHeroes(MarvelService marvelService) {
    marvelService.fetchAllMavel().then((response) {
      var json = jsonDecode(response.body);
      List<AllHeroesReponse> heroesList = [];
      var list = json["data"]["results"];
      if (list != null) {
        for (var heroesJson in list) {
          var heroesResponse = AllHeroesReponse.fromMappedJson(heroesJson);
          heroesList.add(heroesResponse);
        }
        dataSource = heroesList;
        didUpdate();
      }
    });
  }

  String toUpperCase(String value) {
    if (value == null) {
      return "null";
    }
    return value.toUpperCase();
  }

  String extractID(String url) {
    if (!url.contains("/")) {
      return "error";
    }

    var split = url.toString().split("/");
    split.removeLast();
    return split.last;
  }

  MarvelListState state;

  Future feedDataSource() async {
    state = MarvelListState.loading;
    _updateIfNeeded();

    return service.fetchAllMavel().then((json) {
      List<AllHeroesReponse> HeroesList = [];
      // var list = json["results"];
      var list = new List();

      if (list != null) {
        for (var HeroesJson in list) {
          var HeroesResponse = AllHeroesReponse.fromMappedJson(HeroesJson);

          if (HeroesJson["url"] != null) {
            var id = extractID(HeroesJson["url"]);
            HeroesResponse.name = service.imageNameForID(id: id);
          }

          HeroesList.add(HeroesResponse);
        }

        dataSource = HeroesList;
        state = MarvelListState.feededDatasource;
        _updateIfNeeded();
      }
    }).catchError((error) {
      state = MarvelListState.error;
      _updateIfNeeded();
      print(error);
    });
  }

  void _updateIfNeeded() {
    if (didUpdate != null) {
      didUpdate();
    }
  }
}
