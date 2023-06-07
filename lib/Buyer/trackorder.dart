import 'package:flutter/material.dart';

class SlidingUpPanelExample extends StatefulWidget {
  @override
  _SlidingUpPanelExampleState createState() => _SlidingUpPanelExampleState();
}

class _SlidingUpPanelExampleState extends State<SlidingUpPanelExample>
    with SingleTickerProviderStateMixin {
  double _panelHeightOpen = 400.0;
  double _panelHeightClosed = 75.0;
  bool _isPanelOpen = false;
  late AnimationController _animationController;
  late Animation<double> _panelAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _panelAnimation = Tween<double>(
      begin: _panelHeightClosed,
      end: _panelHeightOpen,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePanel() {
    setState(() {
      _isPanelOpen = !_isPanelOpen;
      if (_isPanelOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliding Up Panel Example'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'Main Content',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: GestureDetector(
              onTap: _togglePanel,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: _panelHeightClosed,
                color: Colors.blueGrey,
                child: Center(
                  child: Icon(
                    _isPanelOpen
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, _) {
              return Positioned(
                bottom: 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: _panelAnimation.value,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, -2.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Sliding Panel Content',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
