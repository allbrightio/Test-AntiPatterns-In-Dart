import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

/// A unit test that runs incredibly slow. When developers kick it off,
/// they have time to go to the bathroom, grab a smoke, or worse,
/// kick the test off before they go home at the end of the day.

/// Typically the tests are slow because they have some expensive dependency
/// (ie filesystem, database). The trick is to analyze the dependencies
/// until you see the problem, then push the dependency up the callstack.

class Article {
  final String title;
  final String content;

  const Article(this.title, this.content);
}

abstract class ArticleRepository {
  Future<List<Article>> getArticles();
}

class SimpleArticleRepository implements ArticleRepository {
  final List<Article> _articles;

  SimpleArticleRepository(this._articles);
  @override
  Future<List<Article>> getArticles() async => _articles;
}

void main() {
  test('Slow Poke Test', () async {
    // Given
    final articlesJson =
        await File('resources/my_all_articles_2mb.json').readAsString();
    final testArticles = jsonDecode(articlesJson);
    final articleRepository = SimpleArticleRepository(testArticles);

    // When
    final articles = await articleRepository.getArticles();

    // Then
    expect(articles.length, 22593);
  }, skip: true);

  test('Slow Poke Test Fix', () async {
    // Given
    final testArticles = [
      Article("Title 1", "Content 1"),
      Article("Title 2", "Content 2"),
      Article("Title 3", "Content 3"),
    ];
    final articleRepository = SimpleArticleRepository(testArticles);

    // When
    final articles = await articleRepository.getArticles();

    // Then
    expect(articles.length, 3);
  });
}
