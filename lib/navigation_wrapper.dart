import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationWrapper extends StatelessWidget {
  final Widget child;
  const NavigationWrapper({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/top')) return 0;
    if (location.startsWith('/best')) return 1;
    if (location.startsWith('/new')) return 2;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/top');
        break;
      case 1:
        context.go('/best');
        break;
      case 2:
        context.go('/new');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _onTap(context, index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.trending_up), label: 'Top'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Best'),
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
        ],
      ),
    );
  }
}
