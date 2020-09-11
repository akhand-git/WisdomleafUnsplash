//
//  Protocols.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import Foundation
import UIKit

// This are some protocols I created early on and using here just to make life little easy. though in this demo I am not using all of my protocols. The protocols are pretty much self explanatory.
protocol ReusableCell {
  static var ReuseIdentifier: String { get }
  static var NibName: String { get }
}

extension ReusableCell {
  static func nib() -> UINib? {
    if !NibName.isEmpty {
      return UINib(nibName: NibName, bundle: nil)
    } else {
      return nil
    }
  }
}

extension ReusableCell where Self: UICollectionViewCell {
  static func registerNibForCollection(_ collection: UICollectionView) {
    if let nib = self.nib() {
      collection.register(nib, forCellWithReuseIdentifier: self.ReuseIdentifier)
    }
  }
}

extension ReusableCell where Self: UITableViewCell {
  static func registerNibForTable(_ table: UITableView) {
    if let nib = self.nib() {
      table.register(nib, forCellReuseIdentifier: self.ReuseIdentifier)
    }
  }
}

extension ReusableCell where Self: UICollectionReusableView {
  static func registerNibForCollection(_ collection: UICollectionView, kind: String) {
    if let nib = self.nib() {
      collection.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.ReuseIdentifier)
    }
  }
}

protocol SwipableCellProtocol: class {
    func handleSelection(cell: UITableViewCell, selected: Bool)
}
