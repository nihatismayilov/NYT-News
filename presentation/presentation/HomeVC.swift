//
//  HomeVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import SnapKit
import UIKit
import domain

public class HomeVC: BaseVC<HomeViewModel> {
    
    // MARK: - Variables
    var breakingNews = [PopularNews.PopularResults]()
    
    // MARK: - UI Components
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        self.view.addSubview(view)
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = false
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    // MARK: - Parent Delegate
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        self.setupUI()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Asset.Media.newsLogo.image.withRenderingMode(.alwaysOriginal),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(onLogoTapped))
        
        print(self.vm?.getPopularNews())
        self.vm?.getPopularNews().then({ news in
            if let results = news.results {
                self.breakingNews = results
                self.tableView.reloadData()
            }
        })
    }
    // MARK: - Funstions
    
    @objc func onLogoTapped() {
        tableView.setContentOffset(.zero, animated: true)
        
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        
        switch indexPath.row {
        case 0:
            tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
            let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as! HeaderCell
            headerCell.breakingNews = self.breakingNews
            headerCell.collectionView.reloadData()
            
            cell = headerCell
        case 1:
//            tableView.register(CategoriesCell.self, forCellReuseIdentifier: self.categoryCell)
//            let categoriesCell = tableView.dequeueReusableCell(withIdentifier: self.categoryCell) as! CategoriesCell
            print("")
//            cell = categoriesCell
        case 2:
//            tableView.allowsSelection = true
//            tableView.register(TutorialsCell.self, forCellReuseIdentifier: self.tutorialCell)
//            let tutorialCell = tableView.dequeueReusableCell(withIdentifier: self.tutorialCell) as! TutorialsCell
//
//            tutorialCell.completion = {
//                let videoVC = VideoVC()
//                self.navigationController?.pushViewController(videoVC, animated: true)
//            }
            
            print("")
            
//            cell = tutorialCell
        default:
            break
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 480
        case 1:
            return 200
        default:
            return 300
        }
    }
}

//extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.breakingNews.count
//    }
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreakingNewsCell.identifier, for: indexPath) as! BreakingNewsCell
//
//        cell.setupCellWith(breakingNews: self.breakingNews[indexPath.row])
//
//        return cell
//    }
////    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return CGSize(width: (self.view.frame.size.width / 1.2), height: 320)
////    }
//}

extension HomeVC {
    func setupUI() {
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
//        collectionView.snp.makeConstraints { make in
//            make.left.equalTo(self.view.snp.left)
//            make.right.equalToSuperview()
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.centerY)
//        }
    }
}
