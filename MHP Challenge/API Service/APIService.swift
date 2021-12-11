//
//  APIService.swift
//  MHP Challenge
//
//  Created by Cihan Hasanoglu on 06.12.21.
//

import Foundation

protocol APIObject {
    static var type: String {get}
    init? (dictionary: NSDictionary?)
    init? (url: NSURL?)
    var url: NSURL? {get set}
    var name: String? {get set}
    var isDetailed: Bool {get}
}



class APIService {
    
    func downloadData<T: APIObject>(_ page: Int?, _ pageSize: Int?, completionHandler: @escaping(_ IAFHouse: [T]?, Error?) -> Void)
    {
        var urlString = "https://anapioficeandfire.com/api/houses"
        if page != nil || pageSize != nil {
            urlString += "?"
            
            if page != nil && pageSize != nil {
                urlString += "page=\(page!)&pageSize=\(pageSize!)"
            }
            else if page != nil {
                urlString += "page=\(page ?? 1)"
            }
            else if pageSize != nil {
                urlString += "pageSize=\(pageSize ?? 50)"
            }
        }
        
        
        let url = URL(string: urlString)
        
        apiCall(url) {(dictionaryArray: NSArray?, error: Error?) -> Void in
            
            guard error == nil && dictionaryArray != nil else{
                completionHandler(nil, error)
                return
            }
            var objectArray : [T] = []
            for dictionary in dictionaryArray!
            {
                let parsedObject = T(dictionary: dictionary as? NSDictionary)
                objectArray.append(parsedObject!)
            }
            completionHandler(objectArray, nil)
        }
    }

    func apiCall<T>(_ url: URL!, completionHandler: @escaping (T?, Error?) -> Void) {
        let req = NSMutableURLRequest(url: url)
        req.httpMethod = "GET"
        req.addValue("application/vnd.anapioficeandfire+json; version=1", forHTTPHeaderField: "Accept")
        req.setValue("CHasanog", forHTTPHeaderField: "If-None-Match")
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        
                    
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            //** Gaurd against error
            guard error == nil else
            {
                print("error not empty")
                completionHandler(nil, error)
                return
            }
            
            //** Make sure we have a HTTPURLResponse
            guard urlResponse is HTTPURLResponse else
            {
                print("HTTP ERROR")
                completionHandler(nil, error)
                return
            }
            
            let httpURLResponse : HTTPURLResponse  = urlResponse as! HTTPURLResponse
                        
            //** Make sure we got a 200
            guard httpURLResponse.statusCode == 200 else
            {
                print("200")
                completionHandler(nil, error)
                return
            }
            
            guard data != nil else
            {
                print("error")
                completionHandler(nil, error)
                return
            }
            
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                guard jsonDictionary is T else {
                    print("Not T")
                    return
                }
                completionHandler(jsonDictionary as? T, nil)
            }
            catch {
                completionHandler(nil, String("Returned JSON from API was not valid") as? Error)
            }
        }
        task.resume()
    }
    
    /*
    
    func apiCall<T: APIObject> (page: Int? = nil, pageSize: Int, completionHandler: @escaping (_ IAFHouse: T?, Error?) -> Void) {
            
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
                    completionHandler(jsonDictionary as? AnyObject as! T, nil)
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
     */
    
}
