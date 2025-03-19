import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/utils/expanded_section.dart';

class CollapsibleSection extends StatefulWidget {
  const CollapsibleSection({
    super.key,
    required this.children,
    required this.title,
  });

  final List<Widget> children;
  final String title;

  @override
  State<CollapsibleSection> createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<CollapsibleSection> {
  bool isCollapse = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() {
            isCollapse = !isCollapse;
          }),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFF556C88).withOpacity(0.1),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: AppFont.subHeading3(color: const Color(0xFF0558EE)),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: !isCollapse ? 0 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: SvgPicture.asset('assets/icons/ic_arrow_up.svg'),
                  ),
                ],
              ),
            ),
          ),
        ),
        ExpandedSection(
          expand: !isCollapse,
          child: Column(
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
