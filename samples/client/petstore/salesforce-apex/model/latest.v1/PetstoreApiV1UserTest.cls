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
    System.assertNotEquals(null, m.getId());
    System.assertNotEquals(null, m.getUsername());
    System.assertNotEquals(null, m.getFirstName());
    System.assertNotEquals(null, m.getLastName());
    System.assertNotEquals(null, m.getEmail());
    System.assertNotEquals(null, m.getPassword());
    System.assertNotEquals(null, m.getPhone());
    System.assertNotEquals(null, m.getUserStatus());
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
    System.assertNotEquals(null, restored);
  }
}
