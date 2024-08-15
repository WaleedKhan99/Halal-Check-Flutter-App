import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChange,
  }) : super(key: key);

  bool isChecked;
  final Function(bool) onChange;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool check;
  void toggleChecked() {
    setState(() {
      check = !check;
      widget.onChange(check);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: toggleChecked, // Call the toggleChecked method
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color:
                    widget.isChecked ? Color(0xFF41B478) : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: widget.isChecked ? Color(0xFF41B478) : Colors.grey,
                  width: 2,
                ),
              ),
              child: widget.isChecked
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    )
                  : null,
            ),
          ),
        ),
        CustomeCheckBoxText(checkboxtext: '')
      ],
    );
  }
}

class CustomeCheckBoxText extends StatelessWidget {
  final String checkboxtext;
  const CustomeCheckBoxText({
    super.key,
    required this.checkboxtext,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      checkboxtext,
      style: TextStyle(
        fontFamily: "Euclid Circular A",
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF151B33),
      ),
    );
  }
}
