import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// iOS-style dark mode keyboard for the Trần Phú ECOTP app.
/// Supports both text (QWERTY) and numeric layouts.
enum IOSKeyboardType { text, number }

class IOSKeyboard extends StatefulWidget {
  final TextEditingController controller;
  final IOSKeyboardType keyboardType;
  final VoidCallback? onDone;
  final VoidCallback? onNext;
  final String doneLabel;

  const IOSKeyboard({
    super.key,
    required this.controller,
    this.keyboardType = IOSKeyboardType.text,
    this.onDone,
    this.onNext,
    this.doneLabel = 'Xong',
  });

  @override
  State<IOSKeyboard> createState() => _IOSKeyboardState();
}

class _IOSKeyboardState extends State<IOSKeyboard> {
  bool _isShift = false;
  bool _isSymbol = false;

  // iOS dark mode colors
  static const _bgColor = Color(0xFF1C1C1E);
  static const _keyColor = Color(0xFF3A3A3C);
  static const _keyHighlight = Color(0xFF636366);
  static const _specialKeyColor = Color(0xFF2C2C2E);
  static const _textColor = Color(0xFFFFFFFF);
  static const _subTextColor = Color(0xFF8E8E93);
  static const _toolbarColor = Color(0xFF2C2C2E);
  static const _toolbarBorder = Color(0xFF3A3A3C);
  static const _blueAccent = Color(0xFF0A84FF);

