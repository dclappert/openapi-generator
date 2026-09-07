@IsTest
private class Test {
  @IsTest
  static void testFluentSettersReturnSelf() {
    final  b = new ();
    Assert.areEqual(b, b.setEndpoint('x'));
    Assert.areEqual(b, b.setMethod(.HttpMethod.GET));
    Assert.areEqual(b, b.setBody('body'));
    Assert.areEqual(b, b.addQueryParameter('k', 'v'));
  }

  @IsTest
  static void testBuildAssemblesUrl() {
    final  b = new ()
      .setEndpoint('pet/1')
      .setMethod(.HttpMethod.GET);
    final HttpRequest req = b.build('https://api.test', 'v1', new Map<String, String>());
    Assert.areEqual('GET', req.getMethod());
    Assert.areEqual('https://api.test/v1/pet/1', req.getEndpoint());
  }

  @IsTest
  static void testBuildMapsDelEnumToDeleteMethod() {
    final  b = new ()
      .setEndpoint('pet/1')
      .setMethod(.HttpMethod.DEL);
    final HttpRequest req = b.build('https://api.test', 'v1', new Map<String, String>());
    Assert.areEqual('DELETE', req.getMethod());
  }

  @IsTest
  static void testBuildAppendsQueryParams() {
    final  b = new ()
      .setEndpoint('pet')
      .setMethod(.HttpMethod.GET)
      .addQueryParameter('status', 'available');
    final HttpRequest req = b.build('https://api.test', 'v1', new Map<String, String>());
    Assert.isTrue(req.getEndpoint().contains('status=available'));
  }

  @IsTest
  static void testBuildSetsBodyAndHeaders() {
    final Map<String, String> headers = new Map<String, String>{'X-Auth' => 'secret'};
    final  b = new ()
      .setEndpoint('pet')
      .setMethod(.HttpMethod.POST)
      .setBody('{"x":1}');
    final HttpRequest req = b.build('https://api.test', 'v1', headers);
    Assert.areEqual('{"x":1}', req.getBody());
    Assert.areEqual('secret', req.getHeader('X-Auth'));
  }
}
