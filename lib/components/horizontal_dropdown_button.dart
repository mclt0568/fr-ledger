import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/controls/dropdown_control.dart';
import 'package:frledger/globals/styles.dart';

class HorizontalDropdown extends StatefulWidget {
  const HorizontalDropdown(
      {Key? key, required this.icon, required this.text, required this.control})
      : super(key: key);

  final IconData icon;
  final String text;
  final DropdownCotrol control;
  final int animationMilliseconds = 150;

  @override
  State<HorizontalDropdown> createState() => _HorizontalDropdownState();
}

class _HorizontalDropdownState extends State<HorizontalDropdown>
    with SingleTickerProviderStateMixin {
  late GlobalKey widgetKey;
  late OverlayEntry dropdownOverlay;
  late AnimationController overlayFadeController;
  late Tween overlayFadeAnimation = Tween(begin: 0.0, end: 1.0);
  bool showingDropdownList = false;
  double renderX = 0;
  double renderY = 0;
  double renderHeight = 0;
  double renderWidth = 0;

  @override
  void initState() {
    widgetKey = LabeledGlobalKey(widget.control.getTruKeyString());
    dropdownOverlay = createDropdownMenuOverlay();
    overlayFadeController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationMilliseconds));
    overlayFadeAnimation.animate(overlayFadeController);
    super.initState();
  }

  void updateDropdownData() {
    RenderBox renderBox =
        widgetKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    renderHeight = renderBox.size.height;
    renderWidth = renderBox.size.width;
    renderX = offset.dx;
    renderY = offset.dy;
  }

  void openDropdown() {
    setState(() {
      showingDropdownList = true;
      updateDropdownData();
    });
    Overlay.of(context)?.insert(dropdownOverlay);
    overlayFadeController.forward();
  }

  void closeDropdown() {
    overlayFadeController.reverse();
    Future.delayed(Duration(milliseconds: widget.animationMilliseconds), () {
      setState(() {
        showingDropdownList = false;
        dropdownOverlay.remove();
      });
    });
  }

  OverlayEntry createDropdownMenuOverlay() {
    return OverlayEntry(
        builder: (context) => Stack(children: [
              BackdropFilter(
                filter: overlayBlurFilter,
                child: FadeTransition(
                  opacity: overlayFadeController,
                  child: GestureDetector(
                      onTap: () => closeDropdown(),
                      child: Container(color: overlayTransparent)),
                ),
              ),
              Positioned(
                top: renderY,
                left: renderX,
                child: widget.control.dropdownListBuilder(
                    renderX, renderY, renderWidth, renderHeight),
              ),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !showingDropdownList,
      child: GestureDetector(
        onTap: () {
          openDropdown();
        },
        child: Container(
          key: widgetKey,
          height: settingsButtonHeight,
          decoration:
              const BoxDecoration(color: white, boxShadow: [slightElevated]),
          child: Row(
            children: [
              SizedBox(
                height: settingsButtonHeight,
                width: settingsButtonHeight,
                child: Icon(widget.icon,
                    size: standardIconSize, color: paragraphColorLight),
              ),
              Expanded(
                  child: DefaultText(
                      text: widget.text, color: paragraphColorLight)),
              const SizedBox(
                height: settingsButtonHeight,
                width: settingsButtonHeight,
                child: Icon(CarbonIcons.chevron_down,
                    size: standardIconSize, color: paragraphColorLight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
