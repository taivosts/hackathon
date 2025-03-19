import 'dart:math';
import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/features/common/navigation_service.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/cupertino.dart';

class CupertinoPickerDialog {
  CupertinoPickerDialog._();

  static Future<String?> show({
    required List<String> values,
    required String unit,
    String? initialValue,
  }) {
    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Context not found');
    }
    return showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: _CupertinoPicker(
            values: values,
            unit: unit,
            initialValue: initialValue,
          ),
        ),
      ),
    );
  }
}

class _CupertinoPicker extends StatefulWidget {
  const _CupertinoPicker({
    this.initialValue,
    required this.values,
    required this.unit,
  });
  final String? initialValue;
  final String unit;
  final List<String> values;

  @override
  State<_CupertinoPicker> createState() => _CupertinoPickerState();
}

class _CupertinoPickerState extends State<_CupertinoPicker> {
  int _selectedItem = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = max(
          0, widget.values.indexWhere((value) => value == widget.initialValue));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16),
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pop(widget.values[_selectedItem]),
                child: Text(
                  'DONE',
                  style: AppFont.button(color: AppColors.primary)
                      .copyWith(decoration: TextDecoration.none),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 216,
          child: Row(
            children: [
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: _selectedItem,
                  ),
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _selectedItem = selectedItem;
                    });
                  },
                  children: widget.values
                      .map((value) => Center(child: Text(value)))
                      .toList(),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: 0,
                  ),
                  onSelectedItemChanged: (value) {},
                  children: [Center(child: Text(widget.unit))],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
