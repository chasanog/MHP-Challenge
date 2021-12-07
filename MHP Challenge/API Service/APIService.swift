//
//  APIService.swift
//  MHP Challenge
//
//  Created by Cihan Hasanoglu on 06.12.21.
//

import Foundation

protocol APIObject {
    static var type: String {get}
    init? (dictionary: [String:AnyObject])
}



class APIService {
    
    func apiCall (page: Int? = nil, pageSize: Int, completionHandler: @escaping (AnyObject?, Error?) -> Void) {
            
        var pageSize = pageSize
        
        if pageSize > 50 || pageSize == 0 {
            pageSize = 50
            print("Page Size can't be greater ")
        }
        let url = NSURL(string:  "https://anapioficeandfire.com/api/houses/" + "?page=\(String(describing: page))&pageSize=\(pageSize)")!
        
        let session = URLSession.shared
        session.dataTask(with: url as URL) {data, response, error in
            guard error == nil else {
                completionHandler(nil, String(error!.localizedDescription) as? Error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let code = "\(httpResponse.statusCode)"
                let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                completionHandler(nil, String(code + " " + message) as? Error)
                return
            }
            guard data != nil else {
                completionHandler(nil, String("Data from API is empty") as? Error)
                return
            }
            
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject] {
                    // TODO change to as [String: AnyObject]
                    completionHandler(jsonDictionary as? AnyObject, nil)
                } else if let jsonArray = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[String:AnyObject]] {
                    // TODO change to as [[String: AnyObject]]
                    completionHandler(jsonArray as? AnyObject, nil)
                } else {
                    completionHandler(nil, String("The JSON returned from the API was invalid.") as? Error)
                }
            } catch {
                completionHandler(nil, String("The JSON returned from the API was invalid.") as? Error)
            }
        }.resume()
    }
    
}
