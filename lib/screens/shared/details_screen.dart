import 'package:enhanced_paginated_view/enhanced_paginated_view.dart';
import 'package:flutter/material.dart';
import 'package:shepherd_voice/global/constants/design_constants.dart';
import 'package:shepherd_voice/global/extensions/shadow_ext.dart';
import 'package:shepherd_voice/screens/shared/list_item.dart';

import '../../global/constants/domain_constants.dart';
import '../../global/extensions/text_style_ext.dart';
import '../../models/module_name.dart';
import '../../models/module_response.dart';

typedef RequestCallback = Future<List<ModuleResponse>> Function(
    {required int page});

class DetailsWidget extends StatefulWidget {
  final ModuleName module;
  final Widget icon;
  final RequestCallback apiCall;
  final String headerTitle;
  final Widget headerImage;
  final Color themeColor;
  final void Function(ModuleResponse item) onPressed;

  const DetailsWidget({
    super.key,
    required this.module,
    required this.icon,
    required this.apiCall,
    required this.headerTitle,
    required this.headerImage,
    required this.themeColor,
    required this.onPressed,
  });

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  static const _pageSize = Constants.pageSize;

  bool isLoading = false;
  bool isMaxReached = false;
  bool showError = false;

  List<ModuleResponse> films = [];

  Future<void> loadMore(int page) async {
    Future.microtask(() => setState(() => isLoading = true));

    final filmsResponse = await widget.apiCall(page: page);

    Future.microtask(
      () => setState(
        () {
          if (filmsResponse.length < _pageSize) {
            isMaxReached = true;
          }

          films.addAll(filmsResponse);
          isLoading = false;
        },
      ),
    );
  }

  /// remove an item from the list
  void removeItem(int index) => setState(() => films.removeAt(index));

  @override
  void initState() {
    super.initState();
    loadMore(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: EnhancedPaginatedView(
          listOfData: films,
          showLoading: isLoading,
          isMaxReached: isMaxReached,
          onLoadMore: loadMore,
          itemsPerPage: _pageSize,

          /// [showError] is a boolean that will be used
          /// to control the error widget
          /// this boolean will be set to true when an error occurs
          showError: showError,
          errorWidget: (page) => Center(
            child: Column(
              children: [
                const Text('No items found'),
                ElevatedButton(
                  onPressed: () {
                    showError = false;
                    loadMore(page);
                  },
                  child: const Text('Reload'),
                )
              ],
            ),
          ),
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.headerImage,
                const SizedBox(height: 15),
                Text(
                  widget.headerTitle,
                  textAlign: TextAlign.center,
                  style: TextStyleExt.notoSansArabic(
                    textStyle: TextStyle(
                      color: widget.themeColor,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      shadows: [ShadowExt.textShadow()],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          builder: (physics, items, shrinkWrap, reverse) {
            return ListView.builder(
              // here we must pass the physics, items and shrinkWrap
              // that came from the builder function
              reverse: reverse,
              physics: physics,
              shrinkWrap: shrinkWrap,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignConstants.listItemHorizontalPadding,
                    vertical: 10,
                  ),
                  child: ListItem(
                    title: items[index].title,
                    titleColor: Colors.black,
                    icon: widget.icon,
                    backgroundColor: widget.themeColor.withOpacity(0.25),
                    onPressed: () {
                      widget.onPressed(items[index]);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
