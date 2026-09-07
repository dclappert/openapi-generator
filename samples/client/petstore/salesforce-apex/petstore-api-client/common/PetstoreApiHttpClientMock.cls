@IsTest
public class PetstoreApiHttpClientMock extends PetstoreApiHttpClient {
  public HttpResponse nextResponse;

  public override  send(final HttpRequest req) {
    final  r = new ();
    r.request = req;
    r.response = this.nextResponse;
    return r;
  }
}
