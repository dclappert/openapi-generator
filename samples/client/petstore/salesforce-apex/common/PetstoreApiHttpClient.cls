public class PetstoreApiHttpClient {
  public PetstoreApiHttpResult send(final HttpRequest req) {
    final HttpResponse res = new Http().send(req);
    final PetstoreApiHttpResult result = new PetstoreApiHttpResult();
    result.request = req;
    result.response = res;
    return result;
  }
}
