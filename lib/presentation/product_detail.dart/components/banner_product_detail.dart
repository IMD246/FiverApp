import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../product_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/res/theme/theme_manager.dart';

class BannerProductDetail extends StatelessWidget {
  const BannerProductDetail({super.key, required this.model});
  final ProductDetailModel model;
  @override
  Widget build(BuildContext context) {
    return _sliderWidget(model.images);
  }

  Widget _sliderWidget(List<String> images) {
    return ValueListenableBuilder(
      valueListenable: model.loadingProductDetail,
      builder: (context, loadingProductDetail, child) {
        if (loadingProductDetail) {
          return _shimmer();
        }
        return CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            final banner = images[index];
            return _bannerItem(banner);
          },
          options: CarouselOptions(
            viewportFraction: 1,
            height: 200.w,
            autoPlay: true,
          ),
        );
      },
    );
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: Container(
        width: double.infinity,
        height: 200.w,
        color: Colors.white,
      ),
    );
  }

  Widget _bannerItem(String image) {
    return SizedBox(
      width: 1.sw,
      height: 200.sw,
      child: CachedNetworkImage(
        cacheKey: image,
        fit: BoxFit.cover,
        imageUrl: image,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
