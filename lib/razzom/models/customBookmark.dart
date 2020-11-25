class CustomBookmark {
  String id = "";
  String videoId = "";
  String videoTitle = "";
  String videoUrl = "";
  bool isConnected = false;
  String entrepreneurId = "";

  CustomBookmark(String id, String videoId, String videoTitle, String videoUrl,
      bool isConnected, String entrepreneurId) {
    this.id = id;
    this.videoId = videoId;
    this.videoTitle = videoTitle;
    this.videoUrl = videoUrl;
    this.isConnected = isConnected;
    this.entrepreneurId = entrepreneurId;
  }
}
