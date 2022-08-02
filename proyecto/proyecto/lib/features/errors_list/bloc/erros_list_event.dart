part of 'errors_list_bloc.dart';

abstract class ErrorsListEvent extends Equatable{}

class LoadErrorsEvent extends ErrorsListEvent{
  @override
  List<Object?> get props => [];
}