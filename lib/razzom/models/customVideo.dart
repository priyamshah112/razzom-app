class CustomVideo {
  String id = "";
  String title = "";
  String url = "";
  bool isBookmarked = false;
  String bookmarkId = "";
  bool isConnected = false;
  String entrepreneurId = "";
  int fundingRequired;
  String industry = "";

  CustomVideo(
      String id,
      String title,
      String url,
      bool isBookmarked,
      String bookmarkId,
      bool isConnected,
      String entrepreneurId,
      int fundingRequired,
      String industry) {
    this.id = id;
    this.title = title;
    this.url = url;
    this.isBookmarked = isBookmarked;
    this.bookmarkId = bookmarkId;
    this.isConnected = isConnected;
    this.entrepreneurId = entrepreneurId;
    this.fundingRequired = fundingRequired;
    this.industry = industry;
  }
}
