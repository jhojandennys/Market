//
//  StripeClient.swift
//  Market
//
//  Created by David Kababyan on 21/08/2019.
//  Copyright © 2019 David Kababyan. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

class StripeClient {
    
    static let sharedClient = StripeClient()
    
    var baseURLString: String? = nil
    
    var baseURL: URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString) {
            return url
        } else {
            fatalError()
        }
    }
    
    func createAndConfirmPayment(_ token: STPToken, amount: Int, completion: @escaping (_ error: Error?) -> Void) {
        
        let url = self.baseURL.appendingPathComponent("charge")
        
        let params: [String: Any] = [
            "stripeToken": token.tokenId,
            "amount": amount,
            "description": Constats.defaultDescription,
            "currency": Constats.defaultCurrency
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                switch response.result {
                case .success:
                    print("Payment successful")
                    completion(nil)
                case .failure(let error):
                    if let data = response.data, data.count > 0 {
                        print(String(data: data, encoding: .utf8) ?? "Unknown error")
                    } else {
                        print(error)
                    }
                    completion(error)
                }
            }
    }
    }
