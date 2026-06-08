global virtual class PetstoreApiApiClient {
  private final String baseUrl;
  private final String version;
  private final PetstoreApiHttpClient httpClient;
  private final List<PetstoreApiInterceptor> interceptors;

  global PetstoreApiApiClient(
    final String baseUrl, 
    final String version, 
    final PetstoreApiHttpClient httpClient
  ) {
    this.baseUrl = baseUrl;
    this.version = version;
    this.httpClient = httpClient;
    this.interceptors = new List<PetstoreApiInterceptor>();
  }

  global PetstoreApiApiClient addInterceptor(final PetstoreApiInterceptor interceptor) {
    this.interceptors.add(interceptor);
    return this;
  }

  global virtual PetstoreApiHttpResult send(final PetstoreApiHttpRequestBuilder builder) {
    for (PetstoreApiInterceptor interceptor : this.interceptors) {
      interceptor.beforeSend(builder);
    }
    final HttpRequest req = builder.build(this.baseUrl, this.version);
    return this.httpClient.send(req);
  }
}
