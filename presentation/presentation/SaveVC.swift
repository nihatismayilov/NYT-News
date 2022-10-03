//
//  MenuVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 06.09.22.
//

import Foundation
import UIKit
import SnapKit
import Lottie

public class SaveVC: BaseVC<HomeViewModel> {
    // MARK: - Variables
    
    var favoriteNews = [DetailsModel]()
    
    // MARK: - UI Components
    lazy var animationView = AnimationView()
    lazy var animationText: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Asset.Colors.redColor.color
        lbl.text = "You don't have any saved news, yet"
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 16)
        
        return lbl
    }()
    
    lazy var savedTableView: UITableView = {
        let view = UITableView()
        self.view.addSubview(view)
        view.register(SavedCell.self, forCellReuseIdentifier: SavedCell.identifier)
        view.delegate = self
        view.dataSource = self
//        view.isHidden = true
//        view.allowsSelection = false
        view.showsVerticalScrollIndicator = false
//        view.isScrollEnabled = false
        view.separatorStyle = .none
        
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        self.setupUI()
        self.savePersonalData()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Favorites"
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.startAnimation()
        
//        if let data = APPDefaults.getData(key: "FavoriteNews") {
//            do {
//                let decoder = try JSONDecoder().decode([DetailsModel].self, from: data)
//                self.favoriteNews = decoder
//
//                savedTableView.reloadData()
//                self.savedTableView.isHidden = self.favoriteNews.isEmpty
//                self.animationView.isHidden = !self.favoriteNews.isEmpty
//                self.animationText.isHidden = !self.favoriteNews.isEmpty
//            } catch {
//                print("Couldn't")
//            }
//        }
        if let favorites = DetailsHelper.shared.detailsModelArray {
            self.favoriteNews = favorites
            self.savedTableView.reloadData()
            self.savedTableView.isHidden = self.favoriteNews.isEmpty
            self.animationView.isHidden = !self.favoriteNews.isEmpty
            self.animationText.isHidden = !self.favoriteNews.isEmpty
        }
    }
}

extension SaveVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteNews.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedCell.identifier, for: indexPath) as! SavedCell
        
        cell.setupCellWith(news: self.favoriteNews[indexPath.row])
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = router?.detailsVC(details: self.favoriteNews[indexPath.row])
        vc!.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension SaveVC {
    func setupUI() {
        self.savedTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
}

extension SaveVC {
    func startAnimation() {
        if overrideUserInterfaceStyle == .dark {
            animationView.animation = Animation.named("noFavoritesDark")
        } else {
            animationView.animation = Animation.named("noFavorites")
        }
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.7
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        animationView.layer.cornerRadius = 24
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(320)
            make.center.equalTo(self.view.snp.center)
        }
        self.view.addSubview(animationText)
        animationText.snp.makeConstraints { make in
            make.top.equalTo(self.animationView.snp.bottom)
            make.centerX.equalTo(self.animationView.snp.centerX)
        }
    }
}
