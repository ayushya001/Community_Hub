import 'package:flutter/material.dart';


class SearchWidget extends StatefulWidget {
  final Function(String) onSearchChanged;

  const SearchWidget({Key? key, required this.onSearchChanged}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: mq.height * 0.01),
      child: Container(
        width: mq.width * 0.8,
        height: mq.height * 0.07,
        child: Card(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: mq.width * 0.02),
            child: TextField(
              onChanged: (val) {
                // Search logic
                widget.onSearchChanged(val);
              },
              controller: _textController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onTap: () {},
              decoration: InputDecoration(
                hintText: "Search Question",
                hintStyle: TextStyle(color: Color(0xFF707070)),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

