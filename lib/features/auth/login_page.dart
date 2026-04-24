import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../shared/widgets/logo.dart';
import '../../shared/widgets/ios_keyboard.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _remember = true;
  final _phoneController = TextEditingController();
  final _pwdController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background image
            Container(
              height: 380,
              width: double.infinity,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withValues(alpha: 0.5),
                    AppColors.background,
                  ],
                ),
              ),
              child: Image.network(
                'https://images.unsplash.com/photo-1565514020179-026b92b84bb6?q=80&w=1000&auto=format&fit=crop',
                fit: BoxFit.cover,
              ),
            ),
            // Footer SVG brand decoration
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.2,
                child: SvgPicture.asset(
                  'assets/images/footer.svg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            // Main content
            Column(
              children: [
                const SizedBox(height: 10),
                // Logo with glass effect - 2x size
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.gold,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandGold.withValues(alpha: 0.4),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                      child: Container(
                        width: 160,
                        height: 160,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.card.withValues(alpha: 0.62),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.foreground.withValues(alpha: 0.10),
                            width: 0.5,
                          ),
                        ),
                        child: const Logo(size: 128),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Welcome text
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Chào mừng ',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'trở lại',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          foreground: Paint()
                            ..shader = AppGradients.gold.createShader(
                              const Rect.fromLTWH(0, 0, 200, 40),
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'DẪN ĐẦU TƯƠNG LAI · ECOTP',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.brandGold,
                      letterSpacing: 1.2),
                ),
                const SizedBox(height: 24),
                // Login Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color:
                                    AppColors.brandGold.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(LucideIcons.shieldCheck,
                                  color: AppColors.brandGold, size: 20),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ĐĂNG NHẬP',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.mutedForeground,
                                      letterSpacing: 1),
                                ),
                                Text(
                                  'Tài khoản thành viên',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        _inputLabel('SỐ ĐIỆN THOẠI'),
                        const SizedBox(height: 8),
                        _buildPhoneField(),
                        const SizedBox(height: 24),
                        _inputLabel('MẬT KHẨU'),
                        const SizedBox(height: 8),
                        _buildPasswordField(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  setState(() => _remember = !_remember),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: _remember
                                          ? AppColors.brandRed
                                          : Colors.white10,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: _remember
                                        ? const Icon(Icons.check,
                                            size: 14, color: Colors.white)
                                        : null,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Ghi nhớ đăng nhập',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Quên mật khẩu?',
                                  style: TextStyle(
                                      color: AppColors.brandRed,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () => context.go('/home'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brandRed,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Register link - 24px below card
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => context.push('/register'),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                      children: [
                        TextSpan(text: 'Chưa có tài khoản? '),
                        TextSpan(
                            text: 'Đăng ký ngay',
                            style: TextStyle(
                                color: AppColors.brandGold,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: AppColors.mutedForeground,
          letterSpacing: 1),
    );
  }

  InputDecoration _iosInputDecoration(IconData icon, String hint,
      {bool isPassword = false}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
      prefixIcon: Icon(icon, size: 20, color: Colors.white30),
      suffixIcon: isPassword
          ? const Icon(LucideIcons.eye, size: 20, color: Colors.white30)
          : null,
      filled: true,
      fillColor: const Color(0xFF161828),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF0A84FF), width: 1),
      ),
    );
  }

  Widget _buildPhoneField() {
    return IOSKeyboardTextField(
      controller: _phoneController,
      keyboardType: IOSKeyboardType.number,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: _iosInputDecoration(LucideIcons.phone, '0901234567'),
      maxLength: 10,
    );
  }

  Widget _buildPasswordField() {
    return IOSKeyboardTextField(
      controller: _pwdController,
      keyboardType: IOSKeyboardType.text,
      obscureText: true,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration:
          _iosInputDecoration(LucideIcons.lock, '••••••', isPassword: true),
    );
  }
}
