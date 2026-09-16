@IsTest
public class PetstoreApiHttpClientMock extends PetstoreApiHttpClient {
  public HttpResponse nextResponse;

  public override PetstoreApiHttpResult send(final HttpRequest req) {
    final PetstoreApiHttpResult r = new PetstoreApiHttpResult();
    r.request = req;
    r.response = this.nextResponse;
    return r;
  }
}
