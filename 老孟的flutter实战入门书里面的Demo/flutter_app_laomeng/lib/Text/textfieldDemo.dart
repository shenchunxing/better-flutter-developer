import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldDemo extends StatefulWidget {
  @override
  _TextFieldDemoState createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  var _textFieldValue = '';
  late TextEditingController _controller;
  var _focusNode = FocusNode();//焦点

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController()..addListener(() {
      _controller.text = _controller.text.toUpperCase(); //转大写
    });
  }

  @override
  Widget build(BuildContext context) {
    return textFieldDemo1(context);
//  return qq();
  return TextField(controller: _controller,);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Widget textFieldDemo1(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,//垂直方向对齐方式
      textDirection: TextDirection.rtl, //文本方向

      maxLength: 20,
      //统计字数，严谨
      buildCounter: (BuildContext context , {int? currentLength, int? maxLength ,bool? isFocused, }) {
        return Text('$currentLength/$maxLength',);
      },

      focusNode: _focusNode,

      obscureText: true,//加密

      //输入格式限制
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
      ],

      //光标
      showCursor: true,
      cursorWidth: 3,
      cursorRadius: Radius.circular(10),
      cursorColor: Colors.red,

      //长按弹窗选项
      toolbarOptions: ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
          selectAll: true
      ),

      onChanged: (value) {
        print("value = $value");
        setState(() {
          _textFieldValue = value;
        });
      },

      onEditingComplete: () { //onEditingComplete与onSubmitted都在同一个方法内调用.先调用onEditingComplete再调用onSubmitted,有onEditingComplete方法时,会忽略设置了的TextInputAction类型系统默认焦点操作.(释放焦点,跳转下一个/上一个焦点)
        print('onEditingComplete');
      },

      onTap: () { //点击输入框
        print('onTap');
      },

      onSubmitted: (value) { //点击回车或者点击软键盘上的完成回调,带有字符串
        print('onSubmitted - $value');
      },

      decoration: InputDecoration(
//        counterText: '${_textFieldValue.length}/32', 不严谨
        prefixIcon: Icon(Icons.add), //输入框内面，头部
        suffixIcon: Icon(Icons.delete), //输入框内面,尾部
        icon: Icon(Icons.person), //输入框外

        labelText: '姓名：',
        labelStyle: TextStyle(color:Colors.red),

        helperText: '用户名长度为6-10个字母',
        helperStyle: TextStyle(color: Colors.blue),
        helperMaxLines: 1,

        hintText: '请输入用户名',
        hintStyle: TextStyle(color: Colors.grey),
        hintMaxLines: 1,

        errorText: '用户名输入错误',
        errorStyle: TextStyle(fontSize: 12),
        errorMaxLines: 1,
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),

      ),
    );
  }


//仿QQ输入框
  Widget qq() {
    return Container(
      height: 60,
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          fillColor: Color(0x30cccccc),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00FF0000)),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          hintText: 'QQ号/手机号/邮箱',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00000000)),
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
      ),
    );
  }
}
