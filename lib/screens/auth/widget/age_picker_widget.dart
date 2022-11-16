import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';

class AgePickerWidget extends StatefulWidget {
  const AgePickerWidget({Key? key}) : super(key: key);

  @override
  State<AgePickerWidget> createState() => _AgePickerWidgetState();
}

class _AgePickerWidgetState extends State<AgePickerWidget> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
           ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: DatePickerWidget(
                  looping: false, // default is not looping
                  firstDate: DateTime.now(), //DateTime(1960),
                  //  lastDate: DateTime(2002, 1, 1),
//              initialDate: DateTime.now(),// DateTime(1994),
                  dateFormat:
                  // "MM-dd(E)",
                  "dd/MMMM/yyyy",
                  // locale: DatePicker.localeFromString('th'),
                  onChange: (DateTime newDate, _) {
                    setState(() {
                      selectedDate = newDate;
                    });
                    print(selectedDate);
                  },
                  pickerTheme: DateTimePickerTheme(
                    backgroundColor: Colors.transparent,
                    itemTextStyle:
                    TextStyle(color: Colors.white, fontSize: 19),
                    dividerColor: Colors.white,
                  ),
                ),
              ),
              Text("${selectedDate ?? ''}"),
            ],
          ),
        ),
      ),
    );
  }
}

