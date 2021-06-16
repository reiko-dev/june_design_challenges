import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

final buttonsColor = Colors.grey.shade900;
final inkWellColor = const Color(0xFF282828);
final pageTitle =
    'Rafael Derolez is a freelance front-end engineer with a strong focus on interfaces and experiences working remotely from Ghent, Belgium.';

class DerolezPage extends StatelessWidget {
  const DerolezPage({Key? key}) : super(key: key);

  Size getSize(Size size) {
    double height = size.height;

    if (size.height < 480) height = 480;

    return Size(size.width, height);
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: size.height,
            width: size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.3,
                  child: Container(
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
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: Container(
                    child: MenuWorkItens(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuWorkItens extends StatelessWidget {
  const MenuWorkItens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, bc) {
        return SizedBox.fromSize(
          size: bc.biggest,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: bc.maxWidth * 0.4,
                    height: 80,
                    child: WorkItem(
                      color: Colors.grey,
                      iconData: Icons.audiotrack,
                      title: 'AUDIO',
                      subTitle:
                          'ermentum venenatis, ligula dui faucibus risus, vitae dictum nisl nunc nec nulla.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 8),
                    child: SizedBox(
                      width: bc.maxWidth * 0.4,
                      height: 0.2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 77),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: bc.maxWidth * 0.4,
                    height: 80,
                    child: WorkItem(
                      color: Colors.amber,
                      iconData: Icons.gamepad,
                      title: 'Fnatic Gear',
                      subTitle:
                          'Sed ornare odio sit amet risus imperdiet, at consequat mi hendrerit',
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  SizedBox(
                    width: bc.maxWidth * 0.4,
                    height: 80,
                    child: WorkItem(
                      color: Colors.white,
                      iconData: Icons.text_snippet_rounded,
                      title: 'Text',
                      subTitle:
                          'ermentum venenatis, ligula dui faucibus risus, vitae dictum nisl nunc nec nulla.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 8),
                    child: SizedBox(
                      width: bc.maxWidth * 0.4,
                      height: 0.2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 77),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: bc.maxWidth * 0.4,
                    height: 80,
                    child: WorkItem(
                      color: Colors.pink,
                      iconData: Icons.mic_none_rounded,
                      title: 'Mariah or Messiah',
                      subTitle:
                          'Sed ornare odio sit amet risus imperdiet, at consequat mi hendrerit',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class WorkItem extends StatelessWidget {
  const WorkItem({
    Key? key,
    required this.color,
    required this.iconData,
    required this.subTitle,
    required this.title,
  }) : super(key: key);

  final Color color;
  final IconData iconData;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(iconData),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade300),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  subTitle,
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
            print(title);
          },
        ),
      ],
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
