class ChoiceBucket {
  bool isRandom;
  bool isNotRandom;
  String Category;
  String Difficulty;
  String Tags;
  String Limit;

  ChoiceBucket(this.isNotRandom, this.isRandom, this.Category, this.Difficulty,
      this.Tags, this.Limit);

  set setIsRandom(bool isRandom) {
    this.isRandom = isRandom;
  }

  bool get getRandomQuestionStatus {
    return isRandom;
  }

  bool get getNotRandomQuestionStatus {
    return isNotRandom;
  }

  set setCategory(String category) {
    this.Category = category;
  }

  String get getCategory {
    return this.Category;
  }

  set setDifficulty(String difficulty) {
    this.Difficulty = difficulty;
  }

  String get getDifficulty {
    return this.Difficulty;
  }

  set setTags(String Tags) {
    this.Tags = Tags;
  }

  String get getTags {
    return this.Tags;
  }

  set setLimit(String limit) {
    this.Limit = limit;
  }

  String get getLimit {
    return this.Limit;
  }
}
