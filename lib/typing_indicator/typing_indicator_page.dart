import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TypingIndicatorPage extends StatefulWidget {
  const TypingIndicatorPage({Key? key}) : super(key: key);

  @override
  State<TypingIndicatorPage> createState() => _TypingIndicatorPageState();
}

class _TypingIndicatorPageState extends State<TypingIndicatorPage> {
  bool showIndicator = false;
  final _controller = ScrollController();

  void onChanged(bool val) {
    setState(() {
      showIndicator = val;
    });

    if (val) _controller.jumpTo(_controller.position.maxScrollExtent);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      print(GlobalKey<_TypingIndicatorState>().currentContext?.size);
    });
  }

  List<Widget> listWidgets() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          height: 100,
          color: Colors.green.shade400,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          height: 30,
          color: Colors.grey.shade400,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          height: 100,
          color: Colors.red.shade400,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          height: 30,
          color: Colors.grey.shade400,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          height: 100,
          color: Colors.grey.shade400,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Typing Indicator'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.black54,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.touch,
                    },
                  ),
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...listWidgets(),
                          if (showIndicator) TypingIndicator(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Switch(value: showIndicator, onChanged: onChanged),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  final key = GlobalObjectKey<_TypingIndicatorState>('indicator');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
