import 'package:flutter/material.dart';

class PageViewDot extends StatefulWidget {
  final List<Widget> children;
  const PageViewDot({Key? key, required this.children}) : super(key: key);

  @override
  State<PageViewDot> createState() => _PageViewDotState();
}

class _PageViewDotState extends State<PageViewDot> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width,
          child: PageView(
            onPageChanged: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            children: widget.children,
          ),
        ),
        Positioned(
          left: 8,
          right: 8,
          bottom: 8,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                widget.children.length, (index) => dotIndicator(index == pageIndex)),
          ),
        ),
      ],
    );
  }

  Widget dotIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[600],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
