import 'package:flutter/material.dart';

import '../../global/constants/design_constants.dart';
import '../../global/extensions/shadow_ext.dart';
import '../../global/extensions/text_style_ext.dart';
import '../../models/module_response.dart';

typedef RequestCallback = Future<List<ModuleResponse>> Function(
    {required int page});

class CategoryWidget extends StatefulWidget {
  final Widget headerImage;
  final String headerTitle;
  final Widget icon;
  final Color themeColor;
  final int crossAxisCount;

  final RequestCallback apiCall;
  final void Function(ModuleResponse item) onPressed;

  const CategoryWidget({
    super.key,
    required this.icon,
    required this.apiCall,
    required this.headerTitle,
    required this.headerImage,
    required this.themeColor,
    required this.onPressed,
    required this.crossAxisCount,
  });

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool isLoading = false;
  bool isMaxReached = false;
  bool showError = false;

  List<ModuleResponse> categories = [];

  Future<void> loadMore(int page) async {
    Future.microtask(() => setState(() => isLoading = true));

    final response = await widget.apiCall(page: page);

    Future.microtask(
      () => setState(
        () {
          categories.addAll(response);
          isLoading = false;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadMore(1);
    // initList.addAll(item1);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: categories.length,
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: widget.crossAxisCount),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: screenSize.width / 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
          ),
          padding: const EdgeInsets.all(25),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(DesignConstants.defaultCornerRadius),
                ),
                boxShadow: [BoxShadowExt.defaultShadow()],
              ),
              child: FilledButton(
                onPressed: () => widget.onPressed(categories[index]),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(widget.themeColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          DesignConstants.defaultCornerRadius),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      widget.icon,
                      const Spacer(),
                      Expanded(
                        child: Text(
                          categories[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyleExt.notoSansArabic(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              shadows: [ShadowExt.textShadow()],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
            return Card(
              child: GridTile(
                footer: Text(categories[index].title),
                child: Text(categories[index].title),
              ),
            );
          },
        ),
      ),
    );
  }
}
