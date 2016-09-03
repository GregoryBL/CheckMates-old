//
//  DwollaAPIManager.swift
//  checkMates
//
//  Created by Gregory Berns-Leone on 9/3/16.
//  Copyright © 2016 checkMates. All rights reserved.

//  Adapted from https://grokswift.com/alamofire-OAuth2/
//

import Foundation
import Alamofire

class DwollaAPIManager {
    static let sharedInstance = DwollaAPIManager()
    
    let clientID = valueForAPIKey(named: "DWOLLA_APP_ID")
    let clientSecret = valueForAPIKey(named: "DWOLLA_SECRET_KEY")
    let scope = "Contacts%7CSend%7CRequest"
    let redirectURI = "com.checkMates.checkMates%3A%2F%2F"
    
    // handlers for the OAuth process
    // stored as vars since sometimes it requires a round trip to safari which
    // makes it hard to just keep a reference to it
    var OAuthTokenCompletionHandler : (NSError? -> Void)?
    
    func hasOAuthToken() -> Bool {
        // TODO: implement
        return false
    }
    
    // MARK: - OAuth flow
    
    func startOAuth2Login() {
        
        let authPath = "https://uat.dwolla.com/oauth/v2/authenticate?client_id=\(clientID)&response_type=code&redirect_uri=\(redirectURI)&scope=\(scope)"
        if let authURL = NSURL(string: authPath) {
            print("sending")
            UIApplication.sharedApplication().openURL(authURL)
        }
        
        // TODO: implement
        // TODO: call completion handler after getting token or error
    }
    
    func processOAuthStep1Response(url: NSURL) {
        print(url)
        
        let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        var code : String?
        if let queryItems = components?.queryItems {
            for queryItem in queryItems {
                if queryItem.name.lowercaseString == "code" {
                    code = queryItem.value
                    break
                }
            }
        }
        let getTokenPath = "https://uat.dwolla.com/oauth/v2/token"
        let tokenParams : [String: String]? = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "code": code!,
            "grant_type": "authorization_code",
            "redirect_uri": redirectURI
        ]
        print(tokenParams)
        Alamofire.request(.POST, getTokenPath, parameters: tokenParams!, encoding: .JSON)
            .validate()
            .response { request, response, data, error in
                // TODO: handle response to extract OAuth token
                if let anError = error {
                    print(anError)
                    if let completionHandler = self.OAuthTokenCompletionHandler {
                        let noOAuthError = NSError(domain: "com.alamofire.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not obtain an OAuth token", NSLocalizedRecoverySuggestionErrorKey: "Please retry your request"])
                        completionHandler(noOAuthError)
                    }
                    return
                }
                print(String(request?.HTTPBody))
                print(response)
            }
            .responseJSON { request in
                print("request")
                print(request)
        }
    }
}