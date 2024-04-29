import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/order_repo.dart';
import 'order_details_states.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsStates> {
  OrderDetailsCubit(this._orderRepo) : super(OrderDetailsInitialState());
  final OrderRepo _orderRepo;

  Future getOrderDetails(String orderId) async {
    emit(OrderDetailsLoadingState());

    final result = await _orderRepo.getOrderDetails(orderId);

    result.fold(
      (l) => emit(OrderDetailsFailureState(l.message)),
      (r) => emit(OrderDetailsSuccessState(r!)),
    );
  }
}
