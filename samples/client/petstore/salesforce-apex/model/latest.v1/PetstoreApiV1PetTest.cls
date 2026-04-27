@IsTest
private class PetstoreApiV1PetTest {
  @IsTest
  static void testSettersAndGetters() {
    PetstoreApiV1Pet m = new PetstoreApiV1Pet()
      .setId(1L)
      .setCategory(new PetstoreApiV1Category())
      .setName('x')
      .setPhotoUrls(new List<String>())
      .setTags(new List<PetstoreApiV1Tag>())
      .setStatus('x');
    System.assertNotEquals(null, m.getId());
    System.assertNotEquals(null, m.getCategory());
    System.assertNotEquals(null, m.getName());
    System.assertNotEquals(null, m.getPhotoUrls());
    System.assertNotEquals(null, m.getTags());
    System.assertNotEquals(null, m.getStatus());
  }

  @IsTest
  static void testJsonRoundTrip() {
    PetstoreApiV1Pet original = new PetstoreApiV1Pet()
      .setId(1L)
      .setCategory(new PetstoreApiV1Category())
      .setName('x')
      .setPhotoUrls(new List<String>())
      .setTags(new List<PetstoreApiV1Tag>())
      .setStatus('x');
    final String json = JSON.serialize(original);
    PetstoreApiV1Pet restored = (PetstoreApiV1Pet) JSON.deserialize(json, PetstoreApiV1Pet.class);
    System.assertNotEquals(null, restored);
  }
}
