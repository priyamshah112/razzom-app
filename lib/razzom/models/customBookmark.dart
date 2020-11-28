class CustomBookmark {
  String id = "";
  String videoId = "";
  String videoTitle = "";
  String videoUrl = "";
  bool isConnected = false;
  String entrepreneurId = "";
  int fundingRequired;
  String industry = "";

  CustomBookmark(
      String id,
      String videoId,
      String videoTitle,
      String videoUrl,
      bool isConnected,
      String entrepreneurId,
      int fundingRequired,
      String industry) {
    this.id = id;
    this.videoId = videoId;
    this.videoTitle = videoTitle;
    this.videoUrl = videoUrl;
    this.isConnected = isConnected;
    this.entrepreneurId = entrepreneurId;
    this.fundingRequired = fundingRequired;
    this.industry = industry;
  }
}
