import 'package:equatable/equatable.dart';
import '../../data/models/basket_response_model.dart';

class BasketStates extends Equatable {
  final bool isLoading;
  final bool isFirstLoading;
  final BasketReponseModel? basket;

  const BasketStates({
    this.basket,
    this.isFirstLoading = false,
    this.isLoading = false,
  });

  BasketStates copyWith({
    bool? isLoading,
    bool? isFirstLoading,
    BasketReponseModel? basket,
  }) {
    return BasketStates(
      basket: basket ?? this.basket,
      isFirstLoading: isFirstLoading ?? this.isFirstLoading,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isLoading, isFirstLoading, basket];
}
