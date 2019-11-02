//
//  WearableCollectionViewCell.swift
//  inCare
//
//  Created by Andrew Carvajal on 10/26/19.
//  Copyright © 2019 inCare. All rights reserved.
//

import UIKit

enum Mode {
    case device
    case stats
}

class WearableCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    let modes: [Mode] = [.device, .stats]
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Register cell classes
        let vestCollectionViewXib = UINib(nibName: String(describing: VestCollectionViewCell.self), bundle: nil)
        collectionView.register(vestCollectionViewXib, forCellWithReuseIdentifier: String(describing: VestCollectionViewCell.self))
    }

}

// MARK: - UICollectionViewDataSource

extension WearableCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        switch modes[indexPath.row] {
        case .device:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VestCollectionViewCell.self), for: indexPath) as! VestCollectionViewCell
        case .stats:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VestCollectionViewCell.self), for: indexPath) as! VestCollectionViewCell
        }
    
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension WearableCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return frame.size
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}
