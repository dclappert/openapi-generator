@IsTest
public class PetstoreApiHttpClientMock extends PetstoreApiHttpClient {
  public HttpResponse nextResponse;

  public override PetstoreApiHttpClient.HttpResult send(final HttpRequest req) {
    final PetstoreApiHttpClient.HttpResult r = new PetstoreApiHttpClient.HttpResult();
    r.request = req;
    r.response = this.nextResponse;
    return r;
  }
}
