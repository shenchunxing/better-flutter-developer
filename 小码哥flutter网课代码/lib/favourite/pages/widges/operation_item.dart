
import 'package:flutter/cupertino.dart';

class HYOperationItem extends StatelessWidget {
  final Widget _icon;
  final String _title;

  HYOperationItem(this._icon,this._title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _icon,
        SizedBox(width: 3,),
        Text(_title),
      ],
    );
  }
}