  static const _row1 = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'];
  static const _row2 = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'];
  static const _row3 = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];

  static const _symbolRow1 = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  static const _symbolRow2 = ['-', '/', ':', ';', '(', ')', '\$', '&', '@', '"'];
  static const _symbolRow3 = ['.', ',', '?', '!', "'"];

  @override
  Widget build(BuildContext context) {
    return widget.keyboardType == IOSKeyboardType.number
        ? _buildNumberKeyboard()
        : _buildTextKeyboard();
  }

  Widget _buildTextKeyboard() {
    final row1 = _isSymbol ? _symbolRow1 : _row1;
    final row2 = _isSymbol ? _symbolRow2 : _row2;
    final row3 = _isSymbol ? _symbolRow3 : _row3;

    return Container(
      decoration: const BoxDecoration(
        color: _bgColor,
        border: Border(top: BorderSide(color: _toolbarBorder, width: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Toolbar
          _buildToolbar(),
          const SizedBox(height: 4),
          // Row 1
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              children: row1.map((k) => _charKey(k)).toList(),
            ),
          ),
          const SizedBox(height: 8),
          // Row 2
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _isSymbol ? 3 : 18),
            child: Row(
              children: row2.map((k) => _charKey(k)).toList(),
            ),
          ),
          const SizedBox(height: 8),
          // Row 3 with shift + backspace
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              children: [
                if (!_isSymbol) _shiftKey(),
                if (_isSymbol) _symbolToggleKey(),
                const SizedBox(width: 4),
                ...row3.map((k) => _charKey(k)),
                const SizedBox(width: 4),
                _backspaceKey(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Bottom row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              children: [
                _symbolSwitchKey(),
                const SizedBox(width: 4),
                _emojiKey(),
                const SizedBox(width: 4),
                _spaceKey(),
                const SizedBox(width: 4),
                _doneKey(),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Home indicator
          _homeIndicator(),
        ],
      ),
    );
  }

  Widget _buildNumberKeyboard() {
    return Container(
      decoration: const BoxDecoration(
        color: _bgColor,
        border: Border(top: BorderSide(color: _toolbarBorder, width: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToolbar(),
          const SizedBox(height: 6),
          // Number rows
          _numberRow(['1', '2', '3']),
          const SizedBox(height: 8),
          _numberRow(['4', '5', '6']),
          const SizedBox(height: 8),
          _numberRow(['7', '8', '9']),
          const SizedBox(height: 8),
          // Bottom row: empty, 0, backspace
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(child: _numberSpecialKey('')),
                const SizedBox(width: 8),
                Expanded(child: _numberKey('0')),
                const SizedBox(width: 8),
                Expanded(child: _numberBackspaceKey()),
              ],
            ),
          ),
          const SizedBox(height: 6),
          _homeIndicator(),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: _toolbarColor,
        border: Border(bottom: BorderSide(color: _toolbarBorder, width: 0.5)),
      ),
      child: Row(
        children: [
          const Spacer(),
          GestureDetector(
            onTap: widget.onDone ?? widget.onNext,
            child: Text(
              widget.onNext != null ? 'Tiếp' : widget.doneLabel,
              style: const TextStyle(
                color: _blueAccent,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _charKey(String char) {
    final display = _isShift && !_isSymbol ? char.toUpperCase() : char;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            _insertText(display);
            if (_isShift) setState(() => _isShift = false);
          },
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: _keyColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 1),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                display,
                style: const TextStyle(
                  color: _textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shiftKey() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _isShift = !_isShift);
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _isShift ? _textColor : _specialKeyColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.arrow_upward_rounded,
            color: _isShift ? Colors.black : _textColor,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _backspaceKey() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _deleteText();
      },
      onLongPress: () {
        // Long press to clear all text
        widget.controller.clear();
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _specialKeyColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.backspace_outlined,
            color: _textColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _symbolSwitchKey() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          _isSymbol = !_isSymbol;
          _isShift = false;
        });
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _specialKeyColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            _isSymbol ? 'ABC' : '123',
            style: const TextStyle(
              color: _textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _symbolToggleKey() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _isSymbol = !_isSymbol);
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _specialKeyColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            '#+=',
            style: TextStyle(
              color: _textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _emojiKey() {
    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _specialKeyColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.emoji_emotions_outlined,
            color: _textColor,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _spaceKey() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          _insertText(' ');
        },
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: _keyColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                offset: Offset(0, 1),
                blurRadius: 0,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'khoảng trắng',
              style: TextStyle(
                color: _textColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _doneKey() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (widget.onNext != null) {
          widget.onNext!();
        } else if (widget.onDone != null) {
          widget.onDone!();
        }
      },
      child: Container(
        width: 86,
        height: 42,
        decoration: BoxDecoration(
          color: _blueAccent,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.onNext != null ? 'tiếp' : 'đi',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // =============== NUMBER KEYBOARD KEYS ===============

  Widget _numberRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: keys.map((k) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _numberKey(k),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _numberKey(String digit) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _insertText(digit);
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: _keyColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            digit,
            style: const TextStyle(
              color: _textColor,
              fontSize: 26,
              fontWeight: FontWeight.w400,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _numberSpecialKey(String label) {
    return GestureDetector(
      onTap: label.isEmpty ? null : () {
        HapticFeedback.lightImpact();
        _insertText(label);
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: label.isEmpty ? Colors.transparent : _specialKeyColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: _textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _numberBackspaceKey() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _deleteText();
      },
      onLongPress: () => widget.controller.clear(),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: _specialKeyColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.backspace_outlined,
            color: _textColor,
            size: 22,
          ),
        ),
      ),
    );
  }

  // =============== HOME INDICATOR ===============

  Widget _homeIndicator() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Center(
        child: Container(
          width: 134,
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }

  // =============== TEXT MANIPULATION ===============

  void _insertText(String text) {
    final cursorPos = widget.controller.selection.baseOffset;
    final currentText = widget.controller.text;

    if (cursorPos < 0) {
      // No cursor position, append to end
      widget.controller.text = currentText + text;
      widget.controller.selection = TextSelection.collapsed(
        offset: widget.controller.text.length,
      );
    } else {
      final newText = currentText.substring(0, cursorPos) +
          text +
          currentText.substring(cursorPos);
      widget.controller.text = newText;
      widget.controller.selection = TextSelection.collapsed(
        offset: cursorPos + text.length,
      );
    }
  }

  void _deleteText() {
    final cursorPos = widget.controller.selection.baseOffset;
    final currentText = widget.controller.text;

    if (currentText.isEmpty) return;

    if (cursorPos <= 0) {
      // Cursor at start or no selection, delete from end
      widget.controller.text = currentText.substring(0, currentText.length - 1);
      widget.controller.selection = TextSelection.collapsed(
        offset: widget.controller.text.length,
      );
    } else {
      final newText = currentText.substring(0, cursorPos - 1) +
          currentText.substring(cursorPos);
      widget.controller.text = newText;
      widget.controller.selection = TextSelection.collapsed(
        offset: cursorPos - 1,
      );
    }
  }
}

// ===============================================================
// IOSKeyboardTextField - Wrapper cho TextField dùng bàn phím iOS
// ===============================================================

/// TextField wrapper that shows a custom iOS keyboard instead of the system keyboard.
/// Use this in place of TextField throughout the app.
class IOSKeyboardTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final IOSKeyboardType keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onDone;
  final VoidCallback? onNext;
  final int? maxLength;

  const IOSKeyboardTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.style,
    this.hintStyle,
    this.decoration,
    this.keyboardType = IOSKeyboardType.text,
    this.onChanged,
    this.onDone,
    this.onNext,
    this.maxLength,
  });

  @override
  State<IOSKeyboardTextField> createState() => _IOSKeyboardTextFieldState();
}

class _IOSKeyboardTextFieldState extends State<IOSKeyboardTextField> {
  late TextEditingController _controller;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _ownsController = true;
    }
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.maxLength != null && _controller.text.length > widget.maxLength!) {
      _controller.text = _controller.text.substring(0, widget.maxLength!);
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }
    widget.onChanged?.call(_controller.text);
  }

  void _showKeyboard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      builder: (_) => IOSKeyboard(
        controller: _controller,
        keyboardType: widget.keyboardType,
        onDone: () {
          Navigator.pop(context);
          widget.onDone?.call();
        },
        onNext: widget.onNext != null
            ? () {
                Navigator.pop(context);
                widget.onNext!();
              }
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = widget.decoration ??
        InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
        );

    return TextField(
      controller: _controller,
      readOnly: true,
      showCursor: true,
      obscureText: widget.obscureText,
      style: widget.style,
      decoration: defaultDecoration,
      onTap: _showKeyboard,
    );
  }
}
