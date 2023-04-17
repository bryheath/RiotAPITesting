//
//  UIImageExtension.swift
//  RiotAPITesting
//
//  Created by Bryan on 4/10/23.
//  Copyright © 2023 Bryan Heath. All rights reserved.
//

import Foundation
import UIKit
    
extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}
