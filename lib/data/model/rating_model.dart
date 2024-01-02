import 'dart:convert';

class RatingModel {
  final num percentRatings;
  final num ratings;
  final List<StarModel> starList;

  RatingModel({
    required this.percentRatings,
    required this.ratings,
    required this.starList,
  });

  Map<String, dynamic> toMap() {
    return {
      'percentRatings': percentRatings,
      'ratings': ratings,
      'starList': starList.map((x) => x.toMap()).toList(),
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      percentRatings: map['percentRatings'] ?? 0,
      ratings: map['ratings'] ?? 0,
      starList: List<StarModel>.from(map['starList']?.map((x) => StarModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingModel.fromJson(String source) => RatingModel.fromMap(json.decode(source));
}

class StarModel {
  final int starNumber;
  final int starRating;
  StarModel({
    required this.starNumber,
    required this.starRating,
  });

  Map<String, dynamic> toMap() {
    return {
      'starNumber': starNumber,
      'starRating': starRating,
    };
  }

  factory StarModel.fromMap(Map<String, dynamic> map) {
    return StarModel(
      starNumber: map['starNumber']?.toInt() ?? 0,
      starRating: map['starRating']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StarModel.fromJson(String source) =>
      StarModel.fromMap(json.decode(source));
}
