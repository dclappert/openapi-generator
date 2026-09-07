global virtual class PetstoreApiApiClient {
  private final String baseUrl;
  private final String version;
  private final PetstoreApiHttpClient httpClient;
  private final List<> interceptors;

  global PetstoreApiApiClient(
    final String baseUrl, 
    final String version, 
    final PetstoreApiHttpClient httpClient
  ) {
    this.baseUrl = baseUrl;
    this.version = version;
    this.httpClient = httpClient;
    this.interceptors = new List<>();
  }

  global PetstoreApiApiClient addInterceptor(final  interceptor) {
    this.interceptors.add(interceptor);
    return this;
  }

  global virtual  send(final  builder) {
    for ( interceptor : this.interceptors) {
      interceptor.beforeSend(builder);
    }
    final HttpRequest req = builder.build(this.baseUrl, this.version);
    return this.httpClient.send(req);
  }
}
