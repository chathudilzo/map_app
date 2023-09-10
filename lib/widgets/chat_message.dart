import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({
    Key? key,
    required this.sender,
    required this.text,
    this.isImage = false,
  }) : super(key: key);

  final String sender;
  final String text;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sender=='You'?
            Text(
              sender,
              style: TextStyle(fontWeight: FontWeight.bold), // Example text style
            ):Container(),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                //color: sender == "user" ? Color.fromARGB(255, 16, 176, 224) : const Color.fromARGB(255, 121, 122, 121),
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: isImage
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        text,
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : const CircularProgressIndicator.adaptive(),
                      ),
                    )
                  : Text(
                      text,
                      softWrap: true,
                      style: TextStyle(fontSize: 16.0,color: const Color.fromARGB(255, 109, 108, 108)), // Example text style
                    ),
            ),
            sender=='Bong'?
            Text(
              sender,
              style: TextStyle(fontWeight: FontWeight.bold), // Example text style
            ):Container(),
          ],
        ),
      ),
    );
  }
}
