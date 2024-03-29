import 'package:flutter/material.dart';
import '../const/size.dart';


class OnButton extends StatefulWidget {
  OnButton({Key? key, required this.stuff}) : super(key: key);
  String stuff;

  @override
  State<OnButton> createState() => _OnButtonState();
}

class _OnButtonState extends State<OnButton> {
  @override
  Widget build(BuildContext context) {

    double buttonHeight = SIZE.height*0.12;

    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      height: buttonHeight,
      child: SizedBox(
        width: SIZE.width*0.6,
        child: Center(
            child: Text(
              widget.stuff,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontFamily: "Jua"
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
      ),
    );
  }
}



