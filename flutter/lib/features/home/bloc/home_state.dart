part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState._({
    required this.messages,
    required this.workspaces,
    this.selectedWorkspace,
  });

  const HomeState.unknown() : this._(messages: const [], workspaces: const []);

  final List<Message> messages;
  final List<Workspace> workspaces;
  final Workspace? selectedWorkspace;

  @override
  List<Object?> get props => [messages, workspaces, selectedWorkspace];

  HomeState copyWith({
    List<Message>? messages,
    List<Workspace>? workspaces,
    Workspace? selectedWorkspace,
  }) {
    return HomeState._(
      messages: messages ?? this.messages,
      workspaces: workspaces ?? this.workspaces,
      selectedWorkspace: selectedWorkspace ?? this.selectedWorkspace,
    );
  }
}
