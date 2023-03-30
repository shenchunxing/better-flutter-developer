import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_text_field.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();

  // 软键盘高度
  double _keyboardHeight = 0;

  // 可控制ListView滑动
  final _scrollController = ScrollController();

  // 用于获取目标Widget的位置坐标
  final _targetWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // 添加监听，didChangeMetrics
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 当应用程序的尺寸发生变化时会调用
  @override
  void didChangeMetrics() {
    // 获取页面高度
    var pageHeight = MediaQuery.of(context).size.height;
    if (pageHeight <= 0) {
      return;
    }

    // 软键盘顶部  px
    final keyboardTopPixels =
        window.physicalSize.height - window.viewInsets.bottom;
    // 转换为 dp
    final keyboardTopPoints = keyboardTopPixels / window.devicePixelRatio;
    // 软键盘高度
    final keyboardHeight = pageHeight - keyboardTopPoints;

    setState(() {
      _keyboardHeight = keyboardHeight;
    });
    if (keyboardHeight <= 0) {
      return;
    }
    // 获取目标位置的坐标
    RenderBox? renderBox =
    _targetWidgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }
    // 转换为全局坐标
    final bottomOffset =
    renderBox.localToGlobal(Offset(0, renderBox.size.height));
    final targetDy = bottomOffset.dy;
    // 获取要滚动的距离
    // 即被软键盘挡住的那段距离 加上 _scrollController.offset 已经滑动过的距离
    final offsetY =
        keyboardHeight - (pageHeight - targetDy) + _scrollController.offset;
    // 滑动到指定位置
    if (offsetY > 0) {
      _scrollController.animateTo(
        offsetY,
        duration: kTabScrollDuration,
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(), //失去焦点
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  SafeArea(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton(
                        onPressed: () {},
                        child: const Icon(CupertinoIcons.clear, size: 24),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Text(
                      '你好，\n欢迎使用Flutter App',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: UserTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      placeholder: '请输入邮箱',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: UserTextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      usedInPassword: true,
                      placeholder: '请输入密码',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: UserTextField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      placeholder: '请输入6位验证码',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CupertinoButton(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      height: 44,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                      child: const Text(
                        '登录',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {},
                  ),
                  Row(
                    key: _targetWidgetKey,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        minSize: 24,
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                        onPressed: () {},
                        child: const Text(
                          '忘记密码？',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      CupertinoButton(
                        minSize: 24,
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                        onPressed: () {},
                        child:
                        const Text('立即注册', style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                  SizedBox(height: _keyboardHeight) //空出键盘上面的空间高度
                ],
              ),
            ),
            Row(
              children: const [
                SizedBox(width: 16),
                Expanded(child: Divider()),
                SizedBox(width: 8),
                Text(
                  '其它登录方式',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(width: 8),
                Expanded(child: Divider()),
                SizedBox(width: 16),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(Icons.facebook, size: 44),
                ),
                const SizedBox(width: 32),
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(Icons.apple, size: 44),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}


