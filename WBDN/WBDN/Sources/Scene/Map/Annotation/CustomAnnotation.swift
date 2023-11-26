//
//  CustomAnnotation.swift
//  WBDN
//
//  Created by 조유진 on 2023/11/25.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    var imageName: String?
    var post: Post?
    
    init(coordinate: CLLocationCoordinate2D, post: Post?) {
        self.coordinate = coordinate
        self.post = post
    }
}
