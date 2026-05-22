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
    Assert.areNotEqual(null, m.getId());
    Assert.areNotEqual(null, m.getCategory());
    Assert.areNotEqual(null, m.getName());
    Assert.areNotEqual(null, m.getPhotoUrls());
    Assert.areNotEqual(null, m.getTags());
    Assert.areNotEqual(null, m.getStatus());
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
    Assert.areNotEqual(null, restored);
  }
}
