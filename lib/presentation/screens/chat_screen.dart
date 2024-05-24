import 'package:stayfinder_vendor/data/model/chat_model.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';

import '../../presentation/widgets/widgets_exports.dart';
import 'chat_inside_screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff37474F),
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Chats",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async => fetchMainChats(context),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child:
                          BlocBuilder<GetAllMessagesCubit, GetAllMessagesState>(
                        builder: (context, state) {
                          if (state is GetAllMessagesInitial) {
                            fetchMainChats(context);
                          }
                          if (state is GetAllMessagesLoading) {
                            Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is GetAllMessagesError) {
                            return Center(
                              child: Column(
                                children: [
                                  Text(
                                    state.message,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff514f53),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomMaterialButton(
                                      onPressed: () {
                                        var loginState =
                                            context.read<LoginBloc>().state;
                                        if (loginState is LoginLoaded) {
                                          context.read<GetAllMessagesCubit>()
                                            ..getAllMessages(
                                                token: loginState
                                                    .successModel.token!,
                                                userId: loginState
                                                    .successModel.user!.id!
                                                    .toString());
                                        }
                                      },
                                      child: Text(
                                        "Error",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff514f53),
                                        ),
                                      ),
                                      backgroundColor: Color(0xff514f53),
                                      textColor: Colors.white,
                                      height: 45)
                                ],
                              ),
                            );
                          }
                          if (state is GetAllMessagesSuccess) {
                            // if (state.messages.length == 0) {

                            // }
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: state.messages.length == 0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text("No Chats Yet"),
                                        ),
                                      ],
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.messages.length,
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        ChatModel model = state.messages[index];
                                        int? userId;
                                        int? recieverId;
                                        String? recieverName;
                                        bool? hasSent = false;
                                        var loginState =
                                            context.read<LoginBloc>().state;
                                        if (loginState is LoginLoaded) {
                                          userId =
                                              loginState.successModel.user!.id;
                                        }
                                        if (model.sender!.id == userId) {
                                          recieverId = model.receiver!.id!;
                                          recieverName =
                                              model.receiver!.full_name;
                                        }
                                        if (model.receiver!.id == userId) {
                                          recieverId = model.sender!.id!;
                                          recieverName =
                                              model.sender!.full_name;
                                          hasSent = true;
                                        }
                                        return Column(
                                          children: [
                                            // InkWell(
                                            //   onTap: () {
                                            //     // final cubit =
                                            //     //     context.read<ChatCubit>();
                                            //     // cubit.connectWebSocket(
                                            //     //     senderId: userId.toString(),
                                            //     //     receiverId:
                                            //     //         recieverId.toString());
                                            //     // var state = context
                                            //     //     .read<LoginBloc>()
                                            //     //     .state;
                                            //     // if (state is LoginLoaded) {
                                            //     //   context
                                            //     //       .read<
                                            //     //           ViewParticularChatCubit>()
                                            //     //       .fetchParticularUserMessage(
                                            //     //           token: state
                                            //     //               .successModel
                                            //     //               .token!,
                                            //     //           senderId:
                                            //     //               userId.toString(),
                                            //     //           recieverId: recieverId
                                            //     //               .toString());
                                            //     //   context
                                            //     //       .read<
                                            //     //           SeenAllMessagesCubit>()
                                            //     //       .viewAllMessages(
                                            //     //           token: state
                                            //     //               .successModel
                                            //     //               .token!,
                                            //     //           userId:
                                            //     //               userId.toString(),
                                            //     //           recieverId: recieverId
                                            //     //               .toString());
                                            //     //   var loginState = context
                                            //     //       .read<LoginBloc>()
                                            //     //       .state;
                                            //     //   if (loginState
                                            //     //       is LoginLoaded) {
                                            //     //     context.read<
                                            //     //         GetAllMessagesCubit>()
                                            //     //       ..getAllMessages(
                                            //     //           token: loginState
                                            //     //               .successModel
                                            //     //               .token!,
                                            //     //           userId: loginState
                                            //     //               .successModel
                                            //     //               .user!
                                            //     //               .id!
                                            //     //               .toString());
                                            //     //   }
                                            //     //   Navigator.push(
                                            //     //       context,
                                            //     //       MaterialPageRoute(
                                            //     //         builder: (context) =>
                                            //     //             ChatInsideScreen(
                                            //     //                 reciever: recieverId
                                            //     //                     .toString(),
                                            //     //                 senderLink:
                                            //     //                     "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?q=80&w=2885&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                            //     //                 user: userId
                                            //     //                     .toString()),
                                            //     //       ));
                                            //     // }
                                            //   },
                                            //   child: ListTile(
                                            //     leading: Icon(
                                            //       Icons.person_pin_sharp,
                                            //       color: Colors.black
                                            //           .withOpacity(0.5),
                                            //     ),
                                            //     trailing: Text(
                                            //       timeAgo(DateTime.parse(
                                            //           model.date!)),
                                            //       style: TextStyle(
                                            //           fontSize: 8,
                                            //           fontWeight:
                                            //               FontWeight.w500,
                                            //           color: Color(0xffC9C9B1)),
                                            //     ),
                                            //     contentPadding:
                                            //         EdgeInsets.all(0),
                                            //     title: Text(
                                            //       recieverName!,
                                            //       style: TextStyle(
                                            //         fontSize: 13,
                                            //         fontWeight: FontWeight.w600,
                                            //         color: Color(0xff514f53),
                                            //       ),
                                            //     ),
                                            //     subtitle: Text(
                                            //       model.image != "" &&
                                            //               model.image != null
                                            //           ? hasSent
                                            //               ? "Sent an attachment"
                                            //               : "You sent an attachment"
                                            //           : model.message!,
                                            //       style: TextStyle(
                                            //           fontSize: 10,
                                            //           fontWeight:
                                            //               !model.is_read!
                                            //                   ? FontWeight.w500
                                            //                   : FontWeight.w300,
                                            //           color: !model.is_read!
                                            //               ? Colors.black
                                            //                   .withOpacity(0.9)
                                            //               : Colors.black
                                            //                   .withOpacity(
                                            //                       0.5)),
                                            //     ),
                                            //   ),
                                            // ),
                                            ChatListItem(
                                              model: model,
                                              receiverId: recieverId.toString(),
                                              receiverName: recieverName!,
                                              userId: userId.toString(),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        );
                                      },
                                    ),
                            );
                          }
                          return Text("");
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void fetchMainChats(BuildContext context) {
    var loginState = context.read<LoginBloc>().state;
    if (loginState is LoginLoaded) {
      context.read<GetAllMessagesCubit>()
        ..getAllMessages(
            token: loginState.successModel.token!,
            userId: loginState.successModel.user!.id!.toString());
    }
  }
}

