import 'package:crypto_app_project/presentation/detail/detail_favourites/ui/detail_favourites_screen.dart';
import 'package:crypto_app_project/presentation/favourites/ui/favourites_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:crypto_app_project/data/coin_list/api/coin_api.dart';

import 'package:crypto_app_project/data/coin_list/repositories/coin_repository_impl.dart';
import 'package:crypto_app_project/domain/coin_usecase/usecases/coin_usecase.dart';
import 'package:crypto_app_project/presentation/home/bloc/crypto_bloc.dart';
import 'package:crypto_app_project/presentation/home/ui/widgets/navigation_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool? isAscending = false;

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchControler = TextEditingController();
  int? _currentSortColumn;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CryptoBloc(
        CoinUseCase(
          repository: CoinRepositoryImpl(
            coinAPI: CoinAPI(
              Dio()
                ..interceptors.add(
                  PrettyDioLogger(
                    requestHeader: true,
                    requestBody: true,
                    responseBody: true,
                    responseHeader: false,
                    error: true,
                    compact: true,
                    maxWidth: 90,
                  ),
                ),
            ),
          ),
        ),
      )..add(LoadSearchEvent()),
      child: BlocConsumer<CryptoBloc, CryptoState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case SortRankState:
              _currentSortColumn = 1;
              break;
            case SortNameState:
              _currentSortColumn = 2;
              break;
          }
        },
        builder: (context, state) {
          if (state is SearchSuccessState || state is SearchResult) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF5F627D),
                    Color(0xFF313347),
                  ],
                ),
              ),
              child: Scaffold(
                drawer: NavigationDrawerWidget(),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    'Crypto Coin',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          context
                              .read<CryptoBloc>()
                              .add(OnSearchEvent(query: value));
                        },
                        controller: _searchControler,
                        decoration: InputDecoration(
                          hintText: 'Search Coin',
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                    if (state is SearchSuccessState) ...[
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: DataTable(
                              sortAscending: isAscending!,
                              sortColumnIndex: _currentSortColumn,
                              columns: <DataColumn>[
                                const DataColumn(
                                  label: Center(
                                      child: Text(
                                    'ID',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  tooltip: 'ID of crypto',
                                ),
                                DataColumn(
                                    label: const Text(
                                      'Rank',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    tooltip: 'Rank of crypto',
                                    numeric: true,
                                    onSort: (columnIndex, _) {
                                      isAscending = !isAscending!;
                                      setState(() {});
                                      context.read<CryptoBloc>().add(
                                          SortRankEvent(isAscending!,
                                              state.listcurrency));
                                    }),
                                DataColumn(
                                  label: const Text(
                                    'Name',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  tooltip: 'Name of crypto',
                                  onSort: (columnIndex, _) {
                                    isAscending = !isAscending!;
                                    setState(() {});
                                    context.read<CryptoBloc>().add(
                                        SortNameEvent(
                                            isAscending!, state.listcurrency));
                                  },
                                ),
                                DataColumn(
                                  label: const Text(
                                    'Price',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  tooltip: 'Price of crypto',
                                  onSort: (columnIndex, _) {
                                    isAscending = !isAscending!;
                                    setState(() {});
                                    context.read<CryptoBloc>().add(
                                        SortPriceEvent(
                                            isAscending!, state.listcurrency));
                                  },
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                state.listcurrency.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              child: state.listcurrency
                                                      .elementAt(index)
                                                      .logoUrl!
                                                      .endsWith('.svg')
                                                  ? SvgPicture.network(state
                                                      .listcurrency
                                                      .elementAt(index)
                                                      .logoUrl!)
                                                  : Image.network(state
                                                      .listcurrency
                                                      .elementAt(index)
                                                      .logoUrl!),
                                            ),
                                            const SizedBox(width: 10),
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.listcurrency
                                                        .elementAt(index)
                                                        .id!,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        state.listcurrency
                                                            .elementAt(index)
                                                            .the1D!
                                                            .priceChangePct!,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: double.parse(state
                                                                        .listcurrency
                                                                        .elementAt(
                                                                            index)
                                                                        .the1D!
                                                                        .priceChangePct!) >
                                                                    0
                                                                ? Colors.green
                                                                : Colors.red),
                                                      ),
                                                      Icon(
                                                          double.parse(state
                                                                      .listcurrency
                                                                      .elementAt(
                                                                          index)
                                                                      .the1D!
                                                                      .priceChangePct!) >
                                                                  0
                                                              ? Icons
                                                                  .arrow_drop_up
                                                              : Icons
                                                                  .arrow_drop_down,
                                                          color: double.parse(state
                                                                      .listcurrency
                                                                      .elementAt(
                                                                          index)
                                                                      .the1D!
                                                                      .priceChangePct!) >
                                                                  0
                                                              ? Colors.green
                                                              : Colors.red),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ]),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailFavouritesScreen(
                                                  id: state.listcurrency
                                                      .elementAt(index)
                                                      .id
                                                      .toString()),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                        state.listcurrency
                                            .elementAt(index)
                                            .rank!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailFavouritesScreen(
                                                  id: state.listcurrency
                                                      .elementAt(index)
                                                      .id
                                                      .toString()),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        state.listcurrency
                                            .elementAt(index)
                                            .name!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailFavouritesScreen(
                                                  id: state.listcurrency
                                                      .elementAt(index)
                                                      .id
                                                      .toString()),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        double.parse(state.listcurrency
                                                .elementAt(index)
                                                .price!)
                                            .toStringAsFixed(3),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailFavouritesScreen(
                                                  id: state.listcurrency
                                                      .elementAt(index)
                                                      .id
                                                      .toString()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                    if (state is SearchResult) ...[],
                  ],
                ),
              ),
            );
          } else if (state is SearchLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is SearchFailureState) {
            return Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  // ignore: prefer_const_constructors
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: [
                      const Color(0xFF5F627D),
                      const Color(0xFF313347),
                    ],
                  ),
                ),
                child: Scaffold(
                    drawer: NavigationDrawerWidget(),
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: const Text(
                        'Crypto Coin',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    body: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            context
                                .read<CryptoBloc>()
                                .add(OnSearchEvent(query: value));
                          },
                          controller: _searchControler,
                          decoration: InputDecoration(
                            hintText: 'Search Coin',
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Column(
                          children: [
                            Image.asset('assets/images/error.png'),
                            const Text(
                              'Please re-enter the search!',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
