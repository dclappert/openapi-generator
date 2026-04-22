@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
@JsonAccess(serializable='always' deserializable='always')
global class PetstoreApiV1ApiResponse {
  global Integer code;
  global String type;
  global String message;
  global Integer getCode() {
    return this.code;
  }

  global PetstoreApiV1ApiResponse setCode(final Integer code) {
    this.code = code;
    return this;
  }

  global String getType() {
    return this.type;
  }

  global PetstoreApiV1ApiResponse setType(final String _type) {
    this.type = _type;
    return this;
  }

  global String getMessage() {
    return this.message;
  }

  global PetstoreApiV1ApiResponse setMessage(final String message) {
    this.message = message;
    return this;
  }

}
