class GoogleSearchResult {
  GoogleSearchResult({
    required this.title,
    required this.link,
    required this.snippet,
  });

  String title;
  String link;
  String snippet;

  @override
  String toString() {
    return "GoogleSearchResult(\ntitle: $title \nlink: $link \nsnippet: $snippet \n)";
  }
}
