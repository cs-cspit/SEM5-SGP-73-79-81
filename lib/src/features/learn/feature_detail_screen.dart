import 'package:flutter/material.dart';
import '../../models/sediment_feature.dart';

class FeatureDetailScreen extends StatelessWidget {
  final SedimentFeature feature;

  const FeatureDetailScreen({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(feature.displayName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Gallery
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: feature.imageRefs.length,
                itemBuilder: (context, index) {
                  final imageRef = feature.imageRefs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/sediment_images/$imageRef.png',
                      width: 300,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.image_not_supported),
                    ),
                  );
                },
              ),
            ),
            
            // Feature details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Code Number', feature.codeNumber),
                  _buildDetailRow('Agents Involved', feature.agentsInvolved),
                  _buildDetailRow('Morphological Features', feature.morphologicalFeatures),
                  _buildDetailRow('Origin', feature.origin),
                  _buildDetailRow('Factors Acting', feature.factorsActing),
                  _buildDetailRow('Alteration', feature.alteration),
                  if (feature.size.isNotEmpty) _buildDetailRow('Size', feature.size),
                  if (feature.coverage.isNotEmpty) _buildDetailRow('Coverage', feature.coverage),
                  _buildDetailRow('Environment', feature.environment),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}