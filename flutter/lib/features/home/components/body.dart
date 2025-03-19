import 'package:ai_dreamer/features/home/bloc/home_bloc.dart';
import 'package:ai_dreamer/features/home/components/page_header.dart';
import 'package:ai_dreamer/features/home/components/user_chat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bot_chat_row.dart';
import 'chat_input.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _scrollController = ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.messages.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: PageHeader(
                      onCreateNew: () =>
                          context.read<HomeBloc>().add(NewThreadCreated()),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.messages.length,
                        itemBuilder: (_, index) {
                          if (state.messages.isEmpty) {
                            return const SizedBox();
                          }

                          if (state.messages[index].isGenerated) {
                            return BotChatRow(
                              message: state.messages[index].text,
                              sources: state.messages[index].sources?.map((e) => e.title).toList() ?? [],
                            );
                          } else {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: UserChatRow(
                                    message: state.messages[index].text),
                              );
                            }
                            return UserChatRow(
                                message: state.messages[index].text);
                          }
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 16),
                    child: ChatInput(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
