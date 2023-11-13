import 'dart:async';

import 'package:flutter/material.dart';

/// 循环滚动的widget
/// child如果有变化需要设置key，否则滚动会重置
class SingleMarquee extends StatefulWidget {
  final Widget child;
  final double gapSize;
  final Duration delay;
  final int speed;
  final bool allowRun;

  const SingleMarquee({
    Key? key,
    required this.child,
    this.delay = const Duration(milliseconds: 1000),
    this.allowRun = true,
    this.gapSize = 60,
    this.speed = 50,
  }) : super(key: key);

  @override
  State<SingleMarquee> createState() => _SingleMarqueeState();
}

class _SingleMarqueeState extends State<SingleMarquee> {
  final GlobalKey _childKey = GlobalKey();
  final GlobalKey _containerKey = GlobalKey();
  late ScrollController _scrollController;
  bool _isScroll = false;
  final maxCounter = 1000;
  int _runScrollSeed = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _isScroll = widget.allowRun;
    _prepareToMarquee();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: _containerKey,
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: _isScroll ? maxCounter : 1,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: widget.gapSize);
      },
      itemBuilder: (BuildContext context, int index) {
        return Container(
          key: index == 0 ? _childKey : null,
          child: widget.child,
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant SingleMarquee oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!mounted) return;
    if (widget.allowRun != oldWidget.allowRun ||
        oldWidget.gapSize != widget.gapSize ||
        widget.child.key == null ||
        oldWidget.child.key == null ||
        !Widget.canUpdate(widget.child, oldWidget.child)
    ) {
      debugPrint("SingleMarquee: didUpdateWidget");
      _prepareToMarquee();
    }
  }

  void _prepareToMarquee() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _onLayout();
    });
  }

  void _resetLayout() {
    _scrollController.jumpTo(0);
    debugPrint("SingleMarquee: reset");
  }

  void _onLayout() {
    _runScrollSeed ++;
    _resetLayout();
    final containerWidth = _containerKey.currentContext?.size?.width;
    final childWidth = _childKey.currentContext?.size?.width;
    debugPrint(
        "SingleMarquee onLayout containerWidth:$containerWidth, childWidth:$childWidth");
    if (childWidth == null || containerWidth == null) {
      return;
    }
    if (childWidth <= containerWidth) {
      debugPrint("SingleMarquee not need marquee");
      setState(() {
        _isScroll = false;
      });
      return;
    }
    setState(() {
      _isScroll = true;
    });
    final scrollDistance = childWidth + widget.gapSize;
    debugPrint("SingleMarquee start marquee scrollDistance: $scrollDistance");
    void runScrollNext(int runScrollSeed, int counter) async {
      if (!mounted || runScrollSeed != _runScrollSeed) {
        debugPrint("SingleMarquee: disposed or not active mounted:$mounted, "
            "runScrollSeed:$runScrollSeed, _runScrollSeed:$_runScrollSeed");
        return;
      }
      if (counter == maxCounter) {
        _resetLayout();
        counter = 1;
        debugPrint("SingleMarquee: reset");
        // 重置一下
      }
      await Future.delayed(widget.delay);
      if (!mounted || runScrollSeed != _runScrollSeed) {
        debugPrint("SingleMarquee: disposed or not active mounted:$mounted, "
            "runScrollSeed:$runScrollSeed, _runScrollSeed:$_runScrollSeed");
        return;
      }
      final scrollDuration = Duration(milliseconds: widget.speed * scrollDistance.toInt());
      final targetOffset = scrollDistance * counter;
      debugPrint("SingleMarquee: start to end $counter, offset: ${_scrollController.offset},"
          " targetOffset:$targetOffset, scrollDistance: $scrollDuration");
      final t1 = DateTime.now().millisecondsSinceEpoch;
      await _scrollController.animateTo(targetOffset,
          duration: scrollDuration, curve: Curves.linear,
      );
      debugPrint("SingleMarquee animate end $counter,"
          " time spent: ${DateTime.now().millisecondsSinceEpoch - t1}ms");
      /// 进行下次滚动
      runScrollNext(runScrollSeed, counter + 1);
    }
    runScrollNext(_runScrollSeed, 1);
  }

}
