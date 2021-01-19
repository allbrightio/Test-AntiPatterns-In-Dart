import 'dart:collection';

import 'package:test/test.dart';

class Gem {
  final String color;

  Gem(this.color);

  bool operator ==(other) {
    return (other is Gem && other.color == color);
  }

  @override
  int get hashCode => color.hashCode;
}

class GemBag {
  final _gems = HashSet<Gem>();

  void add(Gem gem) {
    _gems.add(gem);
  }

  Set<Gem> getGems() => _gems;
}

void main() {
  test('Sequencer Test', () {
    // Given
    final gemBag = GemBag();

    // When
    gemBag.add(Gem("Red"));
    gemBag.add(Gem("Green"));
    gemBag.add(Gem("Blue"));

    // Then
    final expected = [Gem("Red"), Gem("Green"), Gem("Blue")];
    expect(gemBag.getGems().toList(), expected);
  }, skip: true);

  test('Sequencer Test Fix', () {
    // Given
    final gemBag = GemBag();

    // When
    gemBag.add(Gem("Red"));
    gemBag.add(Gem("Green"));
    gemBag.add(Gem("Blue"));

    // Then
    final expected = [Gem("Blue"), Gem("Red"), Gem("Green")].toSet();
    expect(gemBag.getGems(), expected);
  });
}
