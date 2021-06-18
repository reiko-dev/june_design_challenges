import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:june_design_challenges/derolez_portifolio/data/work.dart';

final buttonsColor = Colors.grey.shade900;
final inkWellColor = const Color(0xFF282828);

class DerolezPage extends StatefulWidget {
  const DerolezPage({Key? key}) : super(key: key);

  @override
  _DerolezPageState createState() => _DerolezPageState();
}

class _DerolezPageState extends State<DerolezPage> {
  final pageTitle =
      'Rafael Derolez is a freelance front-end engineer with a strong focus on interfaces and experiences working remotely from Ghent, Belgium.';

  final double maxWidth = 1000;
  final double minHeight = 500;
  Work? work;
  void showWorkItemDetails(Work work) {
    this.work = work;
    setState(() {});
    print(work);
  }

  void hideWorkItemDetails() {
    work = null;
    setState(() {});
  }

  Size getSize(Size size) {
    //MinHeight
    double height = minHeight;
    double width = maxWidth;

    if (size.height >= minHeight) height = size.height;

    if (size.width <= maxWidth) {
      width = size.width * 0.95;
    }

    return Size(width, height);
  }

  Size getWindowAnimationSize(Size size) {
    double width = size.width * 0.95;
    double height = size.height * 0.95;

    if (size.width * 0.95 > 950) width = 950;

    return Size(width, height);
  }

  @override
  Widget build(BuildContext context) {
    final fullSize = MediaQuery.of(context).size;
    final size = getSize(fullSize);

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      pageTitle,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                      maxLines: 12,
                      minFontSize: 8,
                    ),
                    SizedBox(height: 10),
                    const PersonalElements(),
                    SizedBox(height: 40),
                    SizedBox(
                      height: works.length * 90, //90px per line
                      width: size.width,
                      child: WorksMenu(
                        showWorkItemDetails: showWorkItemDetails,
                      ),
                    ),
                  ],
                ),
              ),

              //PopUp animation
              Positioned(
                top: fullSize.height * 0.5,
                left: fullSize.width * 0.25,
                width: fullSize.width * 0.95,
                child: WorkItemDetails(work: work),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WorksMenu extends StatelessWidget {
  WorksMenu({required this.showWorkItemDetails}) : super(key: UniqueKey());

  final void Function(Work work) showWorkItemDetails;

  @override
  Widget build(BuildContext context) {
    final double separatorWidth = 20;
    return LayoutBuilder(
      builder: (context, bc) {
        return SizedBox.fromSize(
          size: bc.biggest,
          child: bc.maxWidth < 500
              ? Column(
                  children: List.generate(
                    works.length,
                    (index) {
                      final work = works[index];

                      return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          // color: Colors.red,
                          width: bc.maxWidth,
                          height: 80,
                          child: Column(
                            children: [
                              WorkItem(
                                work: work,
                                showWorkItemDetails: showWorkItemDetails,
                              ),
                              Container(
                                width: bc.maxWidth * 0.2,
                                height: 0.2,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceEvenly,
                  children: List.generate(
                    works.length,
                    (index) {
                      final work = works[index];

                      return Padding(
                        padding: EdgeInsets.only(
                          right: index % 2 == 0 ? separatorWidth : 0.0,
                        ),
                        child: Container(
                          // color: Colors.red,
                          width: bc.maxWidth * 0.5 - separatorWidth / 2,
                          height: 80,
                          child: Column(
                            children: [
                              WorkItem(
                                work: work,
                                showWorkItemDetails: showWorkItemDetails,
                              ),
                              if (index + 2 < works.length)
                                Container(
                                  width: bc.maxWidth * 0.2,
                                  height: 0.2,
                                  color: Colors.white,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}

class WorkItem extends StatelessWidget {
  const WorkItem({
    Key? key,
    required this.work,
    required this.showWorkItemDetails,
  }) : super(key: key);

  final Work work;
  final void Function(Work work) showWorkItemDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            color: work.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(work.iconData),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  work.title,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade300),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  work.subTitle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        MyButton(
          text: 'View',
          onTap: () {
            showWorkItemDetails(work);
          },
        ),
      ],
    );
  }
}

class WorkItemDetails extends StatelessWidget {
  WorkItemDetails({Key? key, required this.work})
      : super(key: work != null ? ValueKey('work-${work.key}') : null);
  final Work? work;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return work == null
        ? SizedBox.shrink()
        : LayoutBuilder(
            builder: (context, bc) {
              print(bc);
              return Container(
                width: bc.maxWidth,
                height: 200,
                color: Colors.amber,
              );

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white),
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: size.height * 0.13,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.13,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(color: Colors.green),
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.green.withAlpha(100),
                      child: Text(
                        work!.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('visit');
                      },
                      child: Container(
                        width: bc.maxWidth * 0.3,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: bc.maxWidth > 800
                              ? Alignment.centerLeft
                              : Alignment.center,
                          child: Text(
                            'Visit',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: buttonsColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: Colors.green,
        focusColor: Colors.white.withAlpha(30),
        hoverColor: inkWellColor,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class PersonalElements extends StatelessWidget {
  const PersonalElements({
    Key? key,
  }) : super(key: key);

  final medias = const ['Email', 'Twitter', 'Instagram', 'CV'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        for (var media in medias)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: buttonsColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                media,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
