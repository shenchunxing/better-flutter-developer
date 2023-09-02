import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Sliders extends StatefulWidget {
  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  double _sliderValue = 0;
  RangeValues _rangeValues = RangeValues(25, 75);
  double _sliderValue2 = 0;
  @override
  Widget build(BuildContext context) {
    return slidersDemo4();
  }

  //基础
  Widget slidersDemo1() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('值：$_sliderValue'),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 5,
            //离散值
            label: '$_sliderValue',
            activeColor: Colors.red,
            inactiveColor: Colors.blue,
            onChanged: (v) {
              setState(() {
                _sliderValue = v;
              });
            },
          ),
          ],
      ),
    );
  }

  //自定义
  Widget slidersDemo2() {
    return Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Text('值：$_sliderValue'),
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(0xff404080),
            thumbColor: Colors.blue,
            overlayColor: Colors.green,
            valueIndicatorColor: Colors.purpleAccent),
        child: Slider(
          value: _sliderValue,
          min: 0,
          max: 100,
          divisions: 5,
          //离散值
          label: '$_sliderValue',
          activeColor: Colors.red,
          inactiveColor: Colors.blue,
          onChanged: (v) {
            setState(() {
              _sliderValue = v;
            });
          },
        ),
      )],
    ),
    );
  }

  //以前flutter版本的样式
  Widget slidersDemo3() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      ),
      child: Slider(
        value: _sliderValue,
        label: '$_sliderValue',
        min: 0,
        max: 100,
        divisions: 4,
        onChanged: (v) {
          setState(() {
            _sliderValue = v;
          });
        },
      ),
    );
  }

  //范围滑块
  Widget slidersDemo4() {
    return RangeSlider(
      values: _rangeValues,
      labels: RangeLabels('${_rangeValues.start}','${_rangeValues.end}'),
      min: 0,
      max: 100,
      divisions: 4,
      onChanged: (v) {
        setState(() {
          _rangeValues = v;
        });
      },
    );
  }

  //自动适配不同平台的风格
  Widget slidersDemo5() {
    return Slider.adaptive(
      value: _sliderValue2,
      onChanged: (v) {
        setState(() {
          _sliderValue2 = v;
        });
      },
    );
  }
}
