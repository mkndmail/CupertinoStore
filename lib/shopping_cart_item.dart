import 'package:cupertiono_store/model/product.dart';
import 'package:cupertiono_store/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    this.index,
    this.product,
    this.quantity,
    this.lastItem,
    this.formatter,
  });
  final int index;
  final Product product;
  final int quantity;
  final bool lastItem;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 8,
          bottom: 8,
          right: 8,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: Styles.productRowItemName,
                        ),
                        Text(
                          '${formatter.format(quantity * product.price)}',
                          style: Styles.productRowItemName,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${quantity > 1 ? '$quantity x' : ''}'
                      '${formatter.format(product.price)}',
                      style: Styles.productRowItemPrice,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    return row;
  }
}
