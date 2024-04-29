import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repo/order_repo.dart';
import 'payment_method_states.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodStates> {
  PaymentMethodCubit(this._orderRepo) : super(PaymentMethodInitialState());

  final OrderRepo _orderRepo;

  Future getPaymentMethods(String branchId) async {
    emit(PaymentMethodLoadingState());

    var result = await _orderRepo.getPaymentMethods(branchId);

    result.fold(
      (l) => emit(PaymentMethodFailureState(l.message)),
      (r) => emit(PaymentMethodSuccessState(r!)),
    );
  }
}
