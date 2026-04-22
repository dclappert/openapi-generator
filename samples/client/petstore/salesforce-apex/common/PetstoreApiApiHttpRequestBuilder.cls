public class PetstoreApiApiHttpRequestBuilder {
  // DELETE is a reserved keyword in Apex — use DEL and map to 'DELETE' in build()
  public enum HttpMethod { GET, POST, PUT, PATCH, DEL }

  private String endpoint;
  private String body;
  private HttpMethod method;
  private Map<String, String> queryParams = new Map<String, String>();

  public PetstoreApiApiHttpRequestBuilder setEndpoint(final String endpoint) {
    this.endpoint = endpoint;
    return this;
  }

  public PetstoreApiApiHttpRequestBuilder setMethod(final HttpMethod method) {
    this.method = method;
    return this;
  }

  public PetstoreApiApiHttpRequestBuilder setBody(final String body) {
    this.body = body;
    return this;
  }

  public PetstoreApiApiHttpRequestBuilder addQueryParameter(final String key, final String value) {
    this.queryParams.put(key, value);
    return this;
  }

  // Called by the ApiClient — not intended for direct use
  public HttpRequest build(
    final String baseUrl,
    final String version,
    final Map<String, String> headers
  ) {
    String url = baseUrl + '/' + version + '/' + this.endpoint;
    if (!this.queryParams.isEmpty()) {
      final List<String> parts = new List<String>();
      for (String key : this.queryParams.keySet()) {
        parts.add(key + '=' + EncodingUtil.urlEncode(this.queryParams.get(key), 'UTF-8'));
      }
      url += '?' + String.join(parts, '&');
    }
    final HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setMethod(this.method == HttpMethod.HTTP_DELETE ? 'DELETE' : this.method.name());
    req.setHeader('Content-Type', 'application/json');
    req.setHeader('Accept', 'application/json');
    for (String headerName : headers.keySet()) {
      req.setHeader(headerName, headers.get(headerName));
    }
    if (this.body != null) {
      req.setBody(this.body);
    }
    return req;
  }
}
