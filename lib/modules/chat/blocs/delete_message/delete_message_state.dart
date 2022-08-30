part of 'delete_message_bloc.dart';

abstract class DeleteMessageState extends Equatable {
  const DeleteMessageState();

  @override
  List<Object> get props => [];
}

class DeleteMessageInitial extends DeleteMessageState {}

class DeleteMessageLoadingState extends DeleteMessageInitial {}

class DeleteMessageSuccesState extends DeleteMessageInitial {}
