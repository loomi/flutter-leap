class AssetsHelper {
  static const assetsUrlPrefixImages = "assets/images/";
  static const assetsUrlPrefixVectors = "assets/vectors/";

  String getAssetImageUrl(String image) {
    return assetsUrlPrefixImages + image;
  }

  String getAssetVectorUrl(String vector) {
    return assetsUrlPrefixVectors + vector;
  }
}
