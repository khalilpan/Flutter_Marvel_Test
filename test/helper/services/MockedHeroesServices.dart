import 'package:http/http.dart';
import 'package:marvel/services/marvel_service.dart';

enum MockedState { success, error }

class MockedHeroesService implements MarvelService {
  MockedState state;

  MockedHeroesService({this.state = MockedState.success});

  Future _fetchAllHeroesWithSuccess() {
    Future<dynamic> future = Future<dynamic>(() {
      var list = [
        {"name": "3-D MAN", "url": "3-D MAN test"},
        {"name": "3-D MAN", "url": "3-D MAN test"},
        {"name": "3-D MAN", "url": "3-D MAN test"},
        {"name": "3-D MAN", "url": "3-D MAN test"},
        {"name": "3-D MAN", "url": "3-D MAN test"},
      ];

      Map<String, dynamic> json = {"results": list};
      return json;
    });

    return future;
  }

  _fetchAllHeroesWithError() {
    return Future.error("404");
  }

  @override
  Future<Response> fetchAllMavel() {
    switch (state) {
      case MockedState.success:
        return _fetchAllHeroesWithSuccess();
        break;
      case MockedState.error:
        return _fetchAllHeroesWithError();
        break;
        throw UnimplementedError();
    }
  }

  @override
  Future<Response> fetchAllMavelWithId(String id) {
    throw UnimplementedError();
  }

  // @override
  // Future fetchAllKantoPokemon() {
  //   switch (state) {
  //     case MockedState.success:
  //       return _fetchAllPokemonWithSuccess();
  //       break;
  //     case MockedState.error:
  //       return _fetchAllPokemonWithError();
  //       break;
  //   }

  //   return null;
  // }

  // @override
  // Future<Response> fetchPokemonWithName({String name}) {
  //   throw UnimplementedError();
  // }

  @override
  String imageNameForID({String id}) {
    return id;
  }
}
