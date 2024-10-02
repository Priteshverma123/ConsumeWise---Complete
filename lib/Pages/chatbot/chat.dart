import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Navbar/nav_menu.dart';
import 'package:fluttercuredoc/Pages/chatbot/drawer.dart';
import 'package:fluttercuredoc/Pages/chatbot/message_widget.dart';
import 'package:fluttercuredoc/Pages/chatbot/typing_indicator.dart';
import 'package:fluttercuredoc/provider/chat_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../camera/newBg.dart';

class ChatScreen extends StatefulWidget {
  final File? imageFile;

  ChatScreen({Key? key, this.imageFile}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textPrompt = TextEditingController();
  bool isDrawerOpen = false;
  File? _selectedImage;

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  void createNewChat(ChatProvider chatProvider) {
    chatProvider.addChatTitle('New Chat');
    chatProvider.setCurrentChatIndex(chatProvider.chatTitles.length - 1);
  }

  void sendImageMessage(File imageFile, ChatProvider chatProvider) {
    chatProvider.addImageMessage(imageFile);
  }

  void attachImage(File imageFile) {
    setState(() {
      _selectedImage = imageFile;
    });
  }

  void sendMessage(ChatProvider chatProvider) {
    FocusManager.instance.primaryFocus?.unfocus(); // Close the keyboard
    if (textPrompt.text.isNotEmpty || _selectedImage != null) {
      chatProvider.sendMessage(textPrompt.text, imageFile: _selectedImage);
      textPrompt.clear();
      setState(() {
        _selectedImage = null; // Clear the selected image after sending
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final controller = Get.find<NavigationController>();
    _selectedImage = controller.selectedImage;
    controller.clearSelectedImage(); // Clear the image after using it

    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    // Check if there are existing chats and create a new chat if none exist
    if (chatProvider.chatTitles.isEmpty) {
      createNewChat(chatProvider);
    }

    // If an image was passed, send it as a message
    if (widget.imageFile != null) {
      attachImage(widget.imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      backgroundColor: chatProvider.isDarkMode ? Color(0xff222222) : Colors.white,
      appBar: AppBar(
        title: Text(
          'C0NSUME BOT',
          style: TextStyle(
            color: chatProvider.isDarkMode ? Colors.white : Color(0xff222222),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: chatProvider.isDarkMode ? Color(0xff333333) : Colors.white,
        elevation: 3,
        titleSpacing: 16,
        actions: [
          IconButton(
            icon: isDrawerOpen
                ? Icon(Icons.cancel, size: 30, color: Colors.red)
                : Icon(Icons.add, size: 30, color: chatProvider.isDarkMode ? Colors.white : Color(0xff222222)),
            onPressed: toggleDrawer,
          ),
        ],
      ),
      body: Stack(
        children: [
          Backgrounds(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: chatProvider.chatTitles.isEmpty
                ? Center(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Image(image: AssetImage("assets/images/police3.png"), fit: BoxFit.cover, width: 300),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      createNewChat(chatProvider);
                    },
                    child: Text(
                      'Start a New Chat',
                      style: TextStyle(color: chatProvider.isDarkMode ? Colors.white : Colors.brown),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                        textStyle: TextStyle(fontSize: 24),
                        backgroundColor: chatProvider.isDarkMode ? Colors.black : Colors.white),
                  ),
                ],
              ),
            )
                : Column(
              children: [
                Expanded(
                  child: chatProvider.prompt.isEmpty
                      ? Center(child: Text('No Chat'))
                      : ListView.builder(
                    controller: chatProvider.scrollController,
                    itemCount: chatProvider.isTyping ? chatProvider.prompt.length + 1 : chatProvider.prompt.length,
                    itemBuilder: (context, index) {
                      if (index == chatProvider.prompt.length) {
                        return CustomTypingIndicator();
                      }
                      final message = chatProvider.prompt[index];
                      final formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(message.time);

                      return MessageWidget(
                        isPrompt: message.isPrompt,
                        message: message.message,
                        date: formattedDate,
                        isImage: message.isImage, // Pass the image flag
                        imageFile: message.imageFile, // Pass the image file
                      );
                    },
                  ),
                ),
                if (_selectedImage != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Image.file(_selectedImage!, fit: BoxFit.cover, width: double.infinity),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.cancel, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _selectedImage = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      flex: 32,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: chatProvider.isDarkMode
                                  ? Color(0xff333333).withOpacity(0.3)
                                  : Colors.white.withOpacity(0.3),
                            ),
                            child: TextField(
                              autocorrect: true,
                              controller: textPrompt,
                              style: TextStyle(
                                color: chatProvider.isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                                hintText: 'How can I help you....',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => sendMessage(chatProvider),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: chatProvider.isDarkMode ? Color(0xff333333) :Color(0xffFFC83A),
                            child: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: chatProvider.isDarkMode ? Color(0xffFFC83A) : Color(0xff1E3A5F),
                                size: 32,
                              ),
                              onPressed: () => sendMessage(chatProvider),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isDrawerOpen)
            GestureDetector(
              onTap: toggleDrawer, // Close drawer when tapped outside
              child: Container(
                color: Colors.black.withOpacity(0.1), // Semi-transparent background
              ),
            ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(
              isDrawerOpen ? 0 : -MediaQuery.of(context).size.width * 0.7,
              0,
              0,
            ),
            child: CustomDrawer(), // Add the custom drawer here
          ),
          Positioned(
            bottom: 80,
            left: 160,
            child: chatProvider.showScrollToBottomButton
                ? FloatingActionButton(
              onPressed: chatProvider.scrollToBottom,
              mini: true,
              backgroundColor: chatProvider.isDarkMode ? Color(0xff222222) : Colors.white,
              child: Icon(Icons.arrow_downward, color: chatProvider.isDarkMode ? Colors.white : Color(0xff222222)),
            )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
