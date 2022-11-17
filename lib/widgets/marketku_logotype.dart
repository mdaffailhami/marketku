import 'package:flutter/material.dart';

enum MarketKuLogotypeVariant { light, dark }

class MyMarketKuLogotype extends StatelessWidget {
  const MyMarketKuLogotype({
    Key? key,
    required this.variant,
    required this.fontSize,
  }) : super(key: key);

  factory MyMarketKuLogotype.light({required double fontSize}) {
    return MyMarketKuLogotype(
      variant: MarketKuLogotypeVariant.light,
      fontSize: fontSize,
    );
  }

  factory MyMarketKuLogotype.dark({required double fontSize}) {
    return MyMarketKuLogotype(
      variant: MarketKuLogotypeVariant.dark,
      fontSize: fontSize,
    );
  }

  final MarketKuLogotypeVariant variant;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
        children: [
          TextSpan(
            text: 'Market',
            style: TextStyle(
              color: variant == MarketKuLogotypeVariant.dark
                  ? const Color(0xFF000000)
                  : const Color(0xFFFFFFFF),
            ),
          ),
          TextSpan(
            text: 'Ku',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
