# Flutter性能优化之RepaintBoundary
![image.jpeg](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/df568935b6ba457e9890a8084a3dbf5e~tplv-k3u1fbpfcp-watermark.image?)
页面最外层是个SingleChildScrollView，上方的环形图是一个自定义CustomPainter，下方是个ListView列表。

实现这个环形图并不复杂。继承CustomPainter，重写paint与shouldRepaint方法即可。paint方法负责绘制具体的图形，shouldRepaint方法负责告诉Flutter刷新布局时是否重绘。一般的策略是在shouldRepaint方法中，我们通过对比前后数据是否相同来判定是否需要重绘。

当我滑动页面时，发现自定义环形图中的paint方法不断在执行。？？？shouldRepaint方法失效了？其实注释文档写的很清楚了，只怪自己没有仔细阅读

```
  /// If the method returns false, then the [paint] call might be optimized
  /// away.
  ///
  /// It's possible that the [paint] method will get called even if
  /// [shouldRepaint] returns false (e.g. if an ancestor or descendant needed to
  /// be repainted). It's also possible that the [paint] method will get called
  /// without [shouldRepaint] being called at all (e.g. if the box changes
  /// size).
  ///
  /// If a custom delegate has a particularly expensive paint function such that
  /// repaints should be avoided as much as possible, a [RepaintBoundary] or
  /// [RenderRepaintBoundary] (or other render object with
  /// [RenderObject.isRepaintBoundary] set to true) might be helpful.
  ///
  /// The `oldDelegate` argument will never be null.
  bool shouldRepaint(covariant CustomPainter oldDelegate);
```
注释中提到两点：

即使shouldRepaint返回false，也有可能调用paint方法(例如：如果组件的大小改变了)。

如果你的自定义View比较复杂，应该尽可能的避免重绘。使用RepaintBoundary或者RenderObject.isRepaintBoundary为true可能会有对你有所帮助。

显然我碰到的问题就是第一点。翻看SingleChildScrollView源码我们发现了问题

```
  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final Offset paintOffset = _paintOffset;

      void paintContents(PaintingContext context, Offset offset) {
        context.paintChild(child, offset + paintOffset); 滚动过程中必定会重绘子视图
      }

      if (_shouldClipAtPaintOffset(paintOffset)) {
        context.pushClipRect(needsCompositing, offset, Offset.zero & size, paintContents);
      } else {
        paintContents(context, offset);
      }
    }
  }
```

最终执行到`paintChild`方法
```
  void paintChild(RenderObject child, Offset offset) {
  isRepaintBoundary为true时，我们可以直接合成视图，避免重绘
    if (child.isRepaintBoundary) {
      stopRecordingIfNeeded();
      _compositeChild(child, offset);
    } 
    只要`child.isRepaintBoundary`为false，那么就会执行`paint`方法，这里就直接跳过了`shouldRepaint`。
    else { 
      child._paintWithContext(this, offset);
    }
  }

  void _paintWithContext(PaintingContext context, Offset offset) {
      ...
    _needsPaint = false;
    try {
      paint(context, offset); //<-----
    } catch (e, stack) {
      _debugReportException('paint', e, stack);
    }
   
  }
```

