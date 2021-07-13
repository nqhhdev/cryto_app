import 'package:crypto_app_project/data/coin_list/api/coin_api.dart';
import 'package:crypto_app_project/data/coin_list/repositories/coin_repository_impl.dart';
import 'package:crypto_app_project/domain/coin_usecase/usecases/coin_usecase.dart';
import 'package:crypto_app_project/presentation/detail/detail_favourites/bloc/detail_favourites_bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class DetailFavouritesScreen extends StatefulWidget {
  DetailFavouritesScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  String id;

  @override
  _DetailFavouritesScreenState createState() => _DetailFavouritesScreenState();
}

class _DetailFavouritesScreenState extends State<DetailFavouritesScreen> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return _detailWidget();
  }

  Widget _detailWidget() {
    return BlocProvider(
      create: (context) => DetailFavouritesBloc(
        CoinUseCase(
          repository: CoinRepositoryImpl(
            coinAPI: CoinAPI(Dio(BaseOptions(
              connectTimeout: 5000,
            ))),
          ),
        ),
      )..add(
          LoadDetailFavouritesEvent(id: widget.id),
        ),
      child: Container(
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Your Coins'),
          ),
          body: Container(
            child: BlocConsumer<DetailFavouritesBloc, DetailFavouritesState>(
              listener: (previouspre, state) {
                if (state is AddingFavoriteState) {
                } else if (state is AddFavoriteFailState) {
                  print('a');
                  const snackBar =
                      SnackBar(content: Text('Add Favorites Fail'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (state is AddFavoriteSuccessState) {
                  print('b');
                  const snackBar =
                      SnackBar(content: Text('Add Favorites Success'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              buildWhen: (previous, current) =>
                  current is! AddFavoriteFailState ||
                  current is! AddingFavoriteState ||
                  current is! AddFavoriteSuccessState,
              builder: (context, state) {
                if (state is LoadingDetailFavouritesState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadDetailFavouritesFailState) {
                  return const Center(
                    child: Text("Load Error"),
                  );
                } else if (state is LoadDetailFavouritesSuccessStatee) {
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.002),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 24),
                              width: double.infinity,
                              height: 300,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                // ignore: prefer_const_literals_to_create_immutables
                                boxShadow: [
                                  const BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 10,
                                    color: Colors.black54,
                                    spreadRadius: -5,
                                  )
                                ],
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF08AEEA),
                                    Color(0xFF2AF598),
                                  ],
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 1.35,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(18),
                                          ),
                                          color: Color(0xff232d37)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 18.0,
                                            left: 12.0,
                                            top: 24,
                                            bottom: 12),
                                        child: LineChart(
                                          LineChartData(
                                            gridData: FlGridData(
                                              show: true,
                                              drawVerticalLine: true,
                                              getDrawingHorizontalLine:
                                                  (value) {
                                                return FlLine(
                                                  color:
                                                      const Color(0xff37434d),
                                                  strokeWidth: 1,
                                                );
                                              },
                                              getDrawingVerticalLine: (value) {
                                                return FlLine(
                                                  color:
                                                      const Color(0xff37434d),
                                                  strokeWidth: 1,
                                                );
                                              },
                                            ),
                                            titlesData: FlTitlesData(
                                              show: true,
                                              bottomTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 22,
                                                getTextStyles: (value) =>
                                                    const TextStyle(
                                                        color:
                                                            Color(0xff68737d),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                getTitles: (value) {
                                                  switch (value.toInt()) {
                                                    case 0:
                                                      return 'Mon';
                                                    case 1:
                                                      return 'Tue';
                                                    case 2:
                                                      return 'Wed';
                                                    case 3:
                                                      return 'Thu';
                                                    case 4:
                                                      return 'Fri';
                                                    case 5:
                                                      return 'Sat';
                                                    case 6:
                                                      return 'Sun';
                                                  }
                                                  return '';
                                                },
                                                margin: 8,
                                              ),
                                              leftTitles: SideTitles(
                                                showTitles: true,
                                                getTextStyles: (value) =>
                                                    const TextStyle(
                                                  color: Color(0xff67727d),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                                getTitles: (value) {
                                                  switch (value.toInt()) {
                                                    case 1:
                                                      return '10k';
                                                    case 3:
                                                      return '30k';
                                                    case 5:
                                                      return '50k';
                                                  }
                                                  return '';
                                                },
                                                reservedSize: 28,
                                                margin: 12,
                                              ),
                                            ),
                                            borderData: FlBorderData(
                                                show: true,
                                                border: Border.all(
                                                    color:
                                                        const Color(0xff37434d),
                                                    width: 1)),
                                            minX: 0,
                                            maxX: 7,
                                            minY: state.minY,
                                            maxY: state.maxY,
                                            lineBarsData: [
                                              LineChartBarData(
                                                spots: [
                                                  FlSpot(
                                                      0,
                                                      double.parse(state
                                                              .listChart
                                                              ?.elementAt(0)
                                                              .prices
                                                              .elementAt(0)
                                                              .toString() ??
                                                          "0.0")),
                                                  FlSpot(
                                                      1,
                                                      double.parse(state
                                                              .listChart
                                                              ?.elementAt(0)
                                                              .prices
                                                              .elementAt(1)
                                                              .toString() ??
                                                          "0.0")),
                                                  FlSpot(
                                                      2,
                                                      double.parse(state
                                                              .listChart
                                                              ?.elementAt(0)
                                                              .prices
                                                              .elementAt(2)
                                                              .toString() ??
                                                          "0.0")),
                                                  FlSpot(
                                                      3,
                                                      double.parse(state
                                                              .listChart
                                                              ?.elementAt(0)
                                                              .prices
                                                              .elementAt(3)
                                                              .toString() ??
                                                          "0.0")),
                                                  FlSpot(
                                                      4,
                                                      double.parse(state
                                                              .listChart
                                                              ?.elementAt(0)
                                                              .prices
                                                              .elementAt(4)
                                                              .toString() ??
                                                          "0.0")),
                                                  FlSpot(
                                                      5,
                                                      double.parse(state
                                                              .listChart
                                                              ?.elementAt(0)
                                                              .prices
                                                              .elementAt(5)
                                                              .toString() ??
                                                          "0.0")),
                                                  FlSpot(
                                                      6,
                                                      double.parse(state
                                                              .listChart
                                                              ?.elementAt(0)
                                                              .prices
                                                              .elementAt(6)
                                                              .toString() ??
                                                          "0.0")),
                                                  FlSpot(
                                                      7,
                                                      double.parse(state
                                                              .listChart
                                                              ?.elementAt(0)
                                                              .prices
                                                              .elementAt(7)
                                                              .toString() ??
                                                          "0.0")),
                                                ],
                                                isCurved: true,
                                                colors: gradientColors,
                                                barWidth: 5,
                                                isStrokeCapRound: true,
                                                dotData: FlDotData(
                                                  show: true,
                                                ),
                                                belowBarData: BarAreaData(
                                                  show: true,
                                                  colors: gradientColors
                                                      .map((color) => color
                                                          .withOpacity(0.3))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                // ignore: sized_box_for_whitespace
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child: CircleAvatar(
                                            child: state.listcoin!
                                                    .elementAt(0)
                                                    .logoUrl!
                                                    .endsWith('.svg')
                                                ? SvgPicture.network(state
                                                    .listcoin!
                                                    .elementAt(0)
                                                    .logoUrl!)
                                                : Image.network(state.listcoin!
                                                    .elementAt(0)
                                                    .logoUrl!),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Add Favorites',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      IconButton(
                                        color: Colors.red,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        icon: Stack(children: [
                                          const SizedBox(
                                            width: 8,
                                            height: 8,
                                          ),
                                          const Icon(Icons.favorite_rounded),
                                        ]),
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) =>
                                                AlertDialog(
                                              title: const Text(
                                                  "Want to add Favorites?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(dialogContext)
                                                        .pop();
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());
                                                    context
                                                        .read<
                                                            DetailFavouritesBloc>()
                                                        .add(AddFavoriteEvent(
                                                          email: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .email
                                                              .toString(),
                                                          id: widget.id,
                                                        ));
                                                    Navigator.of(dialogContext)
                                                        .pop();
                                                  },
                                                  child: const Text('Ok'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Divider(color: Colors.white70),
                                const SizedBox(height: 20),
                                // ignore: avoid_unnecessary_containers
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Status',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        state.listcoin!
                                            .elementAt(0)
                                            .status
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Price Timstamp",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.listcoin!
                                          .elementAt(0)
                                          .priceTimestamp
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Rank",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.listcoin!
                                          .elementAt(0)
                                          .rank
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Price",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      double.parse(state.listcoin!
                                              .elementAt(0)
                                              .price!)
                                          .toStringAsFixed(3),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Market Cap Dominance",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.listcoin!
                                          .elementAt(0)
                                          .marketCapDominance
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Divider(color: Colors.white70),
                                const SizedBox(height: 20),
                                Center(
                                  child: Text(
                                    'The One Hour',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Price Change PCT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.listcoin!
                                          .elementAt(0)
                                          .the1H!
                                          .priceChangePct
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: double.parse(state.listcoin!
                                                    .elementAt(0)
                                                    .the1H!
                                                    .priceChangePct!) >
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Volume Change PCT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.listcoin!
                                          .elementAt(0)
                                          .the1H!
                                          .volumeChangePct
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: double.parse(state.listcoin!
                                                    .elementAt(0)
                                                    .the1H!
                                                    .volumeChangePct!) >
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Market Cap Change PCT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.listcoin!
                                          .elementAt(0)
                                          .the1H!
                                          .marketCapChangePct
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: double.parse(state.listcoin!
                                                    .elementAt(0)
                                                    .the1H!
                                                    .marketCapChangePct!) >
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Divider(color: Colors.white70),
                                const SizedBox(height: 20),
                                Center(
                                  child: Text(
                                    'The One Day',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Price Change PCT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.listcoin!
                                          .elementAt(0)
                                          .the1H!
                                          .priceChangePct
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: double.parse(state.listcoin!
                                                    .elementAt(0)
                                                    .the1D!
                                                    .priceChangePct!) >
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Volume Change PCT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.listcoin!
                                          .elementAt(0)
                                          .the1D!
                                          .volumeChangePct
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: double.parse(state.listcoin!
                                                    .elementAt(0)
                                                    .the1D!
                                                    .volumeChangePct!) >
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Market Cap Change PCT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      state.listcoin!
                                          .elementAt(0)
                                          .the1D!
                                          .marketCapChangePct
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: double.parse(state.listcoin!
                                                    .elementAt(0)
                                                    .the1D!
                                                    .marketCapChangePct!) >
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: Text('hihih'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
