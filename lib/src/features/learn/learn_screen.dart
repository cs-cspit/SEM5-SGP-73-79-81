import 'package:flutter/material.dart';
import 'package:sediment_learner/src/models/sediment_feature.dart';
import 'package:sediment_learner/src/repositories/sediment_repository.dart';
import '../quiz/quiz_screen.dart';
import 'category_features_screen.dart';

class LearnScreen extends StatelessWidget {
  late final List<SedimentFeature> categories;

  // Initialize categories in the constructor
  LearnScreen({super.key}) {
    categories = SedimentRepository.getAllFeatures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sediment Features'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(context, category);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuizScreen()),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.quiz, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, SedimentFeature category) {
    final subFeatureCount = category.subFeatures?.length ?? 0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToCategory(context, category),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Colored header
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: _getCategoryColor(category.title),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Content area
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Feature count
                  Row(
                    children: [
                      const Icon(Icons.list, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "$subFeatureCount ${subFeatureCount == 1 ? 'type' : 'types'}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Short description
                  Text(
                    _getCategoryDescription(category.title),
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Example feature type
                  if (subFeatureCount > 0) ...[
                    const Divider(height: 16),
                    Text(
                      "Example: ${category.subFeatures?.first.type ?? ''}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, SedimentFeature category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryFeaturesScreen(category: category),
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(context: context, delegate: _FeatureSearchDelegate());
  }

  Color _getCategoryColor(String title) {
    final colors = [
      Colors.blue.shade700,
      Colors.green.shade700,
      Colors.orange.shade700,
      Colors.purple.shade700,
      Colors.teal.shade700,
      Colors.indigo.shade700,
      Colors.brown.shade700,
    ];
    final index = title.hashCode % colors.length;
    return colors[index];
  }

  String _getCategoryDescription(String title) {
    switch (title) {
      case 'Grain Outline':
        return 'Classification based on grain edge characteristics';
      case 'Conchoidal Fractures':
        return 'Shell-like breakage patterns in mineral grains';
      case 'V-Shaped Percussion Cracks':
        return 'Triangular cracks from high-energy collisions';
      case 'Silica Globules':
        return 'Circular silica precipitates on grain surfaces';
      case 'Relief':
        return 'Surface irregularity characteristics';
      case 'Fracture Planes/Plates':
        return 'Long cracks and fractures on grain surfaces';
      default:
        return 'Various microtexture features';
    }
  }
}

class _FeatureSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, ''),
  );

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    return const Center(child: Text('Search functionality coming soon'));
  }
}
