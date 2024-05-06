import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_images_state.dart';

class ProductImagesCubit extends Cubit<int> {
  ProductImagesCubit() : super(0);

  void changeCurrentImageIndex(int index) {
    emit(index);
  }
}
