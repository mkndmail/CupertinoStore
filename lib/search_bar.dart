import 'package:cupertiono_store/styles.dart';
import 'package:flutter/cupertino.dart';

class SearchBar extends StatelessWidget {
  SearchBar({this.controller, this.focusNode});
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.search,
                color: Styles.searchIconColor,
              ),
              Expanded(
                child: CupertinoTextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: Styles.searchText,
                  cursorColor: Styles.searchCursorColor,
                ),
              ),
              GestureDetector(
                onTap: controller.clear,
                child: const Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: Styles.searchIconColor,
                ),
              ),
            ],
          )),
    );
  }
}
