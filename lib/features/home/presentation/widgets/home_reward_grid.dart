import 'package:flutter/material.dart';
import '../../../../shared/widgets/reward_card.dart';
import '../../../../data/mock/mock_data.dart';

class HomeRewardGrid extends StatelessWidget {
  final List<Reward> rewards;
  const HomeRewardGrid({super.key, required this.rewards});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: rewards.length,
        itemBuilder: (_, i) => RewardCard(reward: rewards[i]),
      ),
    );
  }
}
