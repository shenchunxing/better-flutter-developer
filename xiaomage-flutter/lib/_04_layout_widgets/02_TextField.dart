import 'package:flutter/material.dart';

void main() {
  runApp(TextFieldApp());
}

class TextFieldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         body: TextFieldDemo(),
      ),
    );
  }
}

class TextFieldDemo extends StatelessWidget {

  final usernameTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme (
       data: ThemeData( //全局颜色
         primaryColor: Colors.green,
       ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 150,),
            Stack(
              alignment: Alignment.center,
              children: [
                TextField(
                  controller: usernameTextEditController,
                  decoration: InputDecoration(
                    labelText: 'username',//上面的文字
                    icon: Icon(Icons.people),//左侧的图标
                    hintText: '请输入用户名',//占位文字
                    border: InputBorder.none,//边框
                    filled: true,//是否填充输入框，默认为false
                    fillColor: Colors.red[100],//输入框填充的颜色
                  ),
                  onChanged: (value) {
                    print('onChanged:$value');
                  },
                  onSubmitted: (value) { //提交
                    print('onSubmitted:$value');
                  },
                ),

                FlatButton(onPressed: () {
                  usernameTextEditController.clear();
                }, child: Icon(Icons.clear)),

                SizedBox(height: 10,),
                TextField(

                  controller: passwordTextEditController,
                  decoration: InputDecoration(
                    labelText: 'password',
                    hintText: '请输入密码',
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {

                  },
                  onSubmitted: (value) {
                    print('onSubmit:${value}');
                  },
                ),

                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: FlatButton(
                    child: Text('登录',style: TextStyle(fontSize: 20,color: Colors.white),),
                    color: Colors.blue,
                    onPressed: () {
                      if (usernameTextEditController.text == "" || passwordTextEditController.text == "") {
                        print('账号密码不能为空');
                        return;
                      }
                      final username = usernameTextEditController.text;
                      final password = passwordTextEditController.text;
                      print('账号：$username 密码:$password');
                      usernameTextEditController.text = "";
                      passwordTextEditController.text = "";
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
