//: Playground - noun: a place where people can play

import UIKit

class WebService/*: NSObjectProtocol, NSURLSessionDataDelegate*/ {
  let url: NSURL
  let domain: String
  let urlProtectionSpace: NSURLProtectionSpace
  var urlCredential: NSURLCredential {
    get {
      let credential = NSURLCredentialStorage.sharedCredentialStorage()
        .credentialsForProtectionSpace(urlProtectionSpace)[1]
    }
  }

  var mutableURLRequest: NSMutableURLRequest {
    get {
      let aMutableURLRequest = NSMutableURLRequest(URL: url,
        cachePolicy: .UseProtocolCachePolicy,
        timeoutInterval: 60.0)

      aMutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
      aMutableURLRequest.HTTPMethod = "GET"

      return aMutableURLRequest
    }
  }

  static let urlSession = {() -> NSURLSession in
    let config: NSURLSessionConfiguration

    config = NSURLSessionConfiguration.defaultSessionConfiguration()
    config.URLCredentialStorage = NSURLCredentialStorage.sharedCredentialStorage()
    config.timeoutIntervalForRequest = 30.0
    config.timeoutIntervalForResource = 60.0
    config.HTTPMaximumConnectionsPerHost = 5

    return NSURLSession(configuration: config)
  }

  private init(url aURL: NSURL) {
    url = aURL
    domain = "the-domain"
    urlProtectionSpace = NSURLProtectionSpace(
      host: domain,
      port: (url.port?.integerValue)!,
      `protocol`: url.scheme,
      realm: nil,
      authenticationMethod: NSURLAuthenticationMethodDefault)
  }

  // Factory method
  func webService(url: NSURL) -> WebService {
    return WebService(url: url)
  }

  func getResource(
    completionHandler: (request: NSURLRequest, response: AnyObject, anError: NSError) -> Void) {
      handleDataTask(request: mutableURLRequest, completionHandler: completionHandler)
  }

  // Helpers
  private func handleDataTask(
    request request: NSMutableURLRequest,
    completionHandler: (request: NSURLRequest, response: AnyObject, error: NSError) -> Void) {
      request.setValue("things",
        forHTTPHeaderField: "Authorization")
      UIApplication.sharedApplication().networkActivityIndicatorVisible = true
      // Do things
      UIApplication.sharedApplication().networkActivityIndicatorVisible = false
  }
}