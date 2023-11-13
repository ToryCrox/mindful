import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mindful/widget/simple_loading.dart';

import '../r.dart';


typedef _LoadingDismissCallback = void Function();

_LoadingDismissCallback? _loadingDismissCallback;

/// 显示loading弹框
void showPopupLoading(
  BuildContext context, {
  String? message,
  Duration delay = const Duration(milliseconds: 300),
  bool dismissible = false,
}) {
  if (_loadingDismissCallback != null) {
    return;
  }
  showGeneralDialog(
    context: context,
    barrierDismissible: dismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final GlobalKey<_LazyPopupLoadingState> loadingKey = GlobalKey();
      _loadingDismissCallback = () {
        final state = loadingKey.currentState;
        final currentContext = loadingKey.currentContext;
        if (currentContext != null && state != null && state.mounted) {
          Navigator.of(currentContext).pop();
        }
      };
      return Stack(
        children: [
          _LazyPopupLoading(
            key: loadingKey,
            delay: delay,
            message: message ?? '',
            dismissible: dismissible,
          )
        ],
      );
    },
    routeSettings: const RouteSettings(name: '/popup_loading'),
  ).whenComplete(() {
    _loadingDismissCallback = null;
  });
}

/// 隐藏loading弹框
void hidePopupLoading() {
  if (_loadingDismissCallback == null) {
    return;
  }
  _loadingDismissCallback?.call();
  _loadingDismissCallback = null;
}

class _LazyPopupLoading extends StatefulWidget {
  const _LazyPopupLoading({
    Key? key,
    required this.delay,
    required this.message,
    required this.dismissible,
  }) : super(key: key);

  final String message;
  final Duration delay;
  final bool dismissible;

  @override
  State<_LazyPopupLoading> createState() => _LazyPopupLoadingState();
}

class _LazyPopupLoadingState extends State<_LazyPopupLoading>
    with SingleTickerProviderStateMixin {
  bool _isShow = false;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  void initState() {
    super.initState();

    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          _isShow = true;
          _controller.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (_isShow) {
      child = Container(
        width: 88,
        height: 88,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xB2111111),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //SpinKitWave(color: context.theme.primaryColor, size: 20,),
            const SimpleLoading(color: Colors.white, size: 20),
            if (widget.message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      child = const SizedBox();
    }
    return WillPopScope(
      onWillPop: () async {
        return widget.dismissible;
      },
      child: Positioned.fill(
        child: AbsorbPointer(
          absorbing: true,
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _controller.value,
                  child: child,
                );
              },
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
