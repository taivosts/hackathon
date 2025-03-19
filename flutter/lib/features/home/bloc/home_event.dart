part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class AccountSettingsRequested extends HomeEvent {}

final class MessageSent extends HomeEvent {
  final String message;

  const MessageSent(this.message);

  @override
  List<Object> get props => [message];
}

final class NewThreadCreated extends HomeEvent {}

final class FetchWorkspaces extends HomeEvent {}

final class WorkspaceSelected extends HomeEvent {
  final Workspace workspace;

  const WorkspaceSelected(this.workspace);

  @override
  List<Object> get props => [workspace];
}

final class LogoutRequested extends HomeEvent {}
