import 'package:crypto_app_project/data/coin_list/api/coin_api.dart';
import 'package:crypto_app_project/data/coin_list/repositories/coin_repository_impl.dart';
import 'package:crypto_app_project/domain/coin_usecase/usecases/coin_usecase.dart';
import 'package:crypto_app_project/presentation/detail/detail_favourites/ui/detail_favourites_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:crypto_app_project/presentation/favourites/bloc/favourites_bloc.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  get children => null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FavouritesBloc(
        CoinUseCase(
          repository: CoinRepositoryImpl(
            coinAPI: CoinAPI(Dio()),
          ),
        ),
      )..add(LoadFavoriteEvent(
          email: FirebaseAuth.instance.currentUser!.email.toString())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
          centerTitle: true,
          backgroundColor: Colors.blue[100],
        ),
        body: Container(
          child: Column(
            children: [
              BlocConsumer<FavouritesBloc, FavouritesState>(
                listener: (previous, state) {
                  if (state is DeleteFavoriteSuccessState) {
                    const snackBar = SnackBar(content: Text('Success'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  if (state is DeleteFavoriteFailState) {
                    const snackBar = SnackBar(content: Text('Fail'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                // buildWhen: (previous, state) {
                //   if (state is DeleteFavoriteFailState ||
                //       state is DeleteFavoriteSuccessState) {
                //     return false;
                //   }
                //   return true;
                // },
                builder: (context, state) {
                  if (state is FavoriteLoadingSuccessState) {
                    return Container(
                      child: Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.listCoin.length,
                          itemBuilder: (context, index) => ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailFavouritesScreen(
                                    id: state.listCoin
                                        .elementAt(index)
                                        .id
                                        .toString()),
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF5B300),
                                  ),
                                  child: CircleAvatar(
                                    child: state.listCoin
                                            .elementAt(index)
                                            .logoUrl!
                                            .endsWith('.svg')
                                        ? SvgPicture.network(state.listCoin
                                            .elementAt(index)
                                            .logoUrl!)
                                        : Image.network(state.listCoin
                                            .elementAt(index)
                                            .logoUrl!),
                                  ),
                                ),
                                Expanded(
                                  // flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          state.listCoin
                                              .elementAt(index)
                                              .id
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          state.listCoin
                                              .elementAt(index)
                                              .the1H!
                                              .priceChangePct
                                              .toString(),
                                          style: TextStyle(
                                            color: double.parse(state.listCoin
                                                        .elementAt(index)
                                                        .the1D!
                                                        .priceChangePct!) >
                                                    0
                                                ? Colors.green
                                                : Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Price:',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          double.parse(state.listCoin
                                                      .elementAt(index)
                                                      .price!)
                                                  .toStringAsFixed(2) +
                                              " \$",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) => AlertDialog(
                                          title: const Text("Want to delete?"),
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
                                                    .requestFocus(FocusNode());
                                                context
                                                    .read<FavouritesBloc>()
                                                    .add(
                                                      DeleteFavoriteEvent(
                                                        email: FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .email
                                                            .toString(),
                                                        id: state.listCoin
                                                            .elementAt(index)
                                                            .id
                                                            .toString(),
                                                      ),
                                                    );
                                                Navigator.of(dialogContext)
                                                    .pop();
                                              },
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                      // context.read<FavouritesBloc>().add(
                                      //     LoadFavoriteEvent(
                                      //         email: FirebaseAuth
                                      //             .instance.currentUser!.email
                                      //             .toString()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is FavoriteLoadingFailState) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (state is FavoriteLoadingState) {
                    return Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    return Container(
                      child: Column(
                        children: [
                          Image.asset('assets/images/error.png'),
                          Center(
                            child: const Text(
                              'List is empty!',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
