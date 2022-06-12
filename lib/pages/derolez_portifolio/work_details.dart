import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/derolez_portifolio/data/work.dart';
import 'package:june_design_challenges/pages/derolez_portifolio/tags.dart';
import 'package:june_design_challenges/pages/derolez_portifolio/work_menu.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkDetails extends StatelessWidget {
  const WorkDetails({super.key, required this.work});
  final Work work;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: SizedBox(
                width: size.width * .9,
                height: size.height * .96,
                child: CustomPaint(
                  painter: DecorationPainter(),
                  child: Material(
                    color: Colors.transparent,
                    child: LayoutBuilder(builder: (context, bc) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 32, right: 32, top: 32),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //Title
                              _TItle(work: work),

                              //Tags
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 24.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Tags(tags: work.tags),
                                  ),
                                ),
                              ),

                              //Images
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: ImagesCarousel(work.images),
                              ),

                              //Description
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: Text(
                                  work.description,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 24.0),
                                child: _VisitButton(),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TItle extends StatelessWidget {
  const _TItle({Key? key, required this.work}) : super(key: key);

  final Work work;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 95,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: .2,
                strokeAlign: StrokeAlign.inside,
              ),
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(child: WorkItem(work: work, withButton: false)),
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Material(
                        color: Colors.grey.shade900,
                        child: InkWell(
                          mouseCursor: SystemMouseCursors.click,
                          onTap: () => Navigator.of(context).pop(),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImagesCarousel extends StatelessWidget {
  const ImagesCarousel(this.images, {super.key});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: double.infinity,
        height: size.height * .95 * .5,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.asset(images[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _VisitButton extends StatelessWidget {
  const _VisitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 42,
        maxWidth: 200,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.grey.shade900,
          child: InkWell(
            onTap: () => launchUrl(
              Uri.parse('https://www.reikodev.com'),
            ),
            child: const Center(
              child: Text(
                'Visit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndCorners(
      Offset.zero & size,
      topRight: const Radius.circular(15),
      topLeft: const Radius.circular(15),
    );
    canvas.drawRRect(
      rrect,
      Paint()..color = Colors.black,
    );

    Path path = Path()..addRRect(rrect);

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = .25
        ..color = Colors.white,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      Paint()..color = Colors.black,
    );
  }

  @override
  bool shouldRepaint(DecorationPainter oldDelegate) => true;
}
