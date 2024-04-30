import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order_model.dart';
import '../../data/models/order_status_model.dart';
import '../../data/repo/order_repo.dart';
import 'order_hsitory_states.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryStates> {
  OrderHistoryCubit(this._orderRepo) : super(OrderHistoryInitialState());
  final OrderRepo _orderRepo;

  bool isLoading = false;
  bool hasMore = true;
  int currentPage = 1;
  List<OrderModel> orders = [];

  Future<void> getOrders([bool shouldRerun = true]) async {
    if (isLoading || !hasMore) {
      return;
    }

    isLoading = true;
    if (shouldRerun) {
      emit(OrderHistoryLoadingState());
    }

    final result = await _orderRepo.getOrdersList('page=$currentPage');
    isLoading = false;

    result.fold(
      (l) => emit(OrderHistoryFailureState(l.message)),
      (r) {
        orders = List<OrderModel>.from(orders)..addAll(r!);
        currentPage++;

        if (r.length < 10) {
          hasMore = false;
        }

        emit(OrderHistorySuccessState(orders));
      },
    );
  }

  updateStatus(String orderId, OrderStatusModel orderStatusModel) {
    if (state is OrderHistorySuccessState) {
      final updatedOrders = orders.map((order) {
        return order.id == orderId
            ? order.copyWith(orderStatusModel: orderStatusModel)
            : order;
      }).toList();

      orders = updatedOrders;
      emit(OrderHistorySuccessState(updatedOrders));
    }
  }
}
