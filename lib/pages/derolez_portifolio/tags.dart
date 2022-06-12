import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  const Tags({Key? key, required this.tags}) : super(key: key);

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12.0, left: 4),
          child: Text(
            'TECH',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            tags.length,
            (i) => Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Tag(tags[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class Tag extends StatelessWidget {
  const Tag(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(width: .5, color: Colors.white),
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
