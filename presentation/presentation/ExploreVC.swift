//
//  SearchVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 06.09.22.
//

import Foundation
import UIKit
import SnapKit
import domain
import Lottie

public class ExploreVC: BaseVC<ExploreViewModel> {
    
    // MARK: - Variables
    var searchTimer = Timer()
    var searchedText = ""
    
    var searchedNews = [SearchNews.Response.Doc]()
    
    lazy var animationView = AnimationView()
    
    // MARK: - UIComponets
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        self.view.addSubview(search)
        search.searchBarStyle = .minimal
        search.placeholder = "Search"
        search.delegate = self
        
        return search
    }()
    
    lazy var searchTableView: UITableView = {
        let view = UITableView()
        self.view.addSubview(view)
        view.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.allowsSelection = true
        
        
        return view
    }()
    
    // MARK: - Parent Delegate
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        self.setupUI()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Explore"
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension ExploreVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedNews.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
//        if let news = self.searchedNews as? [SearchNews.Response.Doc] {
            cell.setupCellWith(searchNews: self.searchedNews[indexPath.row])
//        }
                
        return cell
    }
    
//    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 128
//    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchTableView.deselectRow(at: indexPath, animated: true)
        print("LLL: \(self.searchedNews[indexPath.row].multimedia?.last?.url)")
        let model = DetailsModel(image: "https://static01.nyt.com/\(self.searchedNews[indexPath.row].multimedia?.last?.url ?? "")", title: self.searchedNews[indexPath.row].headline?.main, description: self.searchedNews[indexPath.row].abstract, writtenBy: self.searchedNews[indexPath.row].byline?.original, category: self.searchedNews[indexPath.row].category, webUrl: self.searchedNews[indexPath.row].webURL, id: self.searchedNews[indexPath.row].id, pubDate: self.searchedNews[indexPath.row].pubDate?.toDateL?.toStringWithTime.getFormattedDateDayMonthYearHour())

        let vc = self.router?.detailsVC(details: model)
        vc?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ExploreVC: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchedText = self.searchBar.text!
        if self.searchedText != "" {
            self.searchRequestSent(text: self.searchedText)
        } else {
            self.searchedNews.removeAll()
            self.searchTableView.reloadData()
        }
    }
//    public func searchBarShoudReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    @objc func searchRequestSent(text: String) {
        self.searchedNews.removeAll()
        self.addActivity(frame: (self.view.frame.standardized))
        let searchText = text
        print("Searching for \(searchText) actually fired!")
        
        let query = searchText.replacingOccurrences(of: " ", with: "%20")
        
        if Reachability.isConnectedToNetwork() {
            self.vm?.getSearchNews(with: query).then({ news in
                print("SSS: \(news)")
                
                if let docs = news.response?.docs {
                    self.searchTableView.isHidden = false
                    self.animationView.isHidden = true
                    self.searchedNews = docs
                    self.searchTableView.reloadData()
                    self.removeActivity()
                }
            })
        } else {
            self.removeActivity()
            self.displayAlertMessage(messageToDisplay: "No Internet Connection", title: "Error!")
        }

        
    }
}

extension ExploreVC {
    func setupUI() {
        
        self.searchBar.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left).offset(16)
            make.right.equalTo(self.view.snp.right).offset(-16)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        self.searchTableView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp.bottom).offset(16)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
}

//extension ExploreVC {
//    func startAnimation() {
//        animationView.animation = Animation.named("blank")
//        animationView.contentMode = .scaleAspectFit
//        animationView.animationSpeed = 0.7
//        animationView.loopMode = .loop
//        animationView.play()
//        view.addSubview(animationView)
//        animationView.layer.cornerRadius = 24
//        animationView.snp.makeConstraints { make in
//            make.height.equalTo(280)
//            make.width.equalTo(240)
//            make.center.equalTo(self.view.snp.center)
//        }
//    }
//}
