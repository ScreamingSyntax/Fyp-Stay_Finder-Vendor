part of 'view_particular_chat_cubit.dart';

sealed class ViewParticularChatState extends Equatable {
  const ViewParticularChatState();

  @override
  List<Object> get props => [];
}

class ViewParticularChatInitial extends ViewParticularChatState {}

class ViewParticularChatLoading extends ViewParticularChatState {}

class ViewParticularChatSuccess extends ViewParticularChatState {
  final List<ChatModel> chats;
  final String imageLink;
  ViewParticularChatSuccess(this.imageLink, {required this.chats});
  ViewParticularChatSuccess copyWith({
    List<ChatModel>? chats,
    String? imageLink,
  }) {
    return ViewParticularChatSuccess(
      imageLink ?? this.imageLink,
      chats: chats ?? this.chats,
    );
  }

  @override
  List<Object> get props => [chats, imageLink];
}

class ViewParticularChatErrror extends ViewParticularChatState {
  final String message;

  ViewParticularChatErrror({required this.message});
}
