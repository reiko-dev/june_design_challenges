import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isMobile = size.width < 500;

    final style =
        TextStyle(color: Colors.grey.shade200.withAlpha(200), fontSize: 13);
    final styleFaded = TextStyle(
      color: Colors.grey.shade400.withAlpha(150),
      fontSize: 13,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: isMobile
          ? Container(
              height: 240,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0xFF051221),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ThreeColumnsInfo(
                              styleFaded: styleFaded, style: style),
                        )),
                    Divider(
                      indent: size.width * 0.15,
                      endIndent: size.width * 0.15,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 2,
                      child:
                          ContactWidget(styleFaded: styleFaded, style: style),
                    ),
                    Divider(
                      indent: size.width * 0.15,
                      endIndent: size.width * 0.15,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        'Copyright @ 2021 | ZUBOX',
                        style: TextStyle(
                          color: Colors.grey.shade400.withAlpha(150),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              height: 150,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0xFF051221),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ThreeColumnsInfo(
                              styleFaded: styleFaded,
                              style: style,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                            height: 100,
                            child: VerticalDivider(
                              endIndent: 8,
                              indent: 8,
                              thickness: 0.3,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ContactWidget(
                                styleFaded: styleFaded,
                                style: style,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    height: 10,
                    child: const Divider(
                      thickness: 0.3,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Copyright @ 2021 | ZUBOX',
                      style: TextStyle(
                        color: Colors.grey.shade400.withAlpha(150),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    Key? key,
    required this.styleFaded,
    required this.style,
  }) : super(key: key);

  final TextStyle styleFaded;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Email: ',
                style: styleFaded,
              ),
              Text(
                'zubox@gmail.com',
                style: style,
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: styleFaded,
              text: 'Address: ',
              children: [
                TextSpan(
                  text: '128, Zoomland Road, Sorocaba-SP',
                  style: style,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ThreeColumnsInfo extends StatelessWidget {
  const ThreeColumnsInfo({
    Key? key,
    required this.styleFaded,
    required this.style,
  }) : super(key: key);

  final TextStyle styleFaded;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, bc) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: bc.maxWidth > 400 ? 400 : bc.maxWidth,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'About',
                      maxLines: 1,
                      style: styleFaded.copyWith(fontSize: 15),
                    ),
                    Text('Contact Us', style: style, maxLines: 1),
                    Text('About Us', style: style, maxLines: 1),
                    Text('Careers', style: style, maxLines: 1),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Help',
                      style: styleFaded.copyWith(fontSize: 15),
                      maxLines: 1,
                    ),
                    Text('Payment', style: style, maxLines: 1),
                    Text('FAQ', style: style, maxLines: 1),
                    Text('Policy', style: style, maxLines: 1),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Social',
                      style: styleFaded.copyWith(fontSize: 15),
                      maxLines: 1,
                    ),
                    Text('Twitter', style: style, maxLines: 1),
                    Text('Facebook', style: style, maxLines: 1),
                    Text('Youtube', style: style, maxLines: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
