import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/order_request_model.dart';
import '../../../data/repo/order_repo.dart';
import 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit(this._orderRepo) : super(OrderInitialState());

  final OrderRepo _orderRepo;

  Future order(OrderRequestModel orderRequestModel) async {
    emit(OrderLoadingState());

    var result = await _orderRepo.order(orderRequestModel);

    result.fold(
      (l) => emit(OrderFailureState(l.message)),
      (r) => emit(OrderSuccessState(r!)),
    );
  }
}
