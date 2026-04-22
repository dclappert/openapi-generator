global virtual class PetstoreApiHttpClient {
  global virtual HttpResult send(final HttpRequest req) {
    final HttpResponse res = new Http().send(req);
    final HttpResult result = new HttpResult();
    result.request = req;
    result.response = res;
    return result;
  }

  global class HttpResult {
    global HttpRequest request;
    global HttpResponse response;
  }
}
