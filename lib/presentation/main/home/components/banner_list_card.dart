import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fiver/core/utils/collection_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';
import '../../../../data/model/banner_model.dart';
import '../home_model.dart';

class BannerListCard extends StatelessWidget {
  const BannerListCard({super.key, required this.model});
  final HomeModel model;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: model.banners,
      builder: (context, banners, child) {
        if (banners.isNullOrEmpty) {
          return _shimmerBannerItem();
        }
        return _sliderWidget(banners);
      },
    );
  }

  Widget _sliderWidget(List<BannerModel> banners) {
    return CarouselSlider.builder(
      itemCount: banners.length,
      itemBuilder: (context, index, realIndex) {
        final banner = banners[index];
        return _bannerItem(banner);
      },
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
      ),
    );
  }

  Widget _bannerItem(BannerModel banner) {
    return Stack(
      children: [
        SizedBox(
          width: 1.sw,
          height: 200.sw,
          child: CachedNetworkImage(
            cacheKey: banner.image,
            fit: BoxFit.cover,
            imageUrl: banner.image,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(21.w),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              banner.name,
              style: text28.bold.copyWith(
                color: getColor().themeColorWhiteBlack,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _shimmerBannerItem() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: Container(
        width: 1.sw,
        height: 200.w,
        color: getColor().themeColorAAAAAAA,
      ),
    );
  }
}
