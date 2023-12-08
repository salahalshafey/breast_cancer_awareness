class SearchResult {
  const SearchResult({
    required this.title,
    required this.link,
    required this.snippet,
  });

  final String title;
  final String link;
  final String snippet;

  @override
  String toString() {
    return "GoogleSearchResult(\ntitle: $title \nlink: $link \nsnippet: $snippet \n)";
  }
}
