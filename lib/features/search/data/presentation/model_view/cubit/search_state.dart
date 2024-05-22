part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchSuccessState extends SearchState {
  final List<BranchProductModel> searchResults;
  const SearchSuccessState(this.searchResults);
}

final class SearchErrorState extends SearchState {
  final String message;
  const SearchErrorState(this.message);
}
