class Validators {
  
  String validateDescriptionEmpty(String? description) {
    if (description == null || description.isEmpty) {
      return "description is not available";
    }

    return description;
  }
}
