import 'package:flutter/material.dart';

import '../../../global/components/stroke_text.dart';
import '../../../global/constants/design_constants.dart';
import '../../../global/extensions/shadow_ext.dart';
import '../../../global/extensions/text_style_ext.dart';
import '../../../models/module_response.dart';

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
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: widget.headerImage,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: StrokeText(
                widget.headerTitle,
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                strokeColor: widget.themeColor,
                strokeWidth: 10,
              ),
            ),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.themeColor.withOpacity(0.2),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                ),
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: screenSize.width / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  padding: const EdgeInsets.all(25),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            DesignConstants.defaultCornerRadius,
                          ),
                        ),
                        boxShadow: [BoxShadowExt.defaultShadow()],
                      ),
                      child: FilledButton(
                        onPressed: () => widget.onPressed(categories[index]),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              widget.themeColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  DesignConstants.defaultCornerRadius),
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: widget.icon,
                            ),
                            // const Spacer(),
                            Text(
                              categories[index].title,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyleExt.notoSansArabic(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  shadows: [ShadowExt.textShadow()],
                                ),
                              ),
                            ),
                            // const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
