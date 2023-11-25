//
//  CustomAnnotation.swift
//  WBDN
//
//  Created by 조유진 on 2023/11/25.
//

import UIKit
import MapKit
import SnapKit
import Then

class CustomAnnotationView: MKAnnotationView {
    
    // 핀 이미지
    lazy var customImageView = UIImageView().then {
//        $0.image = UIImage(named: "pin")
        $0.contentMode = .scaleAspectFit
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    func configUI() {
        self.addSubview(customImageView)
        
        customImageView.snp.makeConstraints {
            $0.width.equalTo(26)
            $0.edges.equalToSuperview()
        }
    }
    
    // Annotation 재사용 전 값을 초기화 -> 다른 값이 들어가는 것을 방지
    override func prepareForReuse() {
        super.prepareForReuse()
        customImageView.image = nil
    }

    // annotation이 뷰에서 표시되기 전에 호출
    // 뷰에 들어갈 값을 미리 설정
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? CustomAnnotation else { return }
        
        guard let imageName = annotation.imageName,
              let image = UIImage(named: imageName) else { return }
        
        customImageView.image = image   // 이미지 설정
        
    }
    
}


class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var imageName: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
