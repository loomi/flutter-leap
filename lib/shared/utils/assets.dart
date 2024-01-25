const assetsUrlPrefixImages = "assets/images/";
const assetsUrlPrefixVectors = "assets/vectors/";

String getAssetImageUrl(String image) {
  return assetsUrlPrefixImages + image;
}

String getAssetVectorUrl(String vector) {
  return assetsUrlPrefixVectors + vector;
}

class Assets {
  static final String leapIcon = getAssetImageUrl(
    "leap_icon.png",
  );

  static final String alertIcon = getAssetVectorUrl(
    "alert.svg",
  );

  static final String searchIcon = getAssetVectorUrl(
    "search.svg",
  );
}
