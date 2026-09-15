@IsTest
private class PetstoreApiHttpRequestBuilderTest {
  @IsTest
  static void testFluentSettersReturnSelf() {
    final PetstoreApiHttpRequestBuilder b = new PetstoreApiHttpRequestBuilder();
    Assert.areEqual(b, b.setEndpoint('x'));
    Assert.areEqual(b, b.setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.GET));
    Assert.areEqual(b, b.setBody('body'));
    Assert.areEqual(b, b.addQueryParameter('k', 'v'));
  }

  @IsTest
  static void testBuildAssemblesUrl() {
    final PetstoreApiHttpRequestBuilder b = new PetstoreApiHttpRequestBuilder()
      .setEndpoint('pet/1')
      .setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.GET);
    final HttpRequest req = b.build('https://api.test', 'v1', new Map<String, String>());
    Assert.areEqual('GET', req.getMethod());
    Assert.areEqual('https://api.test/v1/pet/1', req.getEndpoint());
  }

  @IsTest
  static void testBuildMapsDelEnumToDeleteMethod() {
    final PetstoreApiHttpRequestBuilder b = new PetstoreApiHttpRequestBuilder()
      .setEndpoint('pet/1')
      .setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.DEL);
    final HttpRequest req = b.build('https://api.test', 'v1', new Map<String, String>());
    Assert.areEqual('DELETE', req.getMethod());
  }

  @IsTest
  static void testBuildAppendsQueryParams() {
    final PetstoreApiHttpRequestBuilder b = new PetstoreApiHttpRequestBuilder()
      .setEndpoint('pet')
      .setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.GET)
      .addQueryParameter('status', 'available');
    final HttpRequest req = b.build('https://api.test', 'v1', new Map<String, String>());
    Assert.isTrue(req.getEndpoint().contains('status=available'));
  }

  @IsTest
  static void testBuildSetsBodyAndHeaders() {
    final Map<String, String> headers = new Map<String, String>{'X-Auth' => 'secret'};
    final PetstoreApiHttpRequestBuilder b = new PetstoreApiHttpRequestBuilder()
      .setEndpoint('pet')
      .setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.POST)
      .setBody('{"x":1}');
    final HttpRequest req = b.build('https://api.test', 'v1', headers);
    Assert.areEqual('{"x":1}', req.getBody());
    Assert.areEqual('secret', req.getHeader('X-Auth'));
  }
}
