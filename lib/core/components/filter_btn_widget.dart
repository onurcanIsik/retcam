// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retcam/core/bloc/image/image.bloc.dart';
import 'package:retcam/colors/colors.dart';
import 'package:retcam/core/extensions/extensions.dart';
import 'package:retcam/core/utils/localization/locale_keys.g.dart';

class FilterButtonWidget extends HookWidget {
  final Future<void> Function() onPressed;
  const FilterButtonWidget(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    final isClicked = useState<bool>(false);

    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        final isEnabled = state is ImageLoaded;

        return SizedBox(
          width: context.dynamicWidth(0.8),
          height: context.dynamicHeight(0.05),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isEnabled ? btnColor : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed:
                isEnabled && !isClicked.value
                    ? () async {
                      isClicked.value = true;
                      await onPressed();
                      isClicked.value = false;
                    }
                    : null,
            child:
                isClicked.value
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : Text(
                      LocaleKeys.filter_btn_widget_filter_btn_txt.locale,
                      style: TextStyle(fontSize: 20, color: bgColor),
                    ),
          ),
        );
      },
    );
  }
}
