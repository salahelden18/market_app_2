import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/order/data/repo/order_repo.dart';
import 'current_active_orders_states.dart';

class CurrentActiveOrderCubit extends Cubit<CurrentActiveOrdersStates> {
  CurrentActiveOrderCubit(this._orderRepo)
      : super(CurrentActiveOrderInitialState());

  final OrderRepo _orderRepo;

  Future getActiveOrders() async {
    final result = await _orderRepo.getCurrentActiveOrders();

    result.fold(
      (l) => emit(CurrentActiveOrderFailureState(l.message)),
      (r) => emit(CurrentActiveOrderSuccessState(r ?? [])),
    );
  }
}
