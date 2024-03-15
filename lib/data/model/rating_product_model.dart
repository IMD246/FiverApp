class RatingProductModel {
  num? totalRating;
  num? totalRatingAvg;
  num? totalRatingStar1;
  num? totalRatingStar1Percent;
  num? totalRatingStar2;
  num? totalRatingStar2Percent;
  num? totalRatingStar3;
  num? totalRatingStar3Percent;
  num? totalRatingStar4;
  num? totalRatingStar4Percent;
  num? totalRatingStar5;
  num? totalRatingStar5Percent;

  RatingProductModel({
    this.totalRating,
    this.totalRatingAvg,
    this.totalRatingStar1,
    this.totalRatingStar1Percent,
    this.totalRatingStar2,
    this.totalRatingStar2Percent,
    this.totalRatingStar3,
    this.totalRatingStar3Percent,
    this.totalRatingStar4,
    this.totalRatingStar4Percent,
    this.totalRatingStar5,
    this.totalRatingStar5Percent,
  });

  RatingProductModel.fromJson(Map<String, dynamic> json) {
    totalRating = json['total_rating'] ?? 0;
    totalRatingAvg = json['total_rating_avg'] ?? 0;
    totalRatingStar1 = json['total_rating_star_1'] ?? 0;
    totalRatingStar1Percent = json['total_rating_star_1_percent'] ?? 0;
    totalRatingStar2 = json['total_rating_star_2'] ?? 0;
    totalRatingStar2Percent = json['total_rating_star_2_percent'] ?? 0;
    totalRatingStar3 = json['total_rating_star_3'];
    totalRatingStar3Percent = json['total_rating_star_3_percent'] ?? 0;
    totalRatingStar4 = json['total_rating_star_4'] ?? 0;
    totalRatingStar4Percent = json['total_rating_star_4_percent'] ?? 0;
    totalRatingStar5 = json['total_rating_star_5'] ?? 0;
    totalRatingStar5Percent = json['total_rating_star_5_percent'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_rating'] = totalRating;
    data['total_rating_avg'] = totalRatingAvg;
    data['total_rating_star_1'] = totalRatingStar1;
    data['total_rating_star_1_percent'] = totalRatingStar1Percent;
    data['total_rating_star_2'] = totalRatingStar2;
    data['total_rating_star_2_percent'] = totalRatingStar2Percent;
    data['total_rating_star_3'] = totalRatingStar3;
    data['total_rating_star_3_percent'] = totalRatingStar3Percent;
    data['total_rating_star_4'] = totalRatingStar4;
    data['total_rating_star_4_percent'] = totalRatingStar4Percent;
    data['total_rating_star_5'] = totalRatingStar5;
    data['total_rating_star_5_percent'] = totalRatingStar5Percent;
    return data;
  }
}
