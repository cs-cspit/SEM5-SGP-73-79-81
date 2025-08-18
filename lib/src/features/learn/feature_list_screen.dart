import 'package:flutter/material.dart';
import '../../models/sediment_feature.dart';
import '../../repositories/sediment_repository.dart';
import 'feature_detail_screen.dart';
import '../quiz/quiz_screen.dart';

class FeatureListScreen extends StatelessWidget {
  final List<SedimentFeature> features = SedimentRepository.getAllFeatures();

  FeatureListScreen({super.key});

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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: feature.imageRefs.isNotEmpty
                      ? Image.asset(
                          'assets/sediment_images/${feature.codeNumber}/${feature.imageRefs[0]}.jpg',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Text(
                              feature.codeNumber.substring(0, 2),
                              style: TextStyle(fontSize: 12),
                            );
                          },
                        )
                      : Text(
                          feature.codeNumber.substring(0, 2),
                          style: TextStyle(fontSize: 12),
                        ),
                ),
              ),
              title: Text(feature.title),
              subtitle: Text(feature.type),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _navigateToDetail(context, feature),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToQuiz(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.quiz, color: Colors.white),
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: _FeatureSearchDelegate(features),
    );
  }

  void _navigateToDetail(BuildContext context, SedimentFeature feature) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeatureDetailScreen(feature: feature),
      ),
    );
  }

  void _navigateToQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuizScreen(),
      ),
    );
  }
}

class _FeatureSearchDelegate extends SearchDelegate {
  final List<SedimentFeature> features;

  _FeatureSearchDelegate(this.features);

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    final results = features.where((f) =>
        f.title.toLowerCase().contains(query.toLowerCase()) ||
        f.type.toLowerCase().contains(query.toLowerCase()) ||
        f.codeNumber.toLowerCase().contains(query.toLowerCase()));
    return _buildResultsList(results.toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? features
        : features.where((f) =>
            f.title.toLowerCase().contains(query.toLowerCase()) ||
            f.type.toLowerCase().contains(query.toLowerCase()) ||
            f.codeNumber.toLowerCase().contains(query.toLowerCase()));
    return _buildResultsList(suggestions.toList());
  }

  Widget _buildResultsList(List<SedimentFeature> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final feature = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Text(feature.codeNumber.substring(0, 2)),
          ),
          title: Text(feature.title),
          subtitle: Text("${feature.type} • ${feature.codeNumber}"),
          onTap: () {
            close(context, feature);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeatureDetailScreen(feature: feature),
              ),
            );
          },
        );
      },
    );
  }
}