//
//  Logging.swift
//  MeuApt
//
//  Created by mac mini capgemini sp on 13/11/17.
//  Copyright © 2017 Domene. All rights reserved.
//

import Foundation

public struct Logging{
    private init(){}
    
    static func print(_ str: String)->Void{
        print("\nDebug: \(str)")
    }
}
