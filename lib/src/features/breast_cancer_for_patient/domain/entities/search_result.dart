class SearchResult {
  const SearchResult({
    required this.title,
    required this.link,
    required this.snippet,
    required this.imageLink,
  });

  final String title;
  final String link;
  final String snippet;
  final String imageLink;

  @override
  String toString() {
    return "GoogleSearchResult(\ntitle: $title \nlink: $link \nsnippet: $snippet \nimageLink: $imageLink\n)";
  }
}
