@IsTest
private class PetstoreApiV1UserTest {
  @IsTest
  static void testSettersAndGetters() {
    PetstoreApiV1User m = new PetstoreApiV1User()
      .setId(1L)
      .setUsername('x')
      .setFirstName('x')
      .setLastName('x')
      .setEmail('x')
      .setPassword('x')
      .setPhone('x')
      .setUserStatus(1);
    Assert.areNotEqual(null, m.getId());
    Assert.areNotEqual(null, m.getUsername());
    Assert.areNotEqual(null, m.getFirstName());
    Assert.areNotEqual(null, m.getLastName());
    Assert.areNotEqual(null, m.getEmail());
    Assert.areNotEqual(null, m.getPassword());
    Assert.areNotEqual(null, m.getPhone());
    Assert.areNotEqual(null, m.getUserStatus());
  }

  @IsTest
  static void testJsonRoundTrip() {
    PetstoreApiV1User original = new PetstoreApiV1User()
      .setId(1L)
      .setUsername('x')
      .setFirstName('x')
      .setLastName('x')
      .setEmail('x')
      .setPassword('x')
      .setPhone('x')
      .setUserStatus(1);
    final String json = JSON.serialize(original);
    PetstoreApiV1User restored = (PetstoreApiV1User) JSON.deserialize(json, PetstoreApiV1User.class);
    Assert.areNotEqual(null, restored);
  }
}
