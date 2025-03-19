import 'package:dotted_border/dotted_border.dart';
import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:ai_dreamer/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaSection extends StatelessWidget {
  const AddMediaSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final List<XFile> medias = await picker.pickMultipleMedia();
            AppLogger.logInfo("Did select media: $medias");
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(4),
              dashPattern: const [3, 3],
              child: SizedBox(
                height: 96,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset('assets/icons/ic_upload.svg'),
                    const SizedBox(height: 12),
                    Text(
                      'Load your photo/videos here',
                      style: AppFont.b1(color: AppColors.greyLighten1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.white,
            child: Text(
              'Add Media',
              style: AppFont.caption(),
            ),
          ),
        )
      ],
    );
  }
}
