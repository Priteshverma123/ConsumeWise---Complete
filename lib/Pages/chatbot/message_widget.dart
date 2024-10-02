import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:fluttercuredoc/provider/chat_provider.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatefulWidget {
  final bool isPrompt;
  final String message;
  final String date;
  final File? imageFile; // Add this to handle image rendering
  final bool isImage; // Add a flag to check if it's an image

  const MessageWidget({
    Key? key,
    required this.isPrompt,
    required this.message,
    required this.date,
    this.imageFile,
    this.isImage = false, // Default is false
  }) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 15).copyWith(
        left: widget.isPrompt ? 80 : 15,
        right: widget.isPrompt ? 15 : 80,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: chatProvider.isDarkMode
            ? (widget.isPrompt ? Color(0xff333333) : Color(0xffFFC83A))
            : (widget.isPrompt ? Color(0xffFFC83A) : Color(0xff333333)),
        borderRadius: widget.isPrompt
            ? BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        )
            : BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isImage && widget.imageFile != null)
            Column(
              children: [
                _buildImageWidget(widget.imageFile!), // Display the image
                const SizedBox(height: 10), // Add space between image and text
              ],
            ),
          if (widget.message.isNotEmpty) _buildTextWidget(), // Display the text
          _buildDateWidget(), // Display the date
        ],
      ),
    );
  }
  Widget _buildTextWidget() {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 5.0), // Adjust padding as needed
      child: Text(
        widget.message,
        style: TextStyle(
          fontWeight: widget.isPrompt ? FontWeight.bold : FontWeight.normal,
          fontSize: 18,
          color: chatProvider.isDarkMode
              ? (widget.isPrompt ? Colors.white : const Color(0xff333333))
              : (widget.isPrompt ? const Color(0xff333333) : Colors.white),
        ),
      ),
    );
  }
  Widget _buildDateWidget() {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          widget.date,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: widget.isPrompt && chatProvider.isDarkMode
                ? Colors.white.withOpacity(0.7)
                : Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  // Method to build the image widget
  Widget _buildImageWidget(File imageFile) {
    return imageFile.existsSync()
        ? Image.file(
      imageFile,
      height: 200, // Adjust height as needed
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Text('Failed to load image');
      },
    )
        : const Text('Image not found');
  }
}
