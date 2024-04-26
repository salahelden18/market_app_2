import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final int id;
  final String? imageUrl;
  final int? bannerType;
  final dynamic url;
  final dynamic productId;
  final bool? isActive;
  final String? createdAt;

  const BannerModel({
    required this.id,
    this.imageUrl,
    this.bannerType,
    this.url,
    this.productId,
    this.isActive,
    this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      bannerType: json['bannerType'],
      url: json['url'],
      productId: json['productId'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['bannerType'] = bannerType;
    data['url'] = url;
    data['productId'] = productId;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        bannerType,
        url,
        productId,
        isActive,
        createdAt,
      ];
}
