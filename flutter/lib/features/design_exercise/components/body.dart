import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'add_media_section.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 1),
                        blurRadius: 2)
                  ],
                ),
                child: Column(
                  children: [
                    const PrimaryTextField(
                      label: 'Exercise Name',
                      hintText: 'Enter Exercise Name',
                      isRequired: false,
                    ),
                    const SizedBox(height: 24),
                    AmountInput(
                      title: 'Number of Sets',
                      onChanged: (amount) {
                        AppLogger.logInfo("Did input number of sets: $amount");
                      },
                    ),
                    const SizedBox(height: 24),
                    const AmountInput(title: 'Number of Reps'),
                    const SizedBox(height: 24),
                    PrimaryTextField(
                      label: 'Total Minutes',
                      hintText: 'Total Minutes',
                      isRequired: false,
                      suffixIcon: SvgPicture.asset(
                          'assets/icons/ic_input_arrow_down.svg'),
                    ),
                    const SizedBox(height: 24),
                    const SizedBox(
                      height: 160,
                      child: PrimaryTextField(
                        label: 'Description',
                        hintText: 'Enter Description Here',
                        isRequired: false,
                        inputLine: 6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const AddMediaSection()
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(title: 'SAVE'),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SecondaryButton(title: 'CANCEL'),
            ),
            const SizedBox(height: 16),
            SizedBox(height: safePadding.bottom),
          ],
        ),
      ),
    );
  }
}
