@IsTest
private class PetstoreApiHttpRequestBuilderTest {
  @IsTest
  static void itGetsAndSetsBuilderMembers() {
    final PetstoreApiHttpRequestBuilder clazz = new PetstoreApiHttpRequestBuilder('testOperation');

    Test.startTest();
    Assert.areEqual(clazz, clazz.setEndpoint('x'));
    Assert.areEqual(clazz, clazz.setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.GET));
    Assert.areEqual(clazz, clazz.setBody('body'));
    Assert.areEqual(clazz, clazz.addQueryParameter('k', 'v'));
    Assert.areEqual(clazz, clazz.addHeader('k', 'v'));

    Assert.areEqual('testOperation', clazz.getOperationId());
    Assert.areEqual('x', clazz.getEndpoint());
    Assert.areEqual(PetstoreApiHttpRequestBuilder.HttpMethod.GET, clazz.getMethod());
    Assert.areEqual('body', clazz.getBody());
    Assert.areEqual(new Map<String, String>{'k' => 'v'}, clazz.getQueryParams());
    Assert.areEqual(new Map<String, String>{'k' => 'v'}, clazz.getHeaderParams());
    Test.stopTest();
  }

  @IsTest
  static void itCreatesHttpRequestWithCorrectUrl() {
    Test.startTest();
    final PetstoreApiHttpRequestBuilder b = new PetstoreApiHttpRequestBuilder('testOperation')
      .setEndpoint('pet/1')
      .setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.GET);
    final HttpRequest req = b.build('https://api.test', 'v1');
    Test.stopTest();

    Assert.areEqual('GET', req.getMethod());
    Assert.areEqual('https://api.test/v1/pet/1', req.getEndpoint());
  }

  @IsTest
  static void itMapsDelEnumToDeleteMethod() {
    Test.startTest();
    final PetstoreApiHttpRequestBuilder b = new PetstoreApiHttpRequestBuilder('testOperation')
      .setEndpoint('pet/1')
      .setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.DEL);
    final HttpRequest req = b.build('https://api.test', 'v1');
    Test.stopTest();

    Assert.areEqual('DELETE', req.getMethod());
  }

  @IsTest
  static void itAppendsQueryParamsToUrl() {
    Test.startTest();
    final PetstoreApiHttpRequestBuilder b = new PetstoreApiHttpRequestBuilder('testOperation')
      .setEndpoint('pet')
      .setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.GET)
      .addQueryParameter('status', 'available')
      .addQueryParameter('type', 'dog');
    Test.stopTest();

    final HttpRequest req = b.build('https://api.test', 'v1');
    Assert.areEqual('https://api.test/v1/pet?status=available&type=dog', req.getEndpoint());
  }

  @IsTest
  static void itSetsBodyAndHeadersInHttpRequest() {
    Test.startTest();
    final Map<String, String> headers = new Map<String, String>{'X-Auth' => 'secret'};
    final PetstoreApiHttpRequestBuilder b = new PetstoreApiHttpRequestBuilder('testOperation')
      .setEndpoint('pet')
      .setMethod(PetstoreApiHttpRequestBuilder.HttpMethod.POST)
      .setBody('{"x":1}')
      .addHeader('X-Auth', 'secret');
    final HttpRequest req = b.build('https://api.test', 'v1');
    Test.stopTest();

    Assert.areEqual('{"x":1}', req.getBody());
    Assert.areEqual('secret', req.getHeader('X-Auth'));
  }
}
