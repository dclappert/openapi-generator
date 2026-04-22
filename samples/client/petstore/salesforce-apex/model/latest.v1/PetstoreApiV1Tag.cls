@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
@JsonAccess(serializable='always' deserializable='always')
global class PetstoreApiV1Tag {
  global Long id;
  global String name;
  global Long getId() {
    return this.id;
  }

  global PetstoreApiV1Tag setId(final Long id) {
    this.id = id;
    return this;
  }

  global String getName() {
    return this.name;
  }

  global PetstoreApiV1Tag setName(final String name) {
    this.name = name;
    return this;
  }

}
