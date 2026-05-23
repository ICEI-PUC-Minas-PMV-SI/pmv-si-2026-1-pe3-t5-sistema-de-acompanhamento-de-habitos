import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/design_system/tokens/sah_colors.dart';
import '../../../core/design_system/tokens/sah_radius.dart';
import '../../../core/design_system/tokens/sah_spacing.dart';
import '../../../core/design_system/widgets/sah_button.dart';
import '../../../l10n/app_localizations.dart';

class _Slide {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const _Slide({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });
}

List<_Slide> _slidesFor(AppL10n l) => [
      _Slide(
        icon: PhosphorIconsRegular.sparkle,
        color: const Color(0xFF6B5B95),
        title: l.onboardingWelcomeTitle,
        description: l.onboardingWelcomeDescription,
      ),
      _Slide(
        icon: PhosphorIconsRegular.bell,
        color: const Color(0xFFC89B3C),
        title: l.onboardingRemindersTitle,
        description: l.onboardingRemindersDescription,
      ),
      _Slide(
        icon: PhosphorIconsRegular.chartLine,
        color: const Color(0xFF4A7C59),
        title: l.onboardingProgressTitle,
        description: l.onboardingProgressDescription,
      ),
    ];

class OnboardingIntro extends StatefulWidget {
  /// Chamado no botão principal do último slide ("Vamos começar"):
  /// avança pra próxima fase do onboarding.
  final VoidCallback onContinue;

  /// Chamado no "Pular" do canto superior: encerra todo o onboarding.
  final VoidCallback onSkip;

  const OnboardingIntro({
    super.key,
    required this.onContinue,
    required this.onSkip,
  });

  @override
  State<OnboardingIntro> createState() => _OnboardingIntroState();
}

class _OnboardingIntroState extends State<OnboardingIntro> {
  final _ctrl = PageController();
  int _page = 0;
  int _slideCount = 0;

  bool get _isLast => _page == _slideCount - 1;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_isLast) {
      widget.onContinue();
    } else {
      _ctrl.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context)!;
    final slides = _slidesFor(l);
    _slideCount = slides.length;
    return SafeArea(
      child: Column(
        children: [
          // "Pular" no canto superior direito
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
              child: TextButton(
                onPressed: widget.onSkip,
                child: Text(
                  l.commonSkip,
                  style: GoogleFonts.interTight(
                    fontSize: 13,
                    color: SahColors.textMuted,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _ctrl,
              onPageChanged: (p) => setState(() => _page = p),
              itemCount: slides.length,
              itemBuilder: (_, i) => _SlideView(slide: slides[i]),
            ),
          ),
          // Indicador de dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(slides.length, (i) {
              final selected = i == _page;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: selected ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: selected ? SahColors.accent : SahColors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              SahSpacing.pagePadding,
              SahSpacing.x6,
              SahSpacing.pagePadding,
              SahSpacing.x6,
            ),
            child: SahButton.primary(
              label: _isLast ? l.commonContinue : l.commonNext,
              fullWidth: true,
              onPressed: _next,
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideView extends StatelessWidget {
  final _Slide slide;

  const _SlideView({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SahSpacing.pagePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: slide.color.withAlpha(25),
              borderRadius: BorderRadius.circular(SahRadius.xl),
            ),
            child: Center(
              child: Icon(slide.icon, size: 64, color: slide.color),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'GeneralSans',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: SahColors.text,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.interTight(
              fontSize: 15,
              color: SahColors.textMuted,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
