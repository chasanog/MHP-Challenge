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
    
    
    class func dictionaryValid(dictionary: NSDictionary) -> Bool{
        if dictionary.count == 0 || dictionary["url"] == nil {
            return false
            
        } else {
            return true
        }
        
    }

    class func stringFromDictionary(dictionary: NSDictionary, key: String) -> String? {
        if dictionary.object(forKey: key) != nil && dictionary.object(forKey: key) is String
        {
            let stringValue = dictionary.object(forKey: key) as? String
            guard stringValue!.count > 0 else
            {
                return nil
            }
            return stringValue
        }
        return nil
    }

    class func urlFromDictionary(dictionary: NSDictionary, key: String) -> NSURL? {
        if let string = dictionary[key] as? String, string != "" {
            return NSURL(string: string)
        }
        return nil
    }

    class func stringArrayFromDictionary<T>(dictionary: NSDictionary, key: String) -> Array<T>? {
        if dictionary.object(forKey: key) != nil && dictionary.object(forKey: key) is Array<T>
        {
            return dictionary.object(forKey: key) as? Array<T>
        }
        return nil
    }
 }
