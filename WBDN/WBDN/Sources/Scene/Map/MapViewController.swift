
//
//  MapViewController.swift
//  WBDN
//
//  Created by 조유진 on 2023/11/25.
//

import UIKit
import SnapKit
import Then
import MapKit
import CoreLocation


// MARK: - 지도 화면
class MapViewController: UIViewController {
    // MARK: Variables
    
    // 위치 관리 매니저
    private let locationManager = CLLocationManager()
    // 지도 뷰
    private let mapView = MKMapView()
    // 현재 지도의 중심 위치 + 스케일
    private var mapCurrentLocation: MKCoordinateRegion?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
        registerMapAnnotationView()
        setUpLayout()
        setUpView()
        setUpConstraint()
    }

    // MARK: View
    func setUpView() {
        self.view.backgroundColor = .white
        
        locationManager.requestWhenInUseAuthorization()     // 권한 확인
        locationManager.startUpdatingLocation() // 위치 업데이트
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 가장 높은 정확도의 위치 정보를 요청
        locationManager.startUpdatingLocation()
        
        // 지도 초기 설정
        mapView.showsUserLocation = true   // 사용자의 현재 위치 안보이게
        mapView.mapType = MKMapType.standard    // 일반적인 지도 스타일
        mapView.isZoomEnabled = true    // 줌 가능하게
        mapView.isScrollEnabled = true  // 이동 가능하게
        mapView.isRotateEnabled = true  // 회전 가능하게
        
        
    }
    
    // MARK: Delegate
    func setUpDelegate() {
        locationManager.delegate = self
        mapView.delegate = self
    }
    
    // MARK: Layout
    func setUpLayout() {
        self.view.addSubview(mapView)
    }
    
    // MARK: Constraint
    func setUpConstraint() {
        self.view.addSubview(mapView)
        // 지도 뷰
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // 사용자 위치 어노테이션 mapView에 추가
    private func addUserAnnotation(coordinate: CLLocationCoordinate2D) {
        let annotation = CustomAnnotation(coordinate: coordinate)
        annotation.imageName = "pin"
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - MapView에 Annotation 추가
    private func addAnnotations() {
        // annotation의 위치 설정
//        let annotation = CustomAnnotation(coordinate: ")
//
//        // annotation 이미지 이름 설정
//        annotation.imageName = "pin"
//        mapView.addAnnotation(annotation)
    }
    
    // 재사용을 위해 식별자 생성
    private func registerMapAnnotationView() {
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
    }
    
    // 식별자를 갖고 Annotation view todtjd
    private func setupAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        // dequeueReusableAnnotationView: 식별자를 확인하여 사용가능한 뷰가 있으면 해당 뷰를 반환
        return mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(CustomAnnotationView.self), for: annotation)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            addUserAnnotation(coordinate: location.coordinate)
            
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = CustomAnnotationView.identifier
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            print("nil!!!!!!!!!!!")
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.image = UIImage(named: "pin")
        }
        
        return annotationView
    }

}
