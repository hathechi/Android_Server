import 'package:flutter/material.dart';
import 'package:flutter_sever/screens/pages/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  final _currentPage = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          _currentPage.value = index;
        },
        children: [
          widget.userName != null
              ? HomePage(userName: widget.userName)
              : Center(
                  child: Text('HOME'),
                ),
          Center(
            child: Text('CART'),
          ),
          Center(
            child: Text('LIKE'),
          ),
          Center(
            child: Text('PROFILE'),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (context, value, child) {
            return SalomonBottomBar(
                currentIndex: value,
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(FontAwesomeIcons.house),
                    title: const Text('Home'),
                    selectedColor: const Color.fromARGB(255, 2, 2, 2),
                    unselectedColor: const Color.fromARGB(255, 161, 161, 161),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(FontAwesomeIcons.cartShopping),
                    title: const Text('Cart'),
                    selectedColor: const Color.fromARGB(255, 2, 2, 2),
                    unselectedColor: const Color.fromARGB(255, 161, 161, 161),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(FontAwesomeIcons.solidHeart),
                    title: const Text('Likes'),
                    selectedColor: const Color.fromARGB(255, 2, 2, 2),
                    unselectedColor: const Color.fromARGB(255, 161, 161, 161),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(FontAwesomeIcons.solidUser),
                    title: const Text('Profile'),
                    selectedColor: const Color.fromARGB(255, 2, 2, 2),
                    unselectedColor: const Color.fromARGB(255, 161, 161, 161),
                  ),
                ]);
          }),
    );
  }
}
