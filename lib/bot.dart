import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:map_app/widgets/chat_message.dart';
import 'package:map_app/widgets/three_dots.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  late OpenAI? chatGPT;
  bool _isImageSearch = false;

  bool _isTyping = false;

  @override
  void initState() {
    chatGPT = OpenAI.instance.build(
        token: dotenv.env["OPENAI_API_KEY"],
        baseOption:HttpSetup(
            receiveTimeout: const Duration(seconds: 20),
            connectTimeout: const Duration(seconds: 20)),
        enableLog: true);
    super.initState();
  }

  @override
  void dispose() {
    // chatGPT?.close();
    // chatGPT?.genImgClose();
    super.dispose();
  }

  // Link for api - https://beta.openai.com/account/api-keys

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: "You",
      isImage: false,
    );

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    if (_isImageSearch) {
      final request = GenerateImage(message.text, 1, size: ImageSize.size1024);

      final response = await chatGPT!.generateImage(request);
      //Vx.log(response!.data!.last!.url!);
      insertNewData(response!.data!.last!.url!, isImage: true);
    } else {
      final request =
          CompleteText(prompt: message.text, model: TextCurie001Model());

      final response = await chatGPT!.onCompletion(request: request);
      print(response!.choices[0].text);
      insertNewData(response!.choices[0].text, isImage: false);
    }
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "Bong",
      isImage: isImage,
    );

    setState(() {
      //_isImageSearch=false;
      _isTyping = false;
      _messages.insert(0, botMessage);
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        SizedBox(width: 5,),
        Expanded(
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: const InputDecoration.collapsed(
              hintStyle: TextStyle(color: Colors.white),
              
                hintText: "Ask Enything"),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.send,color: Colors.blue,),
              onPressed: () {
                _isImageSearch = false;
                _sendMessage();
              },
            ),
            TextButton(
                onPressed: () {
                  _isImageSearch = true;
                  _sendMessage();
                },
                child: const Text("Generate Image"))
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
       
        body: 
           Container(
            color: Color.fromARGB(255, 34, 34, 34),
            //decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 44, 44, 44),Colors.black])),
            child: Column(
              children: [
                SizedBox(height: 40,),
                Text('Bongoose',style: TextStyle(color: Color.fromARGB(255, 232, 230, 235),fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Container(
                  width: 50,
          
                  child: ClipRRect(
                    child: Image(image: AssetImage('assets/splash.png')),
                  ),
                ),
                Flexible(
                    child: ListView.builder(
                  reverse: true,
                  
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _messages[index];
                  },
                )),
                if (_isTyping) const ThreeDots(),
                const Divider(
                  height: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 7, 7, 7),
                    ),
                    child: _buildTextComposer(),
                  ),
                )
              ],
            ),
          ),
        );
  }
}