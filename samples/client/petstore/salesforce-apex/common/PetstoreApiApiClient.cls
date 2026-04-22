global virtual class PetstoreApiApiClient {
  private final String baseUrl;
  private final String version;
  private final Map<String, String> headers = new Map<String, String>();
  private final PetstoreApiHttpClient httpClient;

  global PetstoreApiApiClient(final String baseUrl, final String version) {
    this(baseUrl, version, new PetstoreApiHttpClient());
  }

  global PetstoreApiApiClient(final String baseUrl, final String version, final PetstoreApiHttpClient httpClient) {
    this.baseUrl = baseUrl;
    this.version = version;
    this.httpClient = httpClient;
  }

  global PetstoreApiApiClient addHeader(final String name, final String value) {
    this.headers.put(name, value);
    return this;
  }

  global virtual PetstoreApiHttpClient.HttpResult send(final PetstoreApiApiHttpRequestBuilder builder) {
    final HttpRequest req = builder.build(this.baseUrl, this.version, this.headers);
    return this.httpClient.send(req);
  }
}
