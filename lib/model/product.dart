import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozarni_ecome/model/size.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  @JsonSerializable(explicitToJson: true)
  factory Product({
    required String id,
    required String photo1,
    required String photo2,
    required String photo3,
    required String name,
    @JsonKey(nullable: true, defaultValue: "") String? brandName,
    required String description,
    required int price,
    @JsonKey(defaultValue: 0) int? discountPrice,
    @JsonKey(nullable: true, defaultValue: []) List<Size>? size,
    @JsonKey(nullable: true) String? color,
    @JsonKey(defaultValue: 0) int? requirePoint,
    @JsonKey(nullable: true) String? advertisementID,
    required String status,
    required List<String> category,
    @JsonKey(nullable: true) String? brandID,
    required List<String> tags,
    required DateTime dateTime,
    @JsonKey(nullable: true) String? deliveryTime,
    @JsonKey(defaultValue: 0) int? love,
    @JsonKey(defaultValue: []) List<String>? comment,
    @JsonKey(defaultValue: 0) double? reviewCount,
    int? originalPrice,
    int? originalQuantity,
    int? remainQuantity,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String,
        photo1: json['photo1'] as String,
        photo2: json['photo2'] as String,
        photo3: json['photo3'] as String,
        name: json['name'] as String,
        brandName: json['brandName'] as String? ?? '',
        description: json['description'] as String,
        price: json['price'] as int,
        discountPrice: json['discountPrice'] as int? ?? 0,
        size: (json['size'] as List<dynamic>?)
                ?.map((e) => Size.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        color: json['color'] as String?,
        requirePoint: json['requirePoint'] as int? ?? 0,
        advertisementID: json['advertisementID'] as String?,
        status: json['status'] as String,
        category: json['category'] is String
            ? [json['category']].map((e) => e as String).toList()
                as List<String>
            : (json['category'] as List<dynamic>)
                .map((e) => e as String)
                .toList(),
        brandID: json['brandID'] as String?,
        tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
        dateTime: DateTime.parse(json['dateTime'] as String),
        deliveryTime: json['deliveryTime'] as String?,
        love: json['love'] as int? ?? 0,
        comment: (json['comment'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        reviewCount: (json['reviewCount'] as num?)?.toDouble() ?? 0,
        originalPrice: json['originalPrice'] as int?,
        originalQuantity: json['originalQuantity'] as int?,
        remainQuantity: json['remainQuantity'] as int?,
      );
}
