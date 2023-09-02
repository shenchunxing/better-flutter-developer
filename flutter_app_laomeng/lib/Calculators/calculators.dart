import 'package:flutter/material.dart';

class Calculators extends StatefulWidget {
  @override
  _CalculatorsState createState() => _CalculatorsState();
}

class _CalculatorsState extends State<Calculators> {
  String _text = '0';//显示当前输入的数字和计算结果
  String _beforeText = '';//用于保存被加数，比如输入 5+1，保存 5 ，用于后面的计算
  bool _isResult = false;//表示当前值是否为计算的结果，true：新输入数字直接显示，false：新输入数字和当前字符串相加，比如当前显示 5，如果是计算的结果，点击 1 时，直接显示1，否则显示 51。
  String _operateText = '';//保存加减乘除

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: <Widget>[
          Expanded( //显示框
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                '$_text',
                maxLines: 1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _CalculatorKeyboard( //键盘区
            onValueChange: _onValueChange,
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }

  //操作
  void _onValueChange(String value) {
    switch (value) {
      case 'AC':
        _text = '0';
        _beforeText = '';
        _isResult = false;
        _operateText = '';
        break;
      case '+/-':
        if (_text.startsWith('-')) {
          _text = _text.substring(1);
        } else {
          _text = '-$_text';
        }
        break;

      case '%':
        double d = _value2Double(_text);
        _isResult = true;
        _text = '${d / 100.0}';
        break;

      case '+':
      case '-':
      case 'x':
      case '÷':
        _isResult = false;
        _operateText = value;
        break;

      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case '.':
        if (_isResult) {
          _text = value;
        }
        if (_operateText.isNotEmpty && _beforeText.isEmpty) {
          _beforeText = _text;
          _text = '';
          print('_operateText = $_operateText');
        }
        _text += value;
        print('_text = $_text , value = $value');
        if (_text.startsWith('0')) { //过滤掉前置0
          _text = _text.substring(1);
        }
        break;

      case '=':
        double d = _value2Double(_beforeText);
        double d1 = _value2Double(_text);
        switch (_operateText) {
          case '+':
            _text = '${d + d1}';
            break;
          case '-':
            _text = '${d - d1}';
            break;
          case 'x':
            _text = '${d * d1}';
            break;
          case '÷':
            _text = '${d / d1}';
            break;
        }
        _beforeText = '';
        _isResult = true;
        _operateText = '';
        break;
    };

    setState(() {

    });
  }

  double _value2Double(String value) {
    if (_text.startsWith('-')) {
      String s = value.substring(1);
      return double.parse(s) * -1;
    } else {
      return double.parse(value);
    }
  }
}


class _CalculatorItem extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Color color;
  final Color? highlightColor;
  final double? width;
  final ValueChanged<String> onValueChange;

  _CalculatorItem(
      { this.text,
        required this.textColor,
        required this.color,
        this.highlightColor,
        this.width = 0,
        required this.onValueChange});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(200))),
      child: InkWell(
        onTap: () {
          onValueChange('$text');
        },
        borderRadius: BorderRadius.all(Radius.circular(200)),
        highlightColor: highlightColor ?? color,
        child: Container(
          width: width ?? 70,
          height: 70,
          padding: EdgeInsets.only(left: width == null ? 0 : 25),
          alignment: width == null ? Alignment.center : Alignment.centerLeft,
          child: Text(
            '$text',
            style: TextStyle(color: textColor ?? Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class _CalculatorKeyboard extends StatelessWidget {
  final ValueChanged<String> onValueChange;
   _CalculatorKeyboard({Key? key,required this.onValueChange}) : super(key: key);

  final List<Map> _keyboardList = [
    {
      'text': 'AC',
      'textColor': Colors.black,
      'color': Color(0xFFA5A5A5),
      'highlightColor': Color(0xFFD8D8D8)
    },
    {
      'text': '+/-',
      'textColor': Colors.black,
      'color': Color(0xFFA5A5A5),
      'highlightColor': Color(0xFFD8D8D8)
    },
    {
      'text': '%',
      'textColor': Colors.black,
      'color': Color(0xFFA5A5A5),
      'highlightColor': Color(0xFFD8D8D8)
    },
    {
      'text': '÷',
      'color': Color(0xFFE89E28),
      'highlightColor': Color(0xFFEDC68F)
    },
    {'text': '7', 'color': Color(0xFF363636)},
    {'text': '8', 'color': Color(0xFF363636)},
    {'text': '9', 'color': Color(0xFF363636)},
    {
      'text': 'x',
      'color': Color(0xFFE89E28),
      'highlightColor': Color(0xFFEDC68F)
    },
    {'text': '4', 'color': Color(0xFF363636)},
    {'text': '5', 'color': Color(0xFF363636)},
    {'text': '6', 'color': Color(0xFF363636)},
    {
      'text': '-',
      'color': Color(0xFFE89E28),
      'highlightColor': Color(0xFFEDC68F)
    },
    {'text': '1', 'color': Color(0xFF363636)},
    {'text': '2', 'color': Color(0xFF363636)},
    {'text': '3', 'color': Color(0xFF363636)},
    {
      'text': '+',
      'color': Color(0xFFE89E28),
      'highlightColor': Color(0xFFEDC68F)
    },
    {'text': '0', 'color': Color(0xFF363636), 'width': 158.0},
    {'text': '.', 'color': Color(0xFF363636)},
    {
      'text': '=',
      'color': Color(0xFFE89E28),
      'highlightColor': Color(0xFFEDC68F)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 18,
      spacing: 18,
      children: List.generate(_keyboardList.length, (index) {
        return _CalculatorItem(
          text: _keyboardList[index]['text'],
          textColor: _keyboardList[index]['textColor'],
          color: _keyboardList[index]['color'],
          highlightColor: _keyboardList[index]['highlightColor'],
          width: _keyboardList[index]['width'],
          onValueChange: onValueChange,
        );
      }),
    );
  }
}


