//
//  HouseDetailVC.swift
//  MHP Challenge
//
//  Created by Cihan Hasanoglu on 08.12.21.
//

import Foundation
import UIKit

// Detail View Controller for House element coming from root VC
class HouseDetailVC: UIViewController {
    var houseForDV: IAFHouse?
    
    let houseNameLabel = UILabel()
    let regionLabel = UILabel()
    let coatOfArmsLabel = UILabel()
    let wordsLabel = UILabel()
    let foundedLabel = UILabel()
    let diedOutLabel = UILabel()
    let titlesLabel = UILabel()
    let seatsLabel = UILabel()
    let ancestralWeaponsLabel = UILabel()
    let cadetBranchesLabel = UILabel()
    let swordMembersLabel = UILabel()
    
    let closeButton = UIButton()
    
    
    let regionBold = "Region: "
    let coatsOfArmsBold = "Coats of Arms: "
    let wordsBold = "Words: "
    let foundedBold = "Founded: "
    let diedOutBold = "Died out: "
    
    var titleBold = "Title"
    var seatsBold = "Seat"
    var ancestralBold = "Ancestral Weapon"
    
    var safeArea: UILayoutGuide!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            view.backgroundColor = .white
        case .dark:
            view.backgroundColor = .black
            
        }
        safeArea = view.layoutMarginsGuide
        fillUILabelText()
        positionOfName()
        positionOfNewLabel(regionLabel, houseNameLabel)
        positionOfNewLabel(coatOfArmsLabel, regionLabel)
        positionOfNewLabel(wordsLabel, coatOfArmsLabel)
        positionOfNewLabel(foundedLabel, wordsLabel)
        positionOfNewLabel(diedOutLabel, foundedLabel)
        positionOfNewLabel(titlesLabel, diedOutLabel)
        positionOfNewLabel(seatsLabel, titlesLabel)
        positionOfNewLabel(ancestralWeaponsLabel, seatsLabel)
        positionOfCloseButton()
    }
    
    // given two strings one part will be bold -> returns NSMutableAttributedString
    func formatStringPartially(_ boldString: String?, _ normalString: String) -> NSMutableAttributedString{
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        let attributedString = NSMutableAttributedString(string: boldString ?? "", attributes: attrs)
        let attributedNormalString = NSMutableAttributedString(string: normalString)
        attributedString.append(attributedNormalString)
        
        return attributedString
    }
    
    // fills Labels on this view with text
    func fillUILabelText() {
        houseNameLabel.text = houseForDV?.name
        
        if houseForDV?.region == nil {
            regionLabel.isEnabled = false
        } else {
            regionLabel.isEnabled = true
            regionLabel.attributedText = formatStringPartially(regionBold, (houseForDV?.region)!)
        }
        
        if houseForDV?.coatOfArms == nil {
            coatOfArmsLabel.isEnabled = false
        } else {
            coatOfArmsLabel.isEnabled = true
            coatOfArmsLabel.attributedText = formatStringPartially(coatsOfArmsBold, (houseForDV?.coatOfArms)!)
        }
        
        if houseForDV?.words == nil {
            wordsLabel.isEnabled = false
        } else {
            wordsLabel.isEnabled = true
            wordsLabel.attributedText = formatStringPartially(wordsBold, (houseForDV?.words)!)
        }
        
        if houseForDV?.founded == nil {
            foundedLabel.isEnabled = false
        } else {
            foundedLabel.isEnabled = true
            foundedLabel.attributedText = formatStringPartially(foundedBold, (houseForDV?.founded)!)
        }
        
        if houseForDV?.diedOut == nil {
            diedOutLabel.isEnabled = false
        } else {
            diedOutLabel.isEnabled = true
            diedOutLabel.attributedText = formatStringPartially(diedOutBold, (houseForDV?.diedOut)!)
        }
        
        if houseForDV?.titles == nil {
            titlesLabel.isEnabled = false
        } else {
            titlesLabel.isEnabled = true
            fillLabelWithArray(label: titlesLabel, houseElement: (houseForDV?.titles)!)
        }
        
        if houseForDV?.seats == nil {
            seatsLabel.isEnabled = false
        } else {
            seatsLabel.isEnabled = true
            fillLabelWithArray(label: seatsLabel, houseElement: (houseForDV?.seats)!)
        }
        
        if houseForDV?.ancestralWeapons == nil {
            ancestralWeaponsLabel.isEnabled = false
        } else {
            ancestralWeaponsLabel.isEnabled = true
            fillLabelWithArray(label: ancestralWeaponsLabel, houseElement: (houseForDV?.ancestralWeapons)!)
        }
        
    }
    
    // positioning and formatting Name Label
    func positionOfName() {
        view.addSubview(houseNameLabel)
        houseNameLabel.translatesAutoresizingMaskIntoConstraints = false
        houseNameLabel.textAlignment = .center
        houseNameLabel.font = .preferredFont(forTextStyle: .largeTitle)
        houseNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        houseNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100).isActive = true
        houseNameLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8).isActive = true
        houseNameLabel.heightAnchor.constraint(equalTo: houseNameLabel.heightAnchor).isActive = true
        houseNameLabel.numberOfLines = 0
        houseNameLabel.lineBreakMode = .byWordWrapping
        houseNameLabel.frame = CGRect(x: houseNameLabel.frame.origin.x, y: houseNameLabel.frame.origin.y, width: houseNameLabel.frame.size.width, height: houseNameLabel.frame.size.height)
        
    }
    
    // positioning and formatting Close Button
    func positionOfCloseButton() {
        view.addSubview(closeButton)
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30).isActive = true
        closeButton.setImage(UIImage(systemName: "chevron.down", withConfiguration: buttonSizeConfig), for: .normal)
        closeButton.tintColor = .gray
      
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    // selector of positionfOfCloseButton()
    @objc func closeAction() {
        self.dismiss(animated: true)
    }
    
    // reusable function to format and position any label with second label given for constraints
    func positionOfNewLabel(_ firstLabel: UILabel, _ secondLabel: UILabel) {
        view.addSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.textAlignment = .center
        if secondLabel == houseNameLabel {
            firstLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 50).isActive = true
        } else {
            firstLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 10).isActive = true
        }
        firstLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8).isActive = true
        firstLabel.heightAnchor.constraint(equalTo: firstLabel.heightAnchor).isActive = true
        firstLabel.numberOfLines = 0
        firstLabel.lineBreakMode = .byWordWrapping
    }
    
    // filling Label with response data when data is an array
    func fillLabelWithArray(label: UILabel, houseElement: [String]) {
        label.numberOfLines = houseElement.count + 1
        label.lineBreakMode = .byClipping
        if houseElement != [""] {
            if houseElement.count == 1{
                if label == titlesLabel {
                    label.attributedText = formatStringPartially("\(titleBold): ", houseElement[0])
                } else if label == seatsLabel {
                    label.attributedText = formatStringPartially("\(seatsBold): ", houseElement[0])
                }
                else if label == ancestralWeaponsLabel {
                    label.attributedText = formatStringPartially("\(ancestralBold): ", houseElement[0])
                }
                
            } else
            {
                for str in houseElement {
                    if label.text == nil {
                        if label == titlesLabel {
                            label.attributedText = formatStringPartially("\(titleBold)s: ", houseElement[0])
                        } else if label == seatsLabel {
                            label.attributedText = formatStringPartially("\(seatsBold)s: ", houseElement[0])
                        } else if label == ancestralWeaponsLabel {
                            label.attributedText = formatStringPartially("\(ancestralBold)s: ", houseElement[0])
                        }
                        
                    } else {
                        var prepareAttrStr: String = ""
                        if str != houseElement.last {
                            prepareAttrStr += ", \(str)"
                        }
                        else if str == houseElement.last {
                            prepareAttrStr += "\(houseElement[0]), \(prepareAttrStr) \(str)"
                        }
                        if label == titlesLabel {
                            label.attributedText = formatStringPartially("\(titleBold)s: ", prepareAttrStr)
                        } else if label == seatsLabel {
                            label.attributedText = formatStringPartially("\(seatsBold)s: ", prepareAttrStr)
                        } else if label == ancestralWeaponsLabel {
                            label.attributedText = formatStringPartially("\(ancestralBold)s: ", prepareAttrStr)
                        }
                        
                    }
                    
                }
            }
            
        }
    }
    

}
