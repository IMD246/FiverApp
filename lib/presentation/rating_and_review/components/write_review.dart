import 'dart:io';

import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/presentation/rating_and_review/rating_and_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/res/colors.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/default_button.dart';
import '../../widgets/input/customizable_text_input.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({super.key, required this.model});
  final RatingAndReviewModel model;
  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.w,
              ),
              Center(
                child: Text(
                  context.loc.what_is_your_rate,
                  style: text18.copyWith(
                    color: getColor().themeColor222222White,
                  ),
                ),
              ),
              SizedBox(
                height: 17.w,
              ),
              _ratingStar(),
              SizedBox(
                height: 33.w,
              ),
              Center(
                child: SizedBox(
                  width: 280.w,
                  child: Text(
                    context.loc.please_share_your_opinion_about_the_product,
                    textAlign: TextAlign.center,
                    style: text18.copyWith(
                      color: getColor().themeColor222222White,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 33.w,
              ),
              CustomizableTextInput(
                controller: widget.model.reviewCtr,
                height: 154.w,
                hintText: context.loc.your_review,
                radius: 4.r,
              ),
              SizedBox(
                height: 30.w,
              ),
              _addPhotos(),
              SizedBox(height: 32.w),
              CustomButton(
                text: context.loc.send_review.toUpperCase(),
                onPressed: () {
                  widget.model.onSendReview();
                  Navigator.of(context).pop();
                },
                backgroundIsEnable: colordb3022,
                textStyle: text14.copyWith(
                  color: colorWhite,
                ),
                textStyleEnable: text14.copyWith(
                  color: colorWhite,
                ),
                isEnable: widget.model.enableSendReview,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ratingStar() {
    return Center(
      child: RatingBar.builder(
        itemPadding: EdgeInsets.symmetric(horizontal: 12.w),
        itemBuilder: (context, index) {
          return const Icon(
            Icons.star,
            color: Colors.amber,
          );
        },
        onRatingUpdate: widget.model.onRatingUpdate,
        maxRating: 5,
        minRating: 0,
        allowHalfRating: true,
        glow: false,
        initialRating: widget.model.rateStar,
        itemSize: 36.w,
      ),
    );
  }

  Widget _addPhotos() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ValueListenableBuilder(
        valueListenable: widget.model.images,
        builder: (context, images, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable: widget.model.images,
                builder: (context, images, child) {
                  if (images.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox(
                    height: 104.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        images.length,
                        (index) {
                          final image = images[index];
                          return _imageItem(image, index);
                        },
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  _bottomSheetPickOptionFile(context).then((value) {
                    if (value is bool) {
                      widget.model.onFiles(value);
                    }
                  });
                },
                child: Container(
                  height: 104.w,
                  width: 104.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 12.w),
                      Container(
                        height: 52.w,
                        width: 52.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colordb3022,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: colorWhite,
                        ),
                      ),
                      SizedBox(height: 12.w),
                      Text(
                        context.loc.add_your_photos,
                        textAlign: TextAlign.center,
                        style: text9.copyWith(
                          color: getColor().themeColor222222White,
                        ),
                      ),
                      SizedBox(height: 4.w),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future<bool?> _bottomSheetPickOptionFile(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultButton(
                onTap: () => Navigator.of(context).pop(false),
                title: context.loc.camera,
              ),
              SizedBox(height: 16.w),
              DefaultButton(
                bgColor: Colors.blueAccent,
                onTap: () => Navigator.of(context).pop(true),
                title: context.loc.gallery,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _imageItem(XFile image, int index) {
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () => widget.model.onOpenFile(image),
          child: Container(
            width: 104.w,
            height: 104.w,
            margin: EdgeInsets.only(
              right: 16.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: Image.file(
                File(image.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        _deleteImage(index),
      ],
    );
  }

  Widget _deleteImage(int index) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 20.w,
          right: 8.w,
        ),
        child: IconButton(
          onPressed: () => setState(
            () {
              widget.model.onDeleteFileItem(
                index,
              );
            },
          ),
          icon: Icon(
            Icons.close,
            size: 20.w,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
