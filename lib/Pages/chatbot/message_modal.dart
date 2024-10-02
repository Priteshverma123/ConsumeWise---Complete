import 'dart:convert';
import 'dart:io';

class ModelMessage {
  final bool isPrompt;
  final String message;
  final DateTime time;
  final File? imageFile; // Add imageFile property
  final bool isImage; // Add this field

  ModelMessage({
    required this.isPrompt,
    required this.message,
    required this.time,
    this.imageFile, // Allow imageFile to be optional
    this.isImage = false, // Default value to false

  });

  Map<String, dynamic> toMap() {
    return {
      'isPrompt': isPrompt,
      'message': message,
      'time': time.toIso8601String(),
      'imageFile': imageFile?.path,
      'isImage': isImage, // Include in the map
// Store the path if imageFile is not null
// Serialize DateTime to ISO 8601 string
    };
  }

  factory ModelMessage.fromMap(Map<String, dynamic> map) {
    return ModelMessage(
      isPrompt: map['isPrompt'],
      message: map['message'],
      time: DateTime.parse(map['time']),
      imageFile: map['imageFile'] != null ? File(map['imageFile']) : null,
      isImage: map['isImage'] ?? false, // Retrieve the image flag
// Recreate the File object if path is stored
// Deserialize ISO 8601 string to DateTime
    );
  }
}
