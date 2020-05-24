import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/heroes_list/HeroesListViewModel.dart';
import 'package:marvel/services/marvel_service.dart';

import 'helper/services/MockedHeroesServices.dart';

void main() {

  
  HeroesListViewModel viewModel;
  MarvelService service;

  setUpAll(() {
    service = MarvelServiceImpl();
    viewModel = HeroesListViewModel(service: service);
  });

  tearDownAll(() {
    service = null;
    viewModel = null;
  });

  test('Empty state', () {
    expect(viewModel.dataSource.isEmpty, true);
    expect(viewModel.navigationTitle, "HEROES");
    expect(viewModel.didUpdate, null);
    expect(viewModel.service, service);
  });

  test('Upper case emtpy string', () {
    String lowercasedString = "";
    expect(viewModel.toUpperCase(lowercasedString), "");
  });

  test('Upper case lowercased string', () {
    String lowercasedString = "lowercased";
    expect(viewModel.toUpperCase(lowercasedString), "LOWERCASED");
  });

  test('Upper case uppercased string', () {
    String uppercasedString = "UPPERCASED";
    expect(viewModel.toUpperCase(uppercasedString), uppercasedString);
  });

  test('Upper case null string', () {
    String nullString;
    expect(viewModel.toUpperCase(nullString), "null");
  });

  test('Extract id from correct url', () {
    var url = "www.google.com/pokemon/1/png";
    expect(viewModel.extractID(url), "1");
  });

  test('Extract id from incorrect url', () {
    var url = "incorrect url";
    expect(viewModel.extractID(url), "error");
  });

  test('Feed data source with real network', () async {
    int didUpdated = 0;

    viewModel.didUpdate = () {
      didUpdated++;
      didUpdated++;
    };

    await viewModel.feedDataSource();
    expect(viewModel.state, MarvelListState.feededDatasource);

    expect(viewModel.dataSource.length, 151);
    expect(didUpdated, 2);
  });

  test('Feed data source with mocked network', () async {
    int didUpdated = 0;
    viewModel = HeroesListViewModel(service: MockedHeroesService());

    viewModel.didUpdate = () {
      didUpdated++;
    };

    await viewModel.feedDataSource();
    expect(viewModel.state, MarvelListState.feededDatasource);

    expect(viewModel.dataSource.length, 5);
    expect(didUpdated, 2);
  });

  test('Did update for loading state', () {
    viewModel = HeroesListViewModel(service: MockedHeroesService());
    viewModel.feedDataSource();
    expect(viewModel.state, MarvelListState.loading);
  });

  test('Did update for error state', () async {
    int didUpdated = 0;

    final service = MockedHeroesService(state: MockedState.error);
    viewModel = HeroesListViewModel(service: service);

    viewModel.didUpdate = () {
      didUpdated++;
    };

    await viewModel.feedDataSource();

    expect(viewModel.state, MarvelListState.error);
    expect(didUpdated, 2);
  });

}
