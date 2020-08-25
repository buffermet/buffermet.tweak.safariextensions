Some of these classes contain no methods that require interception, I'm just spitballing.

- [ ] Intercept finalized requests and responses:
  - [ ] NSURLSession
  - [ ] NSURLSessionConfiguration
  - [ ] NSURLSessionTask
    - [ ] NSURLSessionDataTask
    - [ ] NSURLSessionUploadTask
    - [ ] NSURLSessionDownloadTask
  - [ ] ...
  - [ ] NSURLConnection
  - [ ] NSURLConnectionDelegate
  - [ ] NSURLConnectionDataDelegate
  - [ ] ...
- [ ] Implement caching compatibility.
- [ ] Implement missing JavaScriptCore objects:
  - [ ] XMLHttpRequest
  - [ ] XMLHttpRequestEventTarget
  - [ ] XMLHttpRequestUpload
  - [ ] console (logging options for extension consoles)

