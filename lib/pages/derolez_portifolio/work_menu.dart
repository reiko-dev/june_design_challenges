import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/derolez_portifolio/data/work.dart';
import 'package:june_design_challenges/pages/derolez_portifolio/derolez_page.dart';
import 'package:june_design_challenges/pages/derolez_portifolio/work_details.dart';

class WorksMenu extends StatelessWidget {
  WorksMenu() : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    const double separatorWidth = 20;
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
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: bc.maxWidth,
                          height: 80,
                          child: WorkItem(work: work, withBorder: true),
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
                        child: SizedBox(
                          width: bc.maxWidth * 0.5 - separatorWidth / 2,
                          height: 80,
                          child: WorkItem(
                              work: work,
                              withBorder: (index + 2) < works.length),
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
    this.withBorder = false,
    this.withButton = true,
    this.titleStyle = const TextStyle(
      fontSize: 14,
      color: Color.fromARGB(255, 224, 224, 224),
    ),
  }) : super(key: key);

  final Work work;
  final TextStyle titleStyle;
  final bool withBorder;
  final bool withButton;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        WorkIcon(work: work),
        const SizedBox(width: 8),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: withBorder
                  ? const Border(
                      bottom: BorderSide(color: Colors.white, width: .2),
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    work.title,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: titleStyle,
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
        ),
        const SizedBox(width: 8),
        if (withButton)
          MyButton(
            text: 'View',
            onTap: () {
              showGeneralDialog(
                context: context,
                barrierColor: Colors.transparent,
                transitionBuilder: (context, a1, secondaryAnimation, child) {
                  return Transform.translate(
                    offset: Offset(0, size.height - (size.height * a1.value)),
                    child: WorkDetails(work: work),
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return WorkDetails(work: work);
                },
              );
            },
          ),
      ],
    );
  }
}

class WorkIcon extends StatelessWidget {
  const WorkIcon({
    Key? key,
    required this.work,
  }) : super(key: key);

  final Work work;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        color: work.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(work.iconData),
    );
  }
}
