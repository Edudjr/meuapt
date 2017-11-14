//
//  ShotModel.swift
//  MeuApt
//
//  Created by mac mini capgemini sp on 13/11/17.
//  Copyright © 2017 Domene. All rights reserved.
//

import Foundation
import Marshal

struct ShotModel: Unmarshaling {
    var title: String?
    var image: String?
    var viewsCount: Int?
    var createdAt: Date?
    
    init(object: MarshaledObject) {
        title = try? object.value(for: "title")
        image = try? object.value(for: "images.teaser")
        viewsCount = try? object.value(for: "views_count")
        createdAt = try? object.value(for: "created_at")
    }
}
