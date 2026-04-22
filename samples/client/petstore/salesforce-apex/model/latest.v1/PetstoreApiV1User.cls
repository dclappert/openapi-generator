@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
@JsonAccess(serializable='always' deserializable='always')
global class PetstoreApiV1User {
  global Long id;
  global String username;
  global String firstName;
  global String lastName;
  global String email;
  global String password;
  global String phone;
  global Integer userStatus;
  global Long getId() {
    return this.id;
  }

  global PetstoreApiV1User setId(final Long id) {
    this.id = id;
    return this;
  }

  global String getUsername() {
    return this.username;
  }

  global PetstoreApiV1User setUsername(final String username) {
    this.username = username;
    return this;
  }

  global String getFirstName() {
    return this.firstName;
  }

  global PetstoreApiV1User setFirstName(final String firstName) {
    this.firstName = firstName;
    return this;
  }

  global String getLastName() {
    return this.lastName;
  }

  global PetstoreApiV1User setLastName(final String lastName) {
    this.lastName = lastName;
    return this;
  }

  global String getEmail() {
    return this.email;
  }

  global PetstoreApiV1User setEmail(final String email) {
    this.email = email;
    return this;
  }

  global String getPassword() {
    return this.password;
  }

  global PetstoreApiV1User setPassword(final String password) {
    this.password = password;
    return this;
  }

  global String getPhone() {
    return this.phone;
  }

  global PetstoreApiV1User setPhone(final String phone) {
    this.phone = phone;
    return this;
  }

  global Integer getUserStatus() {
    return this.userStatus;
  }

  global PetstoreApiV1User setUserStatus(final Integer userStatus) {
    this.userStatus = userStatus;
    return this;
  }

}
