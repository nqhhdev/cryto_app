import 'package:crypto_app_project/presentation/home/ui/home_screen.dart';
import 'package:crypto_app_project/presentation/favourites/ui/favourites_screen.dart';

import 'package:crypto_app_project/presentation/logout/bloc/logout_bloc.dart';
import 'package:crypto_app_project/presentation/splash/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: use_key_in_widget_constructors
class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    LogoutBloc? logoutBloc;

    logoutBloc = BlocProvider.of<LogoutBloc>(context);
    return BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogOutSucced) {
            const snackBar = SnackBar(content: Text('Out Account'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Drawer(
          child: Container(
            color: Colors.blueGrey,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: padding,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      buildMenuItem(
                        text: 'Favourites',
                        icon: Icons.favorite_border,
                        onClicked: () => selectedItem(context, 1),
                      ),
                      const SizedBox(height: 16),
                      buildMenuItem(
                        text: 'Updates',
                        icon: Icons.update,
                        onClicked: () => selectedItem(context, 0),
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: Colors.white70),
                      const SizedBox(height: 16),
                      buildMenuItem(
                          text: 'LogOut',
                          icon: Icons.logout_outlined,
                          onClicked: () {
                            logoutBloc!.add(LogOutEvent());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SplashScreen()));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));

        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavouritesScreen(),
        ));
        break;
    }
  }
}
