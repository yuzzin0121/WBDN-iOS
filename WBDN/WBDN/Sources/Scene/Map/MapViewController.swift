
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
    
    // 검색 버튼 뷰
    lazy var searchBtnView = UIView().then {
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = .customNavy
        $0.layer.cornerRadius = 28
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    // 검색 버튼 placeholder
    lazy var searchBtnPlaceholder = UILabel().then {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        let attributedString = NSMutableAttributedString(string: "   장소를 검색해보세요.", attributes: attributes)

        // 검색 아이콘
        if let searchImage = UIImage(named: "search") {
            let iconAttachment = NSTextAttachment()
            iconAttachment.image = searchImage
            let iconString = NSAttributedString(attachment: iconAttachment)
            attributedString.insert(iconString, at: 0)
        }
        
        $0.attributedText = attributedString
        $0.sizeToFit()
    }
    
    // 위치 관리 매니저
    private let locationManager = CLLocationManager()
    // 지도 뷰
    private let mapView = MKMapView()
    // 현재 지도의 중심 위치 + 스케일
    private var mapCurrentLocation: MKCoordinateRegion?
    
//    var postLocations: [PostLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDelegate()
        registerMapAnnotationView()
        setUpLayout()
        setUpView()
        setUpConstraint()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchBtnDidTap(_:)))
        searchBtnView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // 서버에서 받아오기
        Task {
            let response = try await NetworkService.shared.request(.getPostMaps, type:  BaseResponse<[PostLocation]>.self)
            
            guard let postLocations = response.result else { return }
            
            await MainActor.run(body: {
                addAnnotations(postLocations: postLocations)
            })
            
        }
    }
    var latitude: Double = 0
    var longitude: Double = 0

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
        self.view.addSubview(searchBtnView)
        self.searchBtnView.addSubview(searchBtnPlaceholder)
    }
    
    // MARK: Constraint
    func setUpConstraint() {
        // 지도 뷰
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 검색 버튼 뷰
        searchBtnView.snp.makeConstraints {
            $0.width.equalTo(view.bounds.width * 0.82)
            $0.height.equalTo(55)
//            $0.width.equalTo(view.snp.width*0.8)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            $0.centerX.equalTo(view.snp.centerX)
            
        }
        
        searchBtnPlaceholder.snp.makeConstraints {
            $0.centerY.equalTo(searchBtnView.snp.centerY)
            $0.leading.equalTo(searchBtnView.snp.leading).offset(20)
        }
        mapView.bringSubviewToFront(searchBtnView)
    }
    
    // 검색 버튼 눌렀을 때
    @objc func searchBtnDidTap(_ gesture: UITapGestureRecognizer) {
        let searchLocationVC = SearchLocationViewController()
        
        searchLocationVC.completionHandler = {
            [weak self] coordinate in
            
            let region = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: 15000,
                                            longitudinalMeters: 15000)
            
            self?.mapView.setRegion(region, animated: true)
        }
       
        self.present(searchLocationVC, animated: true, completion: nil)
    }
    
    // 사용자 위치 어노테이션 mapView에 추가
    private func addUserAnnotation(coordinate: CLLocationCoordinate2D) {
        let annotation = CustomAnnotation(coordinate: coordinate, post: nil)
        annotation.imageName = "pin"
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - MapView에 Annotation 추가
    private func addAnnotations(postLocations: [PostLocation]) {
        // annotation의 위치 설정
        
        postLocations.map { postLocation in
            CustomAnnotation(coordinate: .init(latitude: postLocation.latitude, longitude: postLocation.longitude), post: .init(postId: postLocation.postId, nickname: postLocation.nickname, photoUrl: postLocation.photoUrl, likes: postLocation.likes))
        }.forEach { annotation in
            annotation.imageName = "pin"
            mapView.addAnnotation(annotation)
        }
        

        // annotation 이미지 이름 설정
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

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            mapView.setRegion(region, animated: true)
            addUserAnnotation(coordinate: location.coordinate)
            
        }
    }
}

// MARK: - MKMapViewDelegate
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

    func mapView(_: MKMapView, didSelect: MKAnnotationView) {
        guard let annotationView = didSelect as? CustomAnnotationView,
              let annotation = annotationView.annotation as? CustomAnnotation,
              let post = annotation.post else { return }
          
        let detailVC = DetailViewController()
        detailVC.configure(post: post)
        SceneDelegate.navigationController.pushViewController(detailVC, animated: true)

        
    }
}
