import 'package:flutter_bloc/flutter_bloc.dart';

class ProductImagesCubit extends Cubit<int> {
  ProductImagesCubit() : super(0);

  void changeCurrentImageIndex(int index) {
    emit(index);
  }
}
