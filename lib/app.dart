import 'package:cupertiono_store/shopping_cart_tab.dart';
import 'package:cupertiono_store/search_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'product_list_tab.dart';
class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return CupertinoApp(
      home: CupertinoStoreHomePage(),
    );
  }
}

class CupertinoStoreHomePage extends StatelessWidget {
  final BottomNavigationBarItem products = BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Colors.grey,
      ),
      title: Text('Products'),
      activeIcon: Icon(
        CupertinoIcons.home,
      ));
  final BottomNavigationBarItem search = BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.search,
        color: Colors.grey,
      ),
      title: Text('Search'),
      activeIcon: Icon(
        Icons.home,
      ));
  final BottomNavigationBarItem cart = BottomNavigationBarItem(
    icon: Icon(
      CupertinoIcons.shopping_cart,
      color: Colors.grey,
    ),
    title: Text('Cart'),
    activeIcon: Icon(
      Icons.home,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [products, search, cart],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProductListTab(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: SearchTab(),
              );
            });
            break;
            case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ShoppingCartTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
