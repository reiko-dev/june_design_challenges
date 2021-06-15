import 'package:flutter/material.dart';

class CenterPanel extends StatefulWidget {
  const CenterPanel({
    Key? key,
  }) : super(key: key);

  @override
  _CenterPanelState createState() => _CenterPanelState();
}

class _CenterPanelState extends State<CenterPanel> {
  bool showIcons = true;
  late Size containerSize;
  late double dividerPadding;
  bool isHorizontalLayout = false;
  var divider = VerticalDivider(
    color: Colors.grey.shade400,
    indent: 10,
    endIndent: 10,
    thickness: 1.2,
  );
  void updateContainerSize(Size size) {
    showIcons = true;
    isHorizontalLayout = false;
    double height = size.height >= 500 ? 50 : size.height * .1;
    double width = size.width * .6;

    if (size.width <= 600) {
      isHorizontalLayout = true;
      height = 200;
      width = 250;
    }

    if (size.width > 600 && size.width < 800) showIcons = false;

    dividerPadding = height * .2;

    containerSize = Size(width, height);
  }

  @override
  Widget build(BuildContext context) {
    updateContainerSize(MediaQuery.of(context).size);

    return isHorizontalLayout
        ? SizedBox(
            width: containerSize.width,
            height: containerSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CenterPanelTile(
                    icon: Icon(Icons.place_outlined),
                    title: 'Destination',
                    showIcons: showIcons),
                CenterPanelTile(
                  icon: Icon(Icons.date_range_outlined),
                  showIcons: showIcons,
                  title: 'Dates',
                ),
                CenterPanelTile(
                  icon: Icon(Icons.person),
                  title: 'People',
                  showIcons: showIcons,
                ),
                CenterPanelTile(
                    icon: Icon(Icons.light_mode),
                    title: 'Experience',
                    showIcons: showIcons),
              ],
            ),
          )
        : Container(
            width: containerSize.width,
            height: containerSize.height,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  if (showIcons) Icon(Icons.place_outlined),
                  Text('Destination'),
                ]),
                divider,
                Row(children: [
                  if (showIcons) Icon(Icons.date_range_outlined),
                  Text('Dates'),
                ]),
                divider,
                Row(children: [
                  if (showIcons) Icon(Icons.person),
                  Text('People'),
                ]),
                divider,
                Row(children: [
                  if (showIcons) Icon(Icons.light_mode),
                  Text('Experience'),
                ]),
                divider,
                SizedBox(
                  width: containerSize.width * .15,
                  height: containerSize.height * .8,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: showIcons ? Text('Search') : Icon(Icons.search),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF001500),
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
          padding: const EdgeInsets.only(left: 38.0),
          child: Row(children: [
            if (showIcons) icon,
            Text(title),
          ]),
        ),
      ),
    );
  }
}
