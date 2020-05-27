import 'package:cupertiono_store/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'shopping_cart_item.dart';

const double _kDateTimePickerHeight = 216;

class ShoppingCartTab extends StatefulWidget {
  @override
  _ShoppingCartTabState createState() => _ShoppingCartTabState();
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();
  final _currencyFormat = NumberFormat.currency(symbol: '\$');

  Widget _buildNameField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.person_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Name',
      onChanged: (newName) {
        name = newName;
      },
    );
  }

  Widget _buildEmailField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.mail_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'E-mail',
      keyboardType: TextInputType.emailAddress,
      onChanged: (emailAddress) {
        email = emailAddress;
      },
    );
  }

  Widget _buildLocationField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.location_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Location',
      keyboardType: TextInputType.emailAddress,
      onChanged: (emailAddress) {
        email = emailAddress;
      },
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.lightBackgroundGray,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  'Delivery time',
                  style: Styles.deliveryTimeLabel,
                ),
              ],
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(dateTime),
              style: Styles.deliveryTime,
            ),
          ],
        ),
        Container(
          height: _kDateTimePickerHeight,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            onDateTimeChanged: (newDateTime) {
              setState(() {
                dateTime = newDateTime;
              });
            },
          ),
        ),
      ],
    );
  }

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      AppStateModel model) {
    return SliverChildBuilderDelegate((context, index) {
      final productIndex = index - 4;
      switch (index) {
        case 0:
          return Padding(
            padding: EdgeInsets.all(8),
            child: _buildNameField(),
          );
        case 1:
          return Padding(
            padding: EdgeInsets.all(8),
            child: _buildEmailField(),
          );
        case 2:
          return Padding(
            padding: EdgeInsets.all(8),
            child: _buildLocationField(),
          );
        case 3:
          return Padding(
            padding: EdgeInsets.all(8),
            child: _buildDateAndTimePicker(context),
          );
        default:
          if (model.productsInCart.length > productIndex) {
            return ShoppingCartItem(
              index: index,
              product: model.getProductById(
                model.productsInCart.keys.toList()[productIndex],
              ),
              quantity: model.productsInCart.values.toList().length - 1,
              lastItem: productIndex ==
                  model.productsInCart.values.toList().length - 1,
              formatter: _currencyFormat,
            );
          } else if (model.productsInCart.keys.length == productIndex &&
              model.productsInCart.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Shipping'
                        '${_currencyFormat.format(model.shippingCost)}',
                        style: Styles.productRowItemPrice,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tax ${_currencyFormat.format(model.tax)}',
                        style: Styles.productRowItemPrice,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Total ${_currencyFormat.format(model.totalCost)}',
                        style: Styles.productRowTotal,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Shopping Cart'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(model),
              ),
            ),
          ],
        );
      },
    );
  }
}
