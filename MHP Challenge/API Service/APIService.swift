//
//  APIService.swift
//  MHP Challenge
//
//  Created by Cihan Hasanoglu on 06.12.21.
//

import Foundation


protocol APIObject {
    init? (dictionary: NSDictionary?)
    var url: NSURL? {get set}
    var name: String? {get set}
    var isDetailed: Bool {get}
}

// makes the call to the api and downloads data as JSON
class APIService {
    
    /*
     downloads data conforms to APIObject protocol
     parses the url string
     calls the api via apiCall function
     completionhandler notifies when download is done or when something happens badly
     */
    func downloadData<T: APIObject>(_ page: Int?, _ pageSize: Int?, completionHandler: @escaping(_ IAFHouse: [T]?, Error?, _ linkHeaders: LinkHeaderParser?) -> Void)
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
        
        apiCall(url) {(dictionaryArray: NSArray?, error: Error?, linkHeaders: LinkHeaderParser?) -> Void in
            
            guard error == nil && dictionaryArray != nil else{
                completionHandler(nil, error, nil)
                return
            }
            var objectArray : [T] = []
            for dictionary in dictionaryArray!
            {
                let parsedObject = T(dictionary: dictionary as? NSDictionary)
                objectArray.append(parsedObject!)
            }
            completionHandler(objectArray, nil, linkHeaders)
        }
    }

    /*
     function which is actually making the request to the api
     defining required Headers and httpMethod
     returns a json object containing the data
     completionhandler notifies when it is done or when something happens badly
     */
    func apiCall<T>(_ url: URL!, completionHandler: @escaping (T?, Error?, LinkHeaderParser?) -> Void) {
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
                completionHandler(nil, error, nil)
                return
            }
            
            //** Make sure we have a HTTPURLResponse
            guard urlResponse is HTTPURLResponse else
            {
                print("HTTP ERROR")
                completionHandler(nil, error, nil)
                return
            }
            
            let httpURLResponse : HTTPURLResponse  = urlResponse as! HTTPURLResponse
                        
            //** Make sure we got a 200
            guard httpURLResponse.statusCode == 200 else
            {
                print("HTTP Response code is not 200")
                completionHandler(nil, error, nil)
                return
            }
            
            guard data != nil else
            {
                print("data is nil")
                completionHandler(nil, error, nil)
                return
            }
            let linkHeaders = LinkHeaderParser(httpURLResponse: httpURLResponse)
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                guard jsonDictionary is T else {
                    print("jsonDictionary not type of \(T.self)")
                    return
                }
                completionHandler(jsonDictionary as? T, nil, linkHeaders)
            }
            catch {
                completionHandler(nil, String("Returned JSON from API was not valid") as? Error, nil)
            }
        }
        task.resume()
    }
    
}
