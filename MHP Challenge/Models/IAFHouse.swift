//
//  IAFHouse.swift
//  MHP Challenge
//
//  Created by Cihan Hasanoglu on 06.12.21.
//

import Foundation

// Struct for Houses and parsing data with helper class APIObjectParser.swift
struct IAFHouse: APIObject {
    
    // false if dictionary or url is empty
    var isDetailed: Bool
    var url: NSURL?
    var name: String?
    var region: String?
    var coatOfArms: String?
    var words: String?
    var titles: [String]?
    var seats: [String]?
    var currentLord: NSURL?
    var heir: NSURL?
    var overlord: NSURL?
    var founded: String?
    var founder: NSURL?
    var diedOut: String?
    var ancestralWeapons: [String]?
    var cadetBranches: [String]?
    var swordMembers:[String]?
    
    
    init?(dictionary: NSDictionary?) {
        
        guard dictionary != nil else {
            self.isDetailed = false
            return nil
        }
        isDetailed = APIObjectParser.dictionaryValid(dictionary: dictionary!)        
        self.url = APIObjectParser.urlFromDictionary(dictionary: dictionary!, key: "url")!
        self.name = APIObjectParser.stringFromDictionary(dictionary: dictionary!, key: "name")
        self.region = APIObjectParser.stringFromDictionary(dictionary: dictionary!, key: "region")
        self.coatOfArms = APIObjectParser.stringFromDictionary(dictionary: dictionary!, key: "coatOfArms")
        self.words = APIObjectParser.stringFromDictionary(dictionary: dictionary!, key: "words")
        self.titles = APIObjectParser.stringArrayFromDictionary(dictionary: dictionary!, key: "titles")
        self.seats = APIObjectParser.stringArrayFromDictionary(dictionary: dictionary!, key: "seats")
        self.currentLord = APIObjectParser.urlFromDictionary(dictionary: dictionary!, key: "currentLord")
        self.heir = APIObjectParser.urlFromDictionary(dictionary: dictionary!, key: "heir")
        self.overlord = APIObjectParser.urlFromDictionary(dictionary: dictionary!, key: "overlord")
        self.founded = APIObjectParser.stringFromDictionary(dictionary: dictionary!, key: "founded")
        self.founder = APIObjectParser.urlFromDictionary(dictionary: dictionary!, key: "founder")
        self.diedOut = APIObjectParser.stringFromDictionary(dictionary: dictionary!, key: "diedOut")
        self.ancestralWeapons = APIObjectParser.stringArrayFromDictionary(dictionary: dictionary!, key: "ancestralWeapons")
        self.cadetBranches = APIObjectParser.stringArrayFromDictionary(dictionary: dictionary!, key: "cadetBranches")
        self.swordMembers = APIObjectParser.stringArrayFromDictionary(dictionary: dictionary!, key: "swornMembers")
    }
}
