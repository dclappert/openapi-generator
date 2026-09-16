global class PetstoreApiHttpRequestBuilder {
  // DELETE is a reserved keyword in Apex — use DEL and map to 'DELETE' in build()
  global enum HttpMethod { GET, POST, PUT, PATCH, DEL }

  private final String operationId;
  private final Map<String, String> headerParams;
  private final Map<String, String> queryParams;

  private String body;
  private String endpoint;
  private HttpMethod method;

  global PetstoreApiHttpRequestBuilder(final String operationId) {
    this.operationId = operationId;
    this.headerParams = new Map<String, String>();
    this.queryParams = new Map<String, String>();
  }

  global String getOperationId() {
    return this.operationId;
  }

  global Map<String, String> getHeaderParams() {
    return new Map<String, String>(this.headerParams);
  }

  global Map<String, String> getQueryParams() {
    return new Map<String, String>(this.queryParams);
  }

  global String getBody() {
    return this.body;
  }

  global String getEndpoint() {
    return this.endpoint;
  }

  global HttpMethod getMethod() {
    return this.method;
  }

  global PetstoreApiHttpRequestBuilder setEndpoint(final String endpoint) {
    this.endpoint = endpoint;
    return this;
  }

  global PetstoreApiHttpRequestBuilder setMethod(final HttpMethod method) {
    this.method = method;
    return this;
  }

  global PetstoreApiHttpRequestBuilder setBody(final String body) {
    this.body = body;
    return this;
  }

  global PetstoreApiHttpRequestBuilder addQueryParameter(final String key, final String value) {
    this.queryParams.put(key, value);
    return this;
  }

  global PetstoreApiHttpRequestBuilder addHeader(final String key, final String value) {
    this.headerParams.put(key, value);
    return this;
  }

  // Intended for internal use by the generated API client, not for direct use by consumers
  public HttpRequest build(final String baseUrl, final String version) {
    final String normalizedEndpoint = this.endpoint.startsWith('/') ? this.endpoint.substring(1) : this.endpoint;
    final String url = baseUrl + '/' + version + '/' + normalizedEndpoint;

    final List<String> parts = new List<String>();
    if (!this.queryParams.isEmpty()) {
      for (String key : this.queryParams.keySet()) {
        parts.add(key + '=' + EncodingUtil.urlEncode(this.queryParams.get(key), 'UTF-8'));
      }
    }

    final String fullUrl = parts.isEmpty()
      ? url
      : url + '?' + String.join(parts, '&');

    final HttpRequest req = new HttpRequest();
    req.setEndpoint(fullUrl);
    req.setMethod(this.method == HttpMethod.DEL ? 'DELETE' : this.method.name());
    req.setHeader('Content-Type', 'application/json');
    req.setHeader('Accept', 'application/json');
    for (String headerName : this.headerParams.keySet()) {
      req.setHeader(headerName, this.headerParams.get(headerName));
    }

    if (this.body != null) {
      req.setBody(this.body);
    }
    return req;
  }
}
