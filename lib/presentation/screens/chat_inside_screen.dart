// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:stayfinder_vendor/constants/ip.dart';
import 'package:stayfinder_vendor/data/api/api_exports.dart';

import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

import '../../data/model/model_exports.dart';

class ChatInsideScreen extends StatefulWidget {
  final String user;
  final String senderLink;
  final String reciever;

  ChatInsideScreen(
      {super.key,
      required this.user,
      required this.senderLink,
      required this.reciever});

  @override
  State<ChatInsideScreen> createState() => _ChatInsideScreenState();
}

class _ChatInsideScreenState extends State<ChatInsideScreen> {
  final TextEditingController _messageController = new TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listenWhen: (previous, current) {
        print(current);
        print(previous);
        return true;
      },
      listener: (context, state) {
        if (state is ChatMessageReceived) {
          context
              .read<ViewParticularChatCubit>()
              .addMessage(chat: state.message);
        }
      },
      child: Scaffold(
        bottomNavigationBar: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                      height: 50,
                      child: CustomFormField(
                        controller: _messageController,
                        inputFormatters: [],
                        validatior: (p0) {
                          if (p0 == null || p0 == "") {
                            return "Please enter message";
                          }
                          return null;
                        },
                        onTapOutside: (p0) => FocusScope.of(context).unfocus(),
                        labelText: "Send message",
                      )),
                )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ChatCubit>().sendMessage(
                                sender: widget.user,
                                receiver: widget.reciever,
                                message: _messageController.text);
                          }
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xffECEFF1),
        appBar: AppBar(
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          leading: InkWell(
            onTap: () async {
              var loginState = context.read<LoginBloc>().state;
              if (loginState is LoginLoaded) {
                await context.read<GetAllMessagesCubit>()
                  ..getAllMessages(
                      token: loginState.successModel.token!,
                      userId: loginState.successModel.user!.id!.toString());
                final cubit = context.read<ChatCubit>();
                cubit.disconnectWebSocket();
              }
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xff455A64),
          title: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(widget.user,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500))
            ],
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ViewParticularChatCubit, ViewParticularChatState>(
            builder: (context, state) {
              if (state is ViewParticularChatLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ViewParticularChatErrror) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomMaterialButton(
                        onPressed: () {},
                        child: Text('Try Again'),
                        backgroundColor: Color(0xff29383F),
                        textColor: Colors.white,
                        height: 45)
                  ],
                );
              }
              if (state is ViewParticularChatSuccess) {
                // if (state.chats.length == 0) {
                //   return Text("No Chats Recieved Yet");
                // }

                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _scrollToBottom());
                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: state.chats.length,
                  itemBuilder: (context, index) {
                    late int userId;
                    ChatModel chat = state.chats[index];
                    var loginState = context.read<LoginBloc>().state;
                    if (loginState is LoginLoaded) {
                      userId = loginState.successModel.user!.id!;
                    }

                    return Align(
                        alignment: userId != chat.sender!.id!
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: ChatWidget(
                          color: userId != chat.sender!.id!
                              ? Colors.white
                              : Colors.pink.withOpacity(0.1),
                          message: chat.message,
                          imageLink: userId != chat.sender!.id!
                              ? state.imageLink
                              : null,
                          senderLink: state.imageLink,
                          date: chat.date != null
                              ? DateTime.parse(chat.date.toString())
                              : null,
                        ));
                  },

                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: ChatWidget(senderLink: senderLink)),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: ChatWidget(senderLink: senderLink)),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: ChatWidget(senderLink: senderLink)),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: ChatWidget(senderLink: senderLink)),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: ChatWidget(senderLink: senderLink)),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: ChatWidget(senderLink: senderLink)),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: ChatWidget(senderLink: senderLink)),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: ChatWidget(senderLink: senderLink)),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: ChatWidget(senderLink: senderLink)),
                );
              }
              return Text("data");
            },
          ),
        ),
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  ChatWidget(
      {Key? key,
      required this.senderLink,
      this.date,
      this.message,
      this.imageLink,
      required this.color})
      : super(key: key);
  final Color color;
  final String senderLink;
  String? message;
  String? imageLink;
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    if (this.message == null) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 100,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: "${getIpWithoutSlash()}${imageLink}",
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider),
                        borderRadius: BorderRadius.circular(15)),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              date != null ? timeAgo(date!) : "",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.5)),
            )
          ],
        ),
      );
    }
    return Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              selectedTileColor: color,
              tileColor: color,
              title: Text(
                message!,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
              ),
              trailing: date != null
                  ? Text(
                      timeAgo(date!),
                      style:
                          TextStyle(fontSize: 8, fontWeight: FontWeight.w300),
                    )
                  : null,
              leading: imageLink == null
                  ? null
                  : Container(
                      width: 30,
                      height: 30,
                      child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(100)),
                            );
                          },
                          imageUrl: "${getIpWithoutSlash()}${imageLink}"),
                    )),
        ));
  }
}
