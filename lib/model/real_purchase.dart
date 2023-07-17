import 'package:freezed_annotation/freezed_annotation.dart';

import 'purchase_item.dart';

part 'real_purchase.freezed.dart';
part 'real_purchase.g.dart';

@freezed
class PurchaseModel with _$PurchaseModel {
  @JsonSerializable(explicitToJson: true)
  factory PurchaseModel({
    required String id,
    required List<PurchaseItem> items,
    required String name,
    required String email,
    required String phone,
    required String address,
    required int total,
    required String promotionValue,
    required List deliveryTownshipInfo,
    @JsonKey(nullable: true) String? bankSlipImage,
    required String dateTime,
  }) = _PurchaseModel;
  factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
        id: json['id'] as String,
        items: (json['items'] as List<dynamic>)
            .map((e) => PurchaseItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        total: json['total'] as int,
        promotionValue: json['promotionValue'] is int
            ? json['promotionValue'].toString()
            : json['promotionValue'] as String,
        deliveryTownshipInfo: json['deliveryTownshipInfo'] as List<dynamic>,
        bankSlipImage: json['bankSlipImage'] as String?,
        dateTime: json['dateTime'] as String,
      );
}
