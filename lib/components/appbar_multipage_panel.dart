import 'package:flutter/widgets.dart';
import 'package:frledger/globals/styles.dart';

class AppbarMultipagePanel extends StatefulWidget {
  const AppbarMultipagePanel(
      {Key? key,
      required this.mainButtonIcon,
      required this.pageIcons,
      required this.pageController,
      this.onMainButtonTap})
      : super(key: key);

  final IconData mainButtonIcon;
  final VoidCallback? onMainButtonTap;
  final List<IconData> pageIcons;
  final double innerButtonSize = appbarHeight - appbarButtonPadding * 2;
  final PageController pageController;

  @override
  State<StatefulWidget> createState() {
    return _AppbarMultipagePanelState();
  }
}

class _AppbarMultipagePanelState extends State<AppbarMultipagePanel> {
  double shadowPosition = 2 * (appbarHeight - appbarButtonPadding * 2);
  bool isMainButtonHover = false;

  @override
  Widget build(BuildContext context) {
    widget.pageController.addListener((() {
      setState(() {
        shadowPosition = (widget.pageController.page ?? 2) *
            (appbarHeight - appbarButtonPadding * 2);
      });
    }));

    return Container(
        decoration:
            const BoxDecoration(color: white, boxShadow: [slightElevated]),
        height: appbarHeight,
        width: widget.innerButtonSize * (widget.pageIcons.length + 1) +
            2 * appbarButtonPadding,
        child: Padding(
            padding: const EdgeInsets.all(appbarButtonPadding),
            child: Row(
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: shadowPosition,
                      child: Container(
                        width: widget.innerButtonSize,
                        height: widget.innerButtonSize,
                        color: grayBackground,
                      ),
                      // duration: const Duration(milliseconds: 200)
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < widget.pageIcons.length; i++)
                          GestureDetector(
                              onTap: () {
                                widget.pageController.animateToPage(i,
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.easeInOut);
                              },
                              child: Container(
                                  color: transparent,
                                  width: widget.innerButtonSize,
                                  height: widget.innerButtonSize,
                                  child: Icon(widget.pageIcons[i],
                                      color: accent, size: standardIconSize))),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                    onTapDown: (details) {
                      setState(() {
                        isMainButtonHover = true;
                      });
                    },
                    onTapUp: (details) {
                      setState(() {
                        isMainButtonHover = false;
                        widget.onMainButtonTap?.call();
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        isMainButtonHover = false;
                      });
                    },
                    child: Container(
                        color: isMainButtonHover ? accentFocus : accentLighter,
                        width: widget.innerButtonSize,
                        height: widget.innerButtonSize,
                        child: Icon(widget.mainButtonIcon,
                            color: accent, size: standardIconSize))),
              ],
            )));
  }
}
