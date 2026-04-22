@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
@JsonAccess(serializable='always' deserializable='always')
global class PetstoreApiV1Pet {
  global Long id;
  global PetstoreApiV1Category category;
  global String name;
  global List<String> photoUrls;
  global List<PetstoreApiV1Tag> tags;
  global String status;
  global Long getId() {
    return this.id;
  }

  global PetstoreApiV1Pet setId(final Long id) {
    this.id = id;
    return this;
  }

  global PetstoreApiV1Category getCategory() {
    return this.category;
  }

  global PetstoreApiV1Pet setCategory(final PetstoreApiV1Category category) {
    this.category = category;
    return this;
  }

  global String getName() {
    return this.name;
  }

  global PetstoreApiV1Pet setName(final String name) {
    this.name = name;
    return this;
  }

  global List<String> getPhotoUrls() {
    return this.photoUrls;
  }

  global PetstoreApiV1Pet setPhotoUrls(final List<String> photoUrls) {
    this.photoUrls = photoUrls;
    return this;
  }

  global List<PetstoreApiV1Tag> getTags() {
    return this.tags;
  }

  global PetstoreApiV1Pet setTags(final List<PetstoreApiV1Tag> tags) {
    this.tags = tags;
    return this;
  }

  global String getStatus() {
    return this.status;
  }

  global PetstoreApiV1Pet setStatus(final String status) {
    this.status = status;
    return this;
  }

}
