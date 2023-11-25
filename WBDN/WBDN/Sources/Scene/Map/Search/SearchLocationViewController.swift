//
//  SearchLocationViewController.swift
//  WBDN
//
//  Created by 조유진 on 2023/11/25.
//

import UIKit
import MapKit
import SnapKit
import Then

class SearchLocationViewController: UIViewController {
    // MARK: - Properties
    private var searchCompleter = MKLocalSearchCompleter() /// 검색을 도와주는 변수
    private var searchResults = [MKLocalSearchCompletion]() /// 검색 결과를 담는 변수
 
    // 검색된 위치정보를 전달할 핸들러
    var completionHandler: ((CLLocationCoordinate2D) -> (Void))?
    
    // 상단 뷰
    let topView = UIView().then {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
    }
    
    // 제목
    let titleLabel = UILabel().then {
       $0.text = "도시, 우편번호 입력"
       $0.font = .systemFont(ofSize: 14, weight: .semibold)
       $0.textColor = .white
       $0.textAlignment = .center
    }
    
    // 검색 바
    let searchBar = UISearchBar().then {
        $0.becomeFirstResponder()
        $0.keyboardAppearance = .dark
        $0.showsCancelButton = false
        $0.searchBarStyle = .minimal
        $0.searchTextField.leftView?.tintColor = UIColor.white.withAlphaComponent(0.5)
        $0.searchTextField.backgroundColor = .lightGray
        $0.searchTextField.textColor = .white
        $0.searchTextField.tintColor = .white
        $0.searchTextField.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색",
                                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
    }
    
    // 취소 버튼
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.tintColor = .white
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.addTarget(self, action: #selector(cancelBtnDidTap(_:)), for: .touchUpInside)
    }
    
    
    let lineView = UIView().then {
        $0.backgroundColor = .lightGray
    }
   
    // 검색 테이블뷰
    let searchTableView = UITableView().then {
        $0.backgroundColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
        setUpTableView()
        setUpView()
        setUpBlurEffect()
        setUpLayout()
        
        setUpConstraint()
        
    }
    
    // MARK: Layout
    func setUpLayout() {
        [topView, searchTableView].forEach {
            view.addSubview($0)
        }
        [titleLabel, searchBar, cancelButton, lineView].forEach {
            topView.addSubview($0)
        }
    }
    
    // MARK: View
    func setUpView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    // MARK: Delegate
    func setUpDelegate() {
        // searchBar
        searchBar.delegate = self
        
        // tableview
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
        
    }
    
    // MARK: @objc
    @objc func cancelBtnDidTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.frame
        topView.addSubview(visualEffectView)
//        topView.addSubview(visualEffectView)
    }
    
    func setUpTableView() {
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchTableView.separatorStyle = .none
    }
    
    // MARK: Constraint
    func setUpConstraint() {
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(6)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-2)
            $0.height.equalTo(40)
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerY.equalTo(searchBar.snp.centerY)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    
}

// MARK: - UISearchBarDelegate
extension SearchLocationViewController: UISearchBarDelegate {
    // 검색창의 text가 변하는 경우에 searchBar가 delegate에게 알리는데 사용하는 함수
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText를 queryFragment로 넘겨준다.
        searchCompleter.queryFragment = searchText
    }
}

// MARK: - MKLocalSearchCompleterDelegate
extension SearchLocationViewController: MKLocalSearchCompleterDelegate {
    // 자동완성 완료 시에 결과를 받는 함수
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // completer.results를 통해 검색한 결과를 searchResults에 담아준다
        searchResults = completer.results
        searchTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // 에러 확인
        print(error.localizedDescription)
    }
}

// MARK: - UITableViewDataSource
extension SearchLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell
        else { return UITableViewCell() }
        cell.countryLabel.text = searchResults[indexPath.row].title
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
//        if let highlightText = searchBar.text {
//            cell.countryLabel.setHighlighted(searchResults[indexPath.row].title, with: highlightText)
//        }

        return cell
    }
}

extension SearchLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            
            let searchLatitude = placeMark.coordinate.latitude
            let searchLongtitude = placeMark.coordinate.longitude
            let coordination: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: searchLatitude, longitude: searchLongtitude)
           
            self.completionHandler?(coordination)   // 위치 정보 MapViewController에 전달
            
            self.dismiss(animated: true)    // 모달 내리기
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
}
