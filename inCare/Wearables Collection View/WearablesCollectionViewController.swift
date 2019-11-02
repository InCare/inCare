//
//  WearablesCollectionViewController.swift
//  inCare
//
//  Created by Andrew Carvajal on 10/26/19.
//  Copyright © 2019 inCare. All rights reserved.
//

import UIKit

enum Wearable {
    case vest
    case hallucinationFactChecker
}

class WearablesCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    let wearables: [Wearable] = [.vest]//, .hallucinationFactChecker]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // Register cell classes
        let wearableCollectionViewCell = UINib(nibName: String(describing: WearableCollectionViewCell.self), bundle: nil)
        collectionView.register(wearableCollectionViewCell, forCellWithReuseIdentifier: String(describing: WearableCollectionViewCell.self))
    }
    
    // MARK: - Overrides
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - UICollectionViewDataSource

extension WearablesCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wearables.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WearableCollectionViewCell.self), for: indexPath) as! WearableCollectionViewCell
    }
}

// MARK: - UICollectionViewDelegate

extension WearablesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.frame.size
    }
}
