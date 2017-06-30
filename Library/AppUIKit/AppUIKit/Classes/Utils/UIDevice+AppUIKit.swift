//
//  UIDevice+AppUIKit.swift
//  Pods
//
//  Created by Halin Lee on 6/26/17.
//
//

import Foundation


extension UIDevice{

    static func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
}
