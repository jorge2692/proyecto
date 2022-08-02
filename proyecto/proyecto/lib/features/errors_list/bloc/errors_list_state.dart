part of 'errors_list_bloc.dart';

abstract class ErrorListState extends Equatable{}

class LoadingErrors extends ErrorListState{
  @override
  List<Object?> get props => [];
}

class DataListErrors extends ErrorListState{
  final List<ErrorData> data;

  DataListErrors(this.data);
  @override
  List<Object?> get props => [data];
}