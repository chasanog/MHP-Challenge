//
//  APIObjectParser.swift
//  MHP Challenge
//
//  Created by Cihan Hasanoglu on 06.12.21.
//

import Foundation

/*
 @APIObjectParser is used for parsing data coming from API
 */
class APIObjectParser {
    
    
    class func dictionaryValid(dictionary: [String: AnyObject]) -> Bool{
        if dictionary.count == 0 || dictionary["url"] == nil {
            return false
            
        } else {
            return true
        }
        
    }

    class func stringFromDictionary(dictionary: [String: AnyObject], key: String) -> String? {
        if let string = dictionary[key] as? String, string != "" {
            return string
        }
        return nil
    }

    class func urlFromDictionary(dictionary: [String: AnyObject], key: String) -> NSURL? {
        if let string = dictionary[key] as? String, string != "" {
            return NSURL(string: string)
        }
        return nil
    }

    class func intFromDictionary(dictionary: [String:AnyObject], key: String) -> Int? {
        if let number = dictionary[key] as? Int {
            return number
        }
        return nil
    }

    class func dateFromDictionary(dictionary: [String: AnyObject], key: String) -> Date? {
        if let dateString = dictionary[key] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return formatter.date(from: dateString)
        }
        return nil
    }

    class func arrayFromDictionary(dictionary: [String: AnyObject], key: String) -> [String]? {
        if let array = dictionary[key] as? [String], array.count > 0 {
            return array
        }
        return nil
    }

    class func urlArrayFromDictionary(dictionary: [String: AnyObject], key:String) -> [NSURL]? {
        if let array = dictionary[key] as? [String], array.count > 0 {
            return array.map() {return NSURL(string: $0)!}
        }
        return nil
    }
}