class ChatListItem extends StatelessWidget {
  final String userId;
  final String receiverId;
  final String receiverName;
  final ChatModel model;

  ChatListItem({
    Key? key,
    required this.userId,
    required this.receiverId,
    required this.receiverName,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final cubit = context.read<ChatCubit>();
        await cubit
          ..connectWebSocket(
              senderId: userId.toString(), receiverId: receiverId.toString());
        var state = context.read<LoginBloc>().state;
        if (state is LoginLoaded) {
          context.read<ViewParticularChatCubit>().fetchParticularUserMessage(
              token: state.successModel.token!,
              senderId: userId.toString(),
              recieverId: receiverId.toString());
          context.read<SeenAllMessagesCubit>().viewAllMessages(
              token: state.successModel.token!,
              userId: userId.toString(),
              recieverId: receiverId.toString());
          var loginState = context.read<LoginBloc>().state;
          if (loginState is LoginLoaded) {
            context.read<GetAllMessagesCubit>()
              ..getAllMessages(
                  token: loginState.successModel.token!,
                  userId: loginState.successModel.user!.id!.toString());
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatInsideScreen(
                    reciever: receiverId.toString(),
                    senderLink:
                        "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?q=80&w=2885&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    user: userId.toString()),
              ));
        }

        // print("the user id is $userId");
        // print("the receiver id is $receiverId");

        // final chatCubit = context.read<ChatCubit>();
        // chatCubit.connectWebSocket(senderId: userId, receiverId: receiverId);

        // final loginState = context.read<LoginBloc>().state;
        // if (loginState is LoginLoaded) {
        //   final token = loginState.successModel.token!;
        //   context.read<ViewParticularChatCubit>().fetchParticularUserMessage(token: token, senderId: userId, receiverId: receiverId);
        //   context.read<SeenAllMessagesCubit>().viewAllMessages(token: token, userId: userId, receiverId: receiverId);
        //   context.read<GetAllMessagesCubit>().getAllMessages(token: token, userId: loginState.successModel.user!.id!.toString());

        //   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatInsideScreen(receiver: receiverId, senderLink: "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?q=80&w=2885&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", user: userId)));
        // }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurple.withOpacity(0.1),
              child: Icon(Icons.person, color: Colors.deepPurple),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receiverName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    model.message ?? "Sent an attachment",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  timeAgo(DateTime.parse(model.date!)),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Icon(Icons.check_circle,
                    color: model.is_read! ? Colors.green : Colors.grey,
                    size: 13),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
