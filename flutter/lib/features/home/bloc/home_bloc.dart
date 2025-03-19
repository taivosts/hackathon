import 'dart:async';
import 'package:ai_dreamer/domain_models/chat_message_response.dart';
import 'package:ai_dreamer/domain_models/message.dart';
import 'package:ai_dreamer/domain_models/workspace.dart';
import 'package:ai_dreamer/features/app/app_session.dart';
import 'package:ai_dreamer/features/common/dialogs/primary_alert_dialog.dart';
import 'package:ai_dreamer/resource/app_constants.dart';
import 'package:ai_dreamer/utils/network_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ai_dreamer/features/common/navigation_service.dart';
import 'package:ai_dreamer/network/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final AnythingLLMRepository anythingLLMRepository;
  final AuthenticationRepository authenticationRepository;

  HomeBloc({
    required this.userRepository,
    required this.anythingLLMRepository,
    required this.authenticationRepository,
  }) : super(const HomeState.unknown()) {
    on<AccountSettingsRequested>(_onAccountSettingsRequested);
    on<MessageSent>(_onMessageSent);
    on<NewThreadCreated>(_onNewThreadCreated);
    on<FetchWorkspaces>(_onFetchWorkspaces);
    on<WorkspaceSelected>(_onWorkspaceSelected);
    on<LogoutRequested>(_onLogoutRequested);

    // Fetch workspaces after initialization
    add(FetchWorkspaces());
  }

  BuildContext? get context => NavigationService.navigatorKey.currentContext;

  void _onAccountSettingsRequested(
    AccountSettingsRequested event,
    Emitter<HomeState> emit,
  ) {}

  Future<void> _onMessageSent(
    MessageSent event,
    Emitter<HomeState> emit,
  ) async {
    final slug = state.selectedWorkspace?.slug;
    if (slug == null) {
      return;
    }

    // Create new thread if slug is null
    // 37551185-4e20-43e7-b083-8a644d66375e
    var threadSlug = await AppSession.shared.getThreadSlug();
    if (threadSlug == null) {
      threadSlug = await anythingLLMRepository.createNewThread(slug: slug);
      await AppSession.shared.setThreadSlug(threadSlug);
    }

    // Add user message to the chat
    final currentMessages = state.messages;

    final newMessage = Message(
      text: event.message,
      isGenerated: false,
      createdAt: DateTime.now(),
      type: MessageType.text,
    );

    // Add thinking message to the chat
    final thinkingMessage = Message(
      text: 'Thinking...',
      isGenerated: true,
      createdAt: DateTime.now(),
      type: MessageType.thinking,
    );

    emit(
      state.copyWith(
        messages: [...currentMessages, newMessage, thinkingMessage],
      ),
    );

    // Fetch and add response to the chat
    List<ChatMessageResponse> newMessages = [];
    await anythingLLMRepository
        .fetchMessage(
      slug: slug,
      threadSlug: threadSlug,
      question: event.message,
    )
        .forEach(
      (message) {
        newMessages.add(message);

        final newResponse = Message(
          text: newMessages.map((e) => e.textResponse).join(''),
          isGenerated: true,
          createdAt: DateTime.now(),
          type: MessageType.text,
          sources: message.sources
              ?.map((e) => DocsSource(title: e.title ?? '', url: e.url ?? ''))
              .toList(),
        );

        emit(
          state.copyWith(
            messages: [...currentMessages, newMessage, newResponse],
          ),
        );
      },
    );
  }

  Future<void> _onNewThreadCreated(
    NewThreadCreated event,
    Emitter<HomeState> emit,
  ) async {
    AppSession.shared.setThreadSlug(null);
    emit(
      state.copyWith(
        messages: [],
      ),
    );
  }

  Future<void> _onFetchWorkspaces(
    FetchWorkspaces event,
    Emitter<HomeState> emit,
  ) async {
    final workspaces = await callWithIndicatorAndPopupError(
      () => anythingLLMRepository.fetchWorkspaces(),
    );
    emit(state.copyWith(
        workspaces: workspaces, selectedWorkspace: workspaces.first));
    AppSession.shared.setThreadSlug(null);
  }

  Future<void> _onWorkspaceSelected(
    WorkspaceSelected event,
    Emitter<HomeState> emit,
  ) async {
    if (event.workspace.slug == state.selectedWorkspace?.slug) {
      return;
    }
    emit(state.copyWith(selectedWorkspace: event.workspace));
    add(NewThreadCreated());
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<HomeState> emit,
  ) async {
    await PrimaryAlertDialog(
      title: AppConstants.appName,
      description: 'Are you sure you want to logout?',
      confirmButtonTitle: 'Logout',
      dismissButtonTitle: 'Cancel',
      onConfirmPressed: () {
        AppSession.shared.setCredentials(null);
        authenticationRepository.logOut();
      },
    ).show();
  }
  /*
  Future<void> handleDummyMessage(
      MessageSent event, Emitter<HomeState> emit) async {
    final currentMessages = state.messages;

    final newMessage = Message(
      text: event.message,
      isGenerated: false,
      createdAt: DateTime.now(),
      type: MessageType.text,
    );

    final thinkingMessage = Message(
      text: 'Thinking...',
      isGenerated: true,
      createdAt: DateTime.now(),
      type: MessageType.thinking,
    );

    emit(
      state.copyWith(
        messages: [...currentMessages, newMessage, thinkingMessage],
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    final newResponse = (fakeMessages.shuffle()).first;

    emit(
      state.copyWith(
        messages: [...currentMessages, newMessage, newResponse],
      ),
    );
  }
  */
}
