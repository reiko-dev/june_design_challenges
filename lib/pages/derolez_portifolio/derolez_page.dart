import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/derolez_portifolio/data/work.dart';
import 'package:june_design_challenges/pages/derolez_portifolio/work_menu.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

//Original website:
//https://derolez.dev/
final buttonsColor = Colors.grey.shade900;
const inkWellColor = Color(0xFF282828);

class DerolezPage extends StatefulWidget {
  static const routeName = '/derolez-page';
  const DerolezPage({Key? key}) : super(key: key);

  @override
  DerolezPageState createState() => DerolezPageState();
}

class DerolezPageState extends State<DerolezPage> {
  final pageTitle =
      'Rafael Derolez is a freelance front-end engineer with a strong focus on interfaces and experiences working remotely from Ghent, Belgium.';

  final double maxWidth = 1000;
  final double minHeight = 500;

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

  double topPadding(Size fullSize) {
    if (fullSize.height < 500) return 10;

    if (fullSize.height < 720 || fullSize.width < 500) {
      return fullSize.height * .15;
    }

    return fullSize.height * .2;
  }

  @override
  Widget build(BuildContext context) {
    final fullSize = MediaQuery.of(context).size;
    final size = getSize(fullSize);

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: topPadding(fullSize)),
                Align(
                  alignment: Alignment.topLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: size.height * .25,
                      maxWidth: size.width,
                    ),
                    child: AutoSizeText(
                      pageTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 200,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const PersonalElements(),
                const SizedBox(height: 40),
                SizedBox(
                  height: works.length * 90, //90px per line
                  width: size.width,
                  child: WorksMenu(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.url,
  }) : super(key: key);

  final void Function() onTap;
  final String text;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? _MyButtonContent(onTap: onTap, text: text)
        : Link(
            uri: Uri.parse(url!),
            builder: (context, followLink) {
              return _MyButtonContent(onTap: onTap, text: text);
            },
          );
  }
}

class _MyButtonContent extends StatelessWidget {
  const _MyButtonContent({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

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
        focusColor: Colors.white.withAlpha(30),
        hoverColor: inkWellColor,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            text,
            style: const TextStyle(
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

  Map<String, String> get medias => {
        'Email': 'raf@derolez.dev',
        'Twitter': 'https://twitter.com/rafaelderolez',
        'Instagram': 'https://www.instagram.com/derolez.dev/',
        'CV': 'https://cv.derolez.dev/',
      };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        MyButton(
          onTap: () {
            launchUrl(
              Uri(
                scheme: 'mailto',
                path: 'raf@derolez.dev',
                queryParameters: {'subject': 'Hi'},
              ),
            );
          },
          url: Uri(
            scheme: 'mailto',
            path: 'raf@derolez.dev',
            queryParameters: {'subject': 'Hi'},
          ).toString(),
          text: medias.keys.first,
        ),
        for (int i = 1; i < medias.entries.length; i++)
          MyButton(
            onTap: () {
              launchUrl(Uri.parse(medias.values.elementAt(i)));
            },
            url: medias.values.elementAt(i),
            text: medias.keys.elementAt(i),
          ),
      ],
    );
  }
}
