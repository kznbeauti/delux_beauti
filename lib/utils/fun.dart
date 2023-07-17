String getCategoryFromList(List<String> categories) {
  var category = "";
  for (var element in categories) {
    category += element + ",";
  }
  return category;
}
