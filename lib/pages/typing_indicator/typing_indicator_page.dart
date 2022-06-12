import 'package:flutter/material.dart';

class TypingIndicatorPage extends StatefulWidget {
  static const routeName = '/typing-indicator';
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

    if (val) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      });
    }
  }

  List<Widget> listWidgets() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          height: 100,
          color: Colors.blue.shade400,
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
          color: Colors.blue.shade400,
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
          color: Colors.blue.shade400,
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
          color: Colors.blue.shade400,
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
          color: Colors.blue.shade400,
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
          color: Colors.blue.shade400,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Indicator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black54,
              child: SingleChildScrollView(
                controller: _controller,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ...listWidgets(),
                        if (showIndicator) const TypingIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 66,
            child: Center(
              child: Column(
                children: [
                  Center(
                    child: Text(
                        'Click to ${showIndicator ? 'hide' : 'show'} the indicator'),
                  ),
                  Switch(
                    value: showIndicator,
                    onChanged: onChanged,
                  ),
                ],
              ),
            ),
          )
        ],
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
