//
//  VestCollectionViewCell.swift
//  inCare
//
//  Created by Andrew Carvajal on 10/26/19.
//  Copyright © 2019 inCare. All rights reserved.
//

import UIKit

enum TaskPosition {
    case top
    case left
    case right
    case bottom
}

class VestCollectionViewCell: UICollectionViewCell {

    // MARK: - PROPERTIES
    @IBOutlet private var circleImageView: UIImageView!
    
    var vestIsBusy = false
    var valveIsOn = false
    var pumpIsOn = false
    var vestIsInflated = false
    
    // MARK: - ACTIONS
    
    @IBAction func didTapVestButton(_ sender: UIButton) {
        guard !vestIsBusy else { return }
        
        toggleCircleImageView()

        if vestIsInflated {
            turnOffVest {}
        } else {
            turnOnVest {}
        }
    }
    
    // MARK: - OVERRIDES
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - INSTANCE METHODS
    
    private func turnOnVest(completion: @escaping () -> Void) {
        vestIsBusy = true
        
        // close valve
        toggleValve(closed: true) {
            
            // turn on pump
            self.togglePump(on: true) {
                
                // turn off pump after 5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    
                    self.togglePump(on: false) {
                        self.vestIsBusy = false
                        self.vestIsInflated = true
                        completion()
                    }
                }
            }
        }
    }
    
    private func turnOffVest(completion: @escaping () -> Void) {
        vestIsBusy = true
        
        // open valve
        toggleValve(closed: false) {
            
            // wait for deflation
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.vestIsBusy = false
                self.vestIsInflated = false
                completion()
            }
        }
    }
            
    private func togglePump(on: Bool, completion: @escaping () -> Void) {
        let state = on ? "on" : "off"
        let urlString = "\(Constant.URL.pump)/\(state)"
        load(urlString: urlString) {
            self.pumpIsOn = !self.pumpIsOn
            completion()
        }
    }
    
    private func toggleValve(closed: Bool, completion: @escaping () -> Void) {
        let state = closed ? "on" : "off"
        let urlString = "\(Constant.URL.valve)/\(state)"
        load(urlString: urlString) {
            self.valveIsOn = !self.valveIsOn
            completion()
        }
    }
    
    private func toggleCircleImageView() {
        let onCircle = #imageLiteral(resourceName: "on circle")
        let offCircle = #imageLiteral(resourceName: "off circle")
        circleImageView.image = circleImageView.image == onCircle ? offCircle : onCircle
    }
    
    private func load(urlString: String, completion: @escaping () -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("URL ERROR: \(error.localizedDescription)")
            }
            completion()
        }.resume()
    }
}