Flutter为我们提供了[RepaintBoundary](https://api.flutter.dev/flutter/widgets/RepaintBoundary-class.html)，它是对这一操作的封装，便于我们的使用
```
class RepaintBoundary extends SingleChildRenderObjectWidget {
  const RepaintBoundary({ Key key, Widget child }) : super(key: key, child: child);

  @override
  RenderRepaintBoundary createRenderObject(BuildContext context) => RenderRepaintBoundary();
}


class RenderRepaintBoundary extends RenderProxyBox {
  RenderRepaintBoundary({ RenderBox child }) : super(child);

  这里返回的是true，避免重绘
  @override
  bool get isRepaintBoundary => true; 
}
```
解决问题的方法很简单：在`CustomPaint`外层套一个`RepaintBoundary`。详细的源码[点击这里](https://github.com/simplezhli/flutter_deer/blob/master/lib/widgets/pie_chart/pie_chart.dart)。

那么RepaintBoundary到底是什么？RepaintBoundary就是重绘边界，用于重绘时独立于父布局的。

在Flutter SDK中有部分Widget做了这个处理，比如TextField、SingleChildScrollView、AndroidView、UiKitView等。最常用的ListView在item上默认也使用了RepaintBoundary

接着上面的源码中`child.isRepaintBoundary`为true的地方，我们看到会调用`_compositeChild`方法；

```
  void _compositeChild(RenderObject child, Offset offset) {
    ...
    // Create a layer for our child, and paint the child into it.
    if (child._needsPaint) {
      repaintCompositedChild(child, debugAlsoPaintedParent: true); // <---- 1
    } 

    final OffsetLayer childOffsetLayer = child._layer;
    childOffsetLayer.offset = offset;
    appendLayer(child._layer);
  }

  static void repaintCompositedChild(RenderObject child, { bool debugAlsoPaintedParent = false }) {
    _repaintCompositedChild( // <---- 2
      child,
      debugAlsoPaintedParent: debugAlsoPaintedParent,
    );
  }

  static void _repaintCompositedChild(
    RenderObject child, {
    bool debugAlsoPaintedParent = false,
    PaintingContext childContext,
  }) {
    ...
    OffsetLayer childLayer = child._layer;
    if (childLayer == null) {
      child._layer = childLayer = OffsetLayer(); // <---- 3
    } else {
      childLayer.removeAllChildren();
    }
   
    childContext ??= PaintingContext(child._layer, child.paintBounds);
    /// 创建完成，进行绘制
    child._paintWithContext(childContext, Offset.zero);
    childContext.stopRecordingIfNeeded();
  }
```
child._needsPaint为true时会最终通过_repaintCompositedChild方法在当前child创建一个图层（layer）。

这里说到的图层还是很抽象的，如何直观的观察到它呢？我们可以在程序的main方法中将debugRepaintRainbowEnabled变量置为true。它可以帮助我们可视化应用程序中渲染树的重绘。原理其实就是在执行上面的stopRecordingIfNeeded方法时，额外绘制了一个彩色矩形：

```  
@protected
  @mustCallSuper
  void stopRecordingIfNeeded() {
    if (!_isRecording)
      return;
    assert(() {
      if (debugRepaintRainbowEnabled) { // <-----
        final Paint paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6.0
          ..color = debugCurrentRepaintColor.toColor();
        canvas.drawRect(estimatedBounds.deflate(3.0), paint);
      }
      return true;
    }());
  }
```
效果如下：

![image.jpeg](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/787e3c67b1f94ddb984d6ae0d5fdb0f2~tplv-k3u1fbpfcp-watermark.image?)

不同的颜色代表不同的图层。当发生重绘时，对应的矩形框也会发生颜色变化。

在重绘前，需要`markNeedsPaint`方法标记重绘的节点。

```
  void markNeedsPaint() {
    if (_needsPaint)
      return;
    _needsPaint = true;
    if (isRepaintBoundary) {
      // If we always have our own layer, then we can just repaint
      // ourselves without involving any other nodes.
      assert(_layer is OffsetLayer);
      if (owner != null) {
        owner._nodesNeedingPaint.add(this);
        owner.requestVisualUpdate(); // 更新绘制
      }
    } else if (parent is RenderObject) {
      final RenderObject parent = this.parent;
      parent.markNeedsPaint();
      assert(parent == this.parent);
    } else {
      if (owner != null)
        owner.requestVisualUpdate();
    }
  }
```
markNeedsPaint方法中如果isRepaintBoundary为false，就会调用父节点的markNeedsPaint方法，直到isRepaintBoundary为 true时，才将当前RenderObject添加至_nodesNeedingPaint中。

在绘制每帧时，调用flushPaint方法更新视图。

```
  void flushPaint() {
    try {
      final List<RenderObject> dirtyNodes = _nodesNeedingPaint; <-- 获取需要绘制的脏节点
      _nodesNeedingPaint = <RenderObject>[];
      // Sort the dirty nodes in reverse order (deepest first). 
      for (RenderObject node in dirtyNodes..sort((RenderObject a, RenderObject b) => b.depth - a.depth)) {
        assert(node._layer != null);
        if (node._needsPaint && node.owner == this) {
          if (node._layer.attached) {
            PaintingContext.repaintCompositedChild(node); <--- 这里重绘，深度优先
          } else {
            node._skippedPaintingOnLayer();
          }
        }
      }
      
    } finally {
      if (!kReleaseMode) {
        Timeline.finishSync();
      }
    }
  }
```
这样就实现了局部的重绘，将子节点与父节点的重绘分隔开。

tips：这里需要注意一点，通常我们点击按钮的水波纹效果会导致距离它上级最近的图层发生重绘。我们需要根据页面的具体情况去做处理。这一点在官方的项目flutter_gallery中就有做类似处理。

总结

其实总结起来就是一句话，根据场景合理使用RepaintBoundary，它可以帮你带来性能的提升。 其实优化方向不止RepaintBoundary，还有还RelayoutBoundary。

