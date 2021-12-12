//
//  LinkHeaderParser.swift
//  MHP Challenge
//
//  Created by Cihan Hasanoglu on 11.12.21.
//

import Foundation


// Parser and initializer for Linkheaders used for pagination
class LinkHeaderParser
{
    var urlDictionary: [String: URL]!
    
    var next: URL?
    var prev: URL?
    var last: URL?
    var first: URL?
    
    init?(httpURLResponse: HTTPURLResponse?) {
        guard httpURLResponse != nil else {
            return nil
        }
        let responseHeaders = httpURLResponse!.allHeaderFields
        
        guard ((responseHeaders["Link"] as? String) != nil) else
        {
            return nil
        }
        
        self.urlDictionary = parseLinkHeadersString((responseHeaders["Link"] as! String))
        
        self.next = self.urlDictionary["next"]
        self.prev = self.urlDictionary["prev"]
        self.last = self.urlDictionary["last"]
        self.first = self.urlDictionary["first"]
    }
    
    // parsing Linkheaders returns array of String as URL
    func parseLinkHeadersString(_ string: String) -> [String: URL]?
    {
        var mutableDictionary: [String: URL] = [:]
        let commaSeperatedValues = string.components(separatedBy: ",")
        
        for individualStringFor in commaSeperatedValues {
            let regexPattern = ".*<(.+)>; rel=\"(.+)\".*"
            
            do{
                let regex = try NSRegularExpression(pattern: regexPattern, options: .caseInsensitive)
                
                let result = regex.firstMatch(in: individualStringFor, options: .anchored, range: NSMakeRange(0, individualStringFor.count))
                
                if result != nil {
                    var captures : [String] = []
                    
                    var i = 1
                    while i < result!.numberOfRanges {
                        let range = result?.range(at: i)
                        let capture = (individualStringFor as NSString).substring(with: range!)
                        captures.append(capture)
                    
                        
                        i += 1
                    }
                    if captures.count != 2 {
                        continue
                    }
                    
                    let urlString = captures[0] as String
                    let url = URL(string: urlString)
                    let relationString = captures[1]
                    mutableDictionary[relationString] = url
                }
            } catch {
                print(error)
            }
        }
        return mutableDictionary
    }
}
