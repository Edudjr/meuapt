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
    var id: Int?
    var title: String?
    var image: String?
    var viewsCount: Int?
    var commentsCount: Int?
    var createdAt: Date?
    var description: String?
    
    init(object: MarshaledObject) {
        id = try? object.value(for: "id")
        title = try? object.value(for: "title")
        image = try? object.value(for: "images.teaser")
        viewsCount = try? object.value(for: "views_count")
        createdAt = try? object.value(for: "created_at")
        description = try? object.value(for: "description")
        commentsCount = try? object.value(for: "comments_count")
    }
}
