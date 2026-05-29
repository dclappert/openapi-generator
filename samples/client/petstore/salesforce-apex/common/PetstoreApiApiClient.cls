global virtual class PetstoreApiApiClient {
  private final String baseUrl;
  private final String version;
  private final Map<String, String> headers = new Map<String, String>();
  private final PetstoreApiHttpClient httpClient;
  private final PetstoreApiAuthProvider authProvider;

  global PetstoreApiApiClient(
    final String baseUrl, 
    final String version, 
    final PetstoreApiHttpClient httpClient,
    final PetstoreApiAuthProvider authProvider
  ) {
    this.baseUrl = baseUrl;
    this.version = version;
    this.httpClient = httpClient;
    this.authProvider = authProvider;
  }

  global PetstoreApiApiClient addHeader(final String name, final String value) {
    this.headers.put(name, value);
    return this;
  }

  global PetstoreApiHttpResult send(final PetstoreApiHttpRequestBuilder builder) {
    final Map<String, String> authHeaders = this.authProvider.getAuthHeaders(builder.getRequestContext());
    for (String headerName : authHeaders.keySet()) {
      builder.addHeader(headerName, authHeaders.get(headerName));
    }
    final HttpRequest req = builder.build(this.baseUrl, this.version, this.headers);
    return this.httpClient.send(req);
  }
}
