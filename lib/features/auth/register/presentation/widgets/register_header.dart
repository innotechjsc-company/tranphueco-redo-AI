import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_gradients.dart';

class RegisterHeader extends StatelessWidget {
  final int step;
  final VoidCallback onBack;
  const RegisterHeader({super.key, required this.step, required this.onBack});

  static const _titles = {
    1: ('Bắt đầu hành trình', 'ECOTP của bạn'),
    2: ('Xác thực', 'mã OTP'),
    3: ('Tạo lớp bảo vệ', 'cá nhân'),
    4: ('Hoàn tất', 'hồ sơ thành viên'),
  };

  @override
  Widget build(BuildContext context) {
    final titles = _titles[step] ?? _titles[1]!;
    return SizedBox(
      height: 224,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child:
                Image.asset('assets/images/Trang chủ.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xB30B1B3D),
                    Color(0x990B1B3D),
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -30,
            child: Opacity(
              opacity: 0.2,
              child: Transform.rotate(
                angle: 3.14159,
                child: SvgPicture.asset(
                  'assets/images/footer.svg',
                  width: 180,
                  height: 180,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onBack,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0x1AFFFFFF),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0x33FFFFFF)),
                          ),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Bước $step/4',
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: AppColors.brandGold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titles.$1,
                          style: const TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppGradients.gold.createShader(bounds),
                          child: Text(
                            titles.$2,
                            style: const TextStyle(
                              fontFamily: 'PlayfairDisplay',
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
