//
//  IAFHouse.swift
//  MHP Challenge
//
//  Created by Cihan Hasanoglu on 06.12.21.
//

import Foundation

// Struct for Houses and parsing data with helper class APIObjectParser.swift
struct IAFHouse: APIObject {
    static let type = "house"
    

    
    let url: NSURL
    let name: String?
    let region: String?
    let coatOfArms: String?
    let words: String?
    let titles: [String]?
    let seats: [String]?
    let currentLord: NSURL?
    let heir: NSURL?
    let overlord: NSURL?
    let founded: String?
    let founder: NSURL?
    let diedOut: String?
    let ancestralWeapons: [String]?
    let cadetBranches: [String]?
    let swordMembers:[String]?
    
    init?(dictionary: [String : AnyObject]) {
        guard APIObjectParser.dictionaryValid(dictionary: dictionary) else {
            url = NSURL()
            name = nil
            region = nil
            coatOfArms = nil
            words = nil
            titles = nil
            seats = nil
            currentLord = nil
            heir = nil
            overlord = nil
            founded = nil
            founder = nil
            diedOut = nil
            ancestralWeapons = nil
            cadetBranches = nil
            swordMembers = nil
            return nil
        }
        
        url = APIObjectParser.urlFromDictionary(dictionary: dictionary, key: "url")!
        name = APIObjectParser.stringFromDictionary(dictionary: dictionary, key: "name")
        region = APIObjectParser.stringFromDictionary(dictionary: dictionary, key: "region")
        coatOfArms = APIObjectParser.stringFromDictionary(dictionary: dictionary, key: "coatOfArms")
        words = APIObjectParser.stringFromDictionary(dictionary: dictionary, key: "words")
        titles = APIObjectParser.arrayFromDictionary(dictionary: dictionary, key: "titles")
        seats = APIObjectParser.arrayFromDictionary(dictionary: dictionary, key: "seats")
        currentLord = APIObjectParser.urlFromDictionary(dictionary: dictionary, key: "currentLord")
        heir = APIObjectParser.urlFromDictionary(dictionary: dictionary, key: "heir")
        overlord = APIObjectParser.urlFromDictionary(dictionary: dictionary, key: "overlord")
        founded = APIObjectParser.stringFromDictionary(dictionary: dictionary, key: "founded")
        founder = APIObjectParser.urlFromDictionary(dictionary: dictionary, key: "founder")
        diedOut = APIObjectParser.stringFromDictionary(dictionary: dictionary, key: "diedOut")
        ancestralWeapons = APIObjectParser.arrayFromDictionary(dictionary: dictionary, key: "ancestralWeapons")
        cadetBranches = APIObjectParser.arrayFromDictionary(dictionary: dictionary, key: "cadetBranches")
        swordMembers = APIObjectParser.arrayFromDictionary(dictionary: dictionary, key: "swornMembers")
    }
}
