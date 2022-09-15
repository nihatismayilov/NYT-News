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
        view.allowsSelection = false
        //        view.isScrollEnabled = false
        view.separatorStyle = .none
        
        return view
    }()
    
    // MARK: - Parent Delegate
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        self.setupUI()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Explore"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.startAnimation()
//        self.searchTableView.isHidden = true
//        self.animationView.isHidden = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ExploreVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedNews.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        
        cell.setupCellWith(seachNews: self.searchedNews[indexPath.row])
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}

extension ExploreVC: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchTimer.invalidate() //Cancel old request if any
            self.searchedText = searchText
            searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(searchRequestSent), userInfo: searchText, repeats: false)
            print("Searching for \(searchText) scheduled")
        } else {
            self.searchedNews.removeAll()
            self.searchTableView.reloadData()
        }
    }
    
    @objc func searchRequestSent() {
        self.searchedNews.removeAll()
        let searchText = self.searchedText
        print("Searching for \(searchText) actually fired!")
        
        let query = searchText.replacingOccurrences(of: " ", with: "%20")
        
        self.vm?.getSearchNews(with: query).then({ news in
            print("SSS: \(news)")
            
            if let docs = news.response?.docs {
                self.searchTableView.isHidden = false
                self.animationView.isHidden = true
                self.searchedNews = docs
                self.searchTableView.reloadData()
            }
        })
        
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

extension ExploreVC {
    func startAnimation() {
        animationView.animation = Animation.named("blank")
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.7
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        animationView.layer.cornerRadius = 24
        animationView.snp.makeConstraints { make in
            make.height.equalTo(280)
            make.width.equalTo(240)
            make.center.equalTo(self.view.snp.center)
        }
    }
}
