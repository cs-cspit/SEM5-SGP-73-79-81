import 'package:flutter/material.dart';
import '../../models/sediment_feature.dart';
import 'feature_detail_screen.dart';

class CategoryFeaturesScreen extends StatelessWidget {
  final SedimentFeature category;

  const CategoryFeaturesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final subFeatures = category.subFeatures ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showCategoryInfo(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subFeatures.length,
        itemBuilder: (context, index) {
          final feature = subFeatures[index];
          return _buildFeatureCard(context, feature);
        },
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, SedimentFeature feature) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _navigateToFeatureDetail(context, feature),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Leading icon with color
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    feature.codeNumber.substring(0, 2),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Feature details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.type.isNotEmpty
                          ? feature.type
                          : "General Feature",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feature.codeNumber,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    if (feature.morphologicalFeatures.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        feature.morphologicalFeatures,
                        style: const TextStyle(fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFeatureDetail(BuildContext context, SedimentFeature feature) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeatureDetailScreen(feature: feature),
      ),
    );
  }

  void _showCategoryInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("About ${category.title}"),
        content: Text(
          _getCategoryInfoText(category.title),
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _getCategoryInfoText(String title) {
    switch (title) {
      case 'Grain Outline':
        return 'Grain outline features describe the overall shape and angularity of sediment grains. '
            'These features help determine the transport history and weathering processes.';
      case 'Conchoidal Fractures':
        return 'Conchoidal fractures are shell-like breakage patterns that occur in brittle materials. '
            'They indicate mechanical impacts from high-energy environments.';
      case 'V-Shaped Percussion Cracks':
        return 'V-shaped percussion cracks are triangular impact features that form when grains collide with force. '
            'They are characteristic of high-energy environments.';
      case 'Silica Globules':
        return 'Silica globules are spherical precipitates that form in chemical environments. '
            'They indicate diagenetic processes or exposure to silica-saturated fluids.';
      case 'Relief':
        return 'Relief refers to the surface topography of sediment grains. '
            'It helps identify chemical alteration processes and diagenetic environments.';
      default:
        return 'This category contains various microtexture features that provide insights into sediment origin, '
            'transport history, and environmental conditions.';
    }
  }
}
