import 'package:flutter/material.dart';

class CenterPanel extends StatefulWidget {
  const CenterPanel({
    Key? key,
    required this.isMobile,
  }) : super(key: key);

  final bool isMobile;

  @override
  CenterPanelState createState() => CenterPanelState();
}

class CenterPanelState extends State<CenterPanel> {
  bool showIcons = true;
  late Size containerSize;
  late double dividerPadding;
  var verticalDivider = VerticalDivider(
    color: Colors.grey.shade400,
    indent: 10,
    endIndent: 10,
    thickness: 1.2,
  );
  void updateContainerSize(Size size) {
    showIcons = true;
    double height = size.height >= 500 ? 50 : size.height * .1;
    double width = 500; //maxWidth

    if (widget.isMobile) {
      width = 200;
      height = 200;
      showIcons = true;
    } else {
      if (size.width < 500) {
        width = size.width * 0.9;
      }

      if (size.width < 800 && !widget.isMobile) {
        showIcons = false;
      }

      dividerPadding = height * .2;
    }

    containerSize = Size(width, height);
  }

  @override
  Widget build(BuildContext context) {
    updateContainerSize(MediaQuery.of(context).size);

    return widget.isMobile
        ? SizedBox(
            width: containerSize.width,
            height: containerSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CenterPanelTile(
                    icon: const Icon(Icons.place_outlined),
                    title: 'Destination',
                    showIcons: showIcons),
                CenterPanelTile(
                  icon: const Icon(Icons.date_range_outlined),
                  showIcons: showIcons,
                  title: 'Dates',
                ),
                CenterPanelTile(
                  icon: const Icon(Icons.person),
                  title: 'People',
                  showIcons: showIcons,
                ),
                CenterPanelTile(
                    icon: const Icon(Icons.light_mode),
                    title: 'Experience',
                    showIcons: showIcons),
              ],
            ),
          )
        : Container(
            width: containerSize.width,
            height: containerSize.height,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  if (showIcons) const Icon(Icons.place_outlined),
                  const Text('Destination'),
                ]),
                verticalDivider,
                Row(children: [
                  if (showIcons) const Icon(Icons.date_range_outlined),
                  const Text('Dates'),
                ]),
                verticalDivider,
                Row(children: [
                  if (showIcons) const Icon(Icons.person),
                  const Text('People'),
                ]),
                verticalDivider,
                Row(children: [
                  if (showIcons) const Icon(Icons.light_mode),
                  const Text('Experience'),
                ]),
                verticalDivider,
                SizedBox(
                  width: containerSize.width * .15,
                  height: containerSize.height * .8,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF001500),
                        ),
                      ),
                      child: showIcons
                          ? const Text('Search')
                          : const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CenterPanelTile extends StatelessWidget {
  CenterPanelTile({
    required this.icon,
    required this.title,
    required this.showIcons,
  }) : super(key: ValueKey(title));

  final Icon icon;
  final String title;
  final bool showIcons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (showIcons) icon,
              const VerticalDivider(
                endIndent: 12,
                indent: 12,
                width: 10,
                thickness: 1,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
