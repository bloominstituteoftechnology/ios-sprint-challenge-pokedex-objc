//
//  NetworkController.swift
//  ObjCPokedex
//
//  Created by Shawn James on 6/19/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

import UIKit

@objc(SDJNetworkController) class NetworkController: NSObject {
    
    var pokemon = [Pokemon]()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
}
