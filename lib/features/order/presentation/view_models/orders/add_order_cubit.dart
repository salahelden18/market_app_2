import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/order_request_model.dart';
import '../../../data/repo/order_repo.dart';
import 'add_order_states.dart';

class AddOrderCubit extends Cubit<AddOrderStates> {
  AddOrderCubit(this._orderRepo) : super(AddOrderInitialState());

  final OrderRepo _orderRepo;

  Future order(OrderRequestModel orderRequestModel) async {
    emit(AddOrderLoadingState());

    var result = await _orderRepo.order(orderRequestModel);

    result.fold(
      (l) => emit(AddOrderFailureState(l.message)),
      (r) => emit(AddOrderSuccessState(r!)),
    );
  }
}
