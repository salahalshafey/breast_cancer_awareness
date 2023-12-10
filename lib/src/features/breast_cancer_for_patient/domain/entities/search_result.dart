class SearchResult {
  const SearchResult({
    required this.link,
    required this.title,
    required this.snippet,
    required this.image,
  });

  final String link;
  final String title;
  final String snippet;
  final String image;

  @override
  String toString() {
    return "GoogleSearchResult(\ntitle: $title \nlink: $link \nsnippet: $snippet \nimageLink: $image\n)";
  }
}
