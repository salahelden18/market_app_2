import 'package:equatable/equatable.dart';
import '../../data/models/custome_product_model.dart';

class ProductStates extends Equatable {
  final List<CustomProductModel> products;

  const ProductStates({
    this.products = const [],
  });

  @override
  List<Object?> get props => [products];
}
