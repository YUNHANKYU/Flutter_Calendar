import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _value = '';

  static List<DateTime> db = [
    DateTime(2019, 03, 01),
    DateTime(2019, 03, 02),
    DateTime(2019, 03, 03),
    DateTime(2019, 03, 04),
    DateTime(2019, 03, 05),
    DateTime(2019, 03, 06),
    DateTime(2019, 03, 07),
    DateTime(2019, 03, 08),
    DateTime(2019, 03, 09),
    DateTime(2019, 03, 11),
    DateTime(2019, 03, 13),
    DateTime(2019, 03, 17),
    DateTime(2019, 03, 20),
    DateTime(2019, 03, 25),
    DateTime(2019, 03, 30),
  ];
  Set<String> unselectableDates = getDateSet(db);

  static Set<String> getDateSet(List<DateTime> dates) =>
      dates.map(sanitizeDateTime).toSet();

  static String sanitizeDateTime(DateTime dateTime) =>
      "${dateTime.year}-${dateTime.month}-${dateTime.day}";

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      //TODO: 일지 등록한 날짜만 활성화 되도록 하고 싶으면 initialDate를 가장 최근 일지를 등록한 날짜로 설정해야함
      firstDate: new DateTime(
        DateTime.now().year,
        DateTime.now().month-5,
        DateTime.now().day,
      ),
      lastDate: new DateTime.now(),
      ///아래 selectableDayPredicate는
      ///현재는 위 db 리스트에 있는 날짜들은 일지 작성 안한 날짜들 !!
      selectableDayPredicate: (DateTime val) {
        String sanitized = sanitizeDateTime(val);
        return !unselectableDates.contains(sanitized);
      }, //TODO: 위 TODO를 하려면 'return !unselectableDates.contains(sanitized) == true ? false : true ;'로 변경

      /// -------테마 관련-------
//      builder: (BuildContext context, Widget child) {
//        return Theme(
//          data: ThemeData.dark(),
//          child: child,
//        );
//      },
      /// ---------------------
    );
    if (picked != null) setState(() => _value = picked.toString());
  }

  /// --------MonthPicker시도 - 일단 실패 --------------------------------
//  DateTime _selectedDate = DateTime.now();
//
//  void _onSelectedDateChanged(DateTime newDate) {
//    setState(() {
//      _selectedDate = newDate;
//    });
//  }
//
//  Future _selectYear() async {
//    MonthPicker picked = MonthPicker(
//        selectedDate: _selectedDate,
//        onChanged: _onSelectedDateChanged,
//        firstDate: DateTime(2019,01,01),
//        lastDate: DateTime(2019,06,24)
//    );
//
//    if (picked != null) setState(() => _value = picked.toString());
//  }
  /// --------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar Test',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Name here'),
        ),
        //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
        body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text(_value),
                new RaisedButton(
                  onPressed:
                  _selectDate,
//                  _selectYear,
                  child: new Text('Click me'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
