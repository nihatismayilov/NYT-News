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
    var allCategorizedNews = [CategorizedNews.Results]()
    var filteredCategorizedNews = [CategorizedNews.Results]()
    
    // MARK: - UI Components
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        self.view.addSubview(view)
        view.delegate = self
        view.dataSource = self
//        view.allowsSelection = false
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    // MARK: - Parent Delegate
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        self.setupUI()
        self.tableView.isHidden = true
        self.addActivity(frame: self.view.frame)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Asset.Media.newsLogo.image.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(onLogoTapped))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Asset.Media.profileImage.image.withRenderingMode(.alwaysOriginal),           
            style: .plain,
            target: self,
            action: #selector(onProfileTapped))
        
        self.vm?.getCategorizedNews(with: "world").then({ news in
            if let news = news.results {
                self.allCategorizedNews = news
                self.filteredCategorizedNews = news
                self.tableView.reloadData()
            }
            self.vm?.getPopularNews().then({ news in
                if let results = news.results {
                    self.breakingNews = results
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                    self.removeActivity()
                }
            })
        })
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    // MARK: - Funstions
    
    @objc func onLogoTapped() {
        tableView.setContentOffset(.zero, animated: true)
    }
    
    @objc func onProfileTapped() {
        tabBarController?.selectedIndex = 3
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return self.filteredCategorizedNews.count
        default:
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
//        cell.contentView.layoutIfNeeded()
        
        switch indexPath.section {
        case 0:
            tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
            let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as! HeaderCell
            headerCell.breakingNews = self.breakingNews
            headerCell.collectionView.reloadData()
            
            headerCell.rowSelectedCompletion = { index in
                let vc = self.router?.detailsVC(details: DetailsModel(image: self.breakingNews[index].media?.first?.mediaMetaData?.last?.url, title: self.breakingNews[index].title, description: self.breakingNews[index].abstract, writtenBy: self.breakingNews[index].byline, category: self.breakingNews[index].category, webUrl: self.breakingNews[index].url, keywords: self.breakingNews[index].keywords, id: self.breakingNews[index].id))
                
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
            cell = headerCell
        case 1:
            tableView.register(CategoriesCell.self, forCellReuseIdentifier: CategoriesCell.identifier)
            let categoriesCell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.identifier, for: indexPath) as! CategoriesCell
            categoriesCell.contentView.layoutIfNeeded()
            
            categoriesCell.selectCategoryCompletion = { index in
                
                self.vm?.getCategorizedNews(with: CategoriesMenu.items[index].title).then({ news in
                    if let news = news.results {
                        self.allCategorizedNews = news
                        self.filteredCategorizedNews = news
                        self.tableView.reloadData()
                    }
                })
            }
            
            cell = categoriesCell
        case 2:
            tableView.register(CategorizedCell.self, forCellReuseIdentifier: CategorizedCell.identifier)
            let categorizedCell = tableView.dequeueReusableCell(withIdentifier: CategorizedCell.identifier) as! CategorizedCell
            categorizedCell.contentView.layoutIfNeeded()
            
            categorizedCell.setupCellWith(categorizedNews: self.filteredCategorizedNews[indexPath.row])
            
            cell = categorizedCell
        default:
            break
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            self.tableView.deselectRow(at: indexPath, animated: false)
        case 1:
            self.tableView.deselectRow(at: indexPath, animated: false)
        case 2:
            self.tableView.deselectRow(at: indexPath, animated: true)
            let vc = self.router?.detailsVC(details: DetailsModel(image: self.filteredCategorizedNews[indexPath.row].multimedia?.last?.url, title: self.filteredCategorizedNews[indexPath.row].title, description: self.filteredCategorizedNews[indexPath.row].abstract, writtenBy: self.breakingNews[indexPath.row].byline, category: self.filteredCategorizedNews[indexPath.row].category, webUrl: self.filteredCategorizedNews[indexPath.row].url, keywords: self.filteredCategorizedNews[indexPath.row].keywords, id: nil))
            
            self.navigationController?.pushViewController(vc!, animated: true)
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 480
        case 1:
            return 64
        case 2:
            return 128
        default:
            return 128
        }
    }
}

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
