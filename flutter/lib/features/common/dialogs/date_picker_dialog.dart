import 'package:ai_dreamer/design_kit/text_style.dart';
import 'package:ai_dreamer/features/common/navigation_service.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/cupertino.dart';

class CupertinoDatePickerDialog {
  CupertinoDatePickerDialog._();

  static Future<DateTime?> show({DateTime? initialDateTime}) {
    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Context not found');
    }
    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: _CupertinoDatePicker(
            initialDateTime: initialDateTime,
          ),
        ),
      ),
    );
  }
}

class _CupertinoDatePicker extends StatefulWidget {
  const _CupertinoDatePicker({
    this.initialDateTime,
  });
  final DateTime? initialDateTime;

  @override
  State<_CupertinoDatePicker> createState() => _CupertinoDatePickerState();
}

class _CupertinoDatePickerState extends State<_CupertinoDatePicker> {
  DateTime? selectedDate;
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
                onTap: () => Navigator.of(context).pop(selectedDate),
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
          child: CupertinoDatePicker(
            initialDateTime: widget.initialDateTime,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            showDayOfWeek: false,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                selectedDate = newDate;
              });
            },
          ),
        ),
      ],
    );
  }
}
