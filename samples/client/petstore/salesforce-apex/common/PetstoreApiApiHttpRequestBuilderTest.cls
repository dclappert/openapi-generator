@IsTest
private class PetstoreApiApiHttpRequestBuilderTest {
  @IsTest
  static void testFluentSettersReturnSelf() {
    final PetstoreApiApiHttpRequestBuilder b = new PetstoreApiApiHttpRequestBuilder();
    System.assertEquals(b, b.setEndpoint('x'));
    System.assertEquals(b, b.setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET));
    System.assertEquals(b, b.setBody('body'));
    System.assertEquals(b, b.addQueryParameter('k', 'v'));
  }

  @IsTest
  static void testBuildAssemblesUrl() {
    final PetstoreApiApiHttpRequestBuilder b = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet/1')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET);
    final HttpRequest req = b.build('https://api.test', 'v1', new Map<String, String>());
    System.assertEquals('GET', req.getMethod());
    System.assertEquals('https://api.test/v1/pet/1', req.getEndpoint());
  }

  @IsTest
  static void testBuildMapsDelEnumToDeleteMethod() {
    final PetstoreApiApiHttpRequestBuilder b = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet/1')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.DEL);
    final HttpRequest req = b.build('https://api.test', 'v1', new Map<String, String>());
    System.assertEquals('DELETE', req.getMethod());
  }

  @IsTest
  static void testBuildAppendsQueryParams() {
    final PetstoreApiApiHttpRequestBuilder b = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.GET)
      .addQueryParameter('status', 'available');
    final HttpRequest req = b.build('https://api.test', 'v1', new Map<String, String>());
    System.assert(req.getEndpoint().contains('status=available'));
  }

  @IsTest
  static void testBuildSetsBodyAndHeaders() {
    final Map<String, String> headers = new Map<String, String>{'X-Auth' => 'secret'};
    final PetstoreApiApiHttpRequestBuilder b = new PetstoreApiApiHttpRequestBuilder()
      .setEndpoint('pet')
      .setMethod(PetstoreApiApiHttpRequestBuilder.HttpMethod.POST)
      .setBody('{"x":1}');
    final HttpRequest req = b.build('https://api.test', 'v1', headers);
    System.assertEquals('{"x":1}', req.getBody());
    System.assertEquals('secret', req.getHeader('X-Auth'));
  }
}
