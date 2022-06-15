import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:june_design_challenges/pages_data.dart';
import 'package:june_design_challenges/widgets/custom_expansion_panel.dart';
import 'package:url_launcher/url_launcher.dart';

const appBarColor = Color(0xFF3949ab);
const textColor = Color(0xFF284778);
const fadedTextColor = Colors.black54;
const selectedPanelColor = Color.fromARGB(255, 220, 220, 220);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<bool> expandableList = [];

  @override
  void initState() {
    super.initState();

    init();
  }

  init() {
    for (int i = 0; i < pages.length; i++) {
      expandableList.add(false);
    }
    expandableList[0] = true;
  }

  void onExpand(int panelIndex, bool isExpanded) {
    for (var i = 0; i < expandableList.length; i++) {
      if (expandableList[i]) {
        expandableList[i] = false;
      }
    }

    setState(() {
      expandableList[panelIndex] = !isExpanded;
    });
  }

  int get currentPage => expandableList.indexWhere((e) => e);
  double maxWidth(double width) {
    if (width < 500) {
      return width;
    }

    if (width > 900) return 450;

    return width / 2;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isMobile = size.width < 500;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Design Challenges',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: size.width,
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth: maxWidth(size.width),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: CustomExpansionPanelList(
                      elevation: 4.0,
                      expandedHeaderPadding: const EdgeInsets.only(bottom: 2),
                      expansionCallback: onExpand,
                      icon: isMobile ? Icons.expand_more : null,
                      children: List.generate(pages.length, (i) {
                        final page = pages[i];

                        return CustomExpansionPanel(
                          canTapOnHeader: true,
                          backgroundColor: expandableList[i]
                              ? selectedPanelColor
                              : Colors.white,
                          headerBuilder: (context, isExpanded) {
                            return PageTile(pageData: page);
                          },
                          // body: _PageDescription(page: page),
                          body: Center(
                            child: isMobile
                                ? _PageDescription(
                                    page: page,
                                    isMobile: isMobile,
                                  )
                                : null,
                          ),
                          isExpanded: expandableList[i],
                        );
                      }),
                    ),
                  ),
                ),
              ),
              if (!isMobile)
                Expanded(
                  child: _PageDescription(
                    page: currentPage == -1 ? null : pages[currentPage],
                    isMobile: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageDescription extends StatelessWidget {
  const _PageDescription({
    Key? key,
    required this.page,
    required this.isMobile,
  }) : super(key: key);

  final PageData? page;
  final bool isMobile;

  static const style = TextStyle(fontSize: 18, color: Color(0xFF616161));

  void openDesign(context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: page!.pageWidget,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: selectedPanelColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: page == null
            ? Center(
                child: Text(
                  'Select a project on the left',
                  style: style.copyWith(fontWeight: FontWeight.w600),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Description",
                      style: style.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      page!.description,
                      textAlign: TextAlign.justify,
                      style: style,
                    ),
                  ),
                  if (page!.url != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text.rich(
                        TextSpan(
                          text: 'Website link:\n',
                          style: style,
                          children: [
                            TextSpan(
                              text: page!.url,
                              mouseCursor: SystemMouseCursors.click,
                              style:
                                  style.copyWith(color: Colors.blue.shade600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(Uri.parse(page!.url!));
                                },
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Align(
                    alignment: const Alignment(.9, 1),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF2F3C8D),
                        ),
                        onPressed: (() => openDesign(context)),
                        child: const Text(
                          'Open',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (page!.sourceCodeUrl != null)
                    Align(
                      alignment: const Alignment(.9, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, right: 8),
                        child: RichText(
                          text: TextSpan(
                            text: 'Source code',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(page!.sourceCodeUrl!));
                              },
                            mouseCursor: SystemMouseCursors.click,
                            style: const TextStyle(
                              color: Color(0xFF2F3C8D),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

class PageTile extends StatelessWidget {
  const PageTile({Key? key, required this.pageData}) : super(key: key);

  final PageData pageData;

  double get difficulty {
    switch (pageData.difficulty) {
      case Difficulty.easy:
        return .2;
      case Difficulty.intermediate:
        return .65;
      case Difficulty.advanced:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, bc) {
      final leftPadding = bc.maxWidth > 260 ? bc.maxWidth * .1 : 0.0;
      final isBigLayout = bc.maxWidth >= 215;
      return SizedBox(
        height: 105,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (isBigLayout)
                Padding(
                  padding: EdgeInsets.only(
                      top: 2.0, bottom: 2, right: 2, left: 2 + leftPadding),
                  child: pageData.iconSvg != null
                      ? SvgPicture.asset(pageData.iconSvg!)
                      : Icon(
                          pageData.icon,
                          color: const Color(0xFF616161),
                          size: 40,
                        ),
                ),
              const VerticalDivider(
                color: Colors.black45,
                thickness: 1,
                endIndent: 25,
                indent: 25,
                width: 30,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pageData.title,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: difficulty,
                              color: Colors.amber,
                              backgroundColor: Colors.black38,
                            ),
                          ),
                        ),
                        const VerticalDivider(width: 6),
                        Expanded(
                          child: Text(
                            pageData.difficulty.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
