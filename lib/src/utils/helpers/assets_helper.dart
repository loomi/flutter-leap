const assetsUrlPrefixImages = "assets/images/";
const assetsUrlPrefixVectors = "assets/vectors/";

String getAssetImageUrl(String image) {
  return assetsUrlPrefixImages + image;
}

String getAssetVectorUrl(String vector) {
  return assetsUrlPrefixVectors + vector;
}
