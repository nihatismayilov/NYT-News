//
//  ProfileVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 06.09.22.
//

import Foundation
import UIKit
import SnapKit

public class ProfileVC: BaseVC<ProfileViewModel> {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        self.view.addSubview(view)
        view.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        view.separatorStyle = .none
        
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        self.setupUI()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Profile"
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileMenu.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        
        cell.setupCellWith(profile: ProfileMenu.items[indexPath.row])
        
        switch indexPath.row {
        case 4:
            cell.arrowImage.isHidden = true
            cell.menuDescription.isHidden = true
        default:
            cell.arrowImage.isHidden = false
            cell.menuDescription.isHidden = false
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            tableView.deselectRow(at: indexPath, animated: true)
            let vc = self.router?.termsAndConditionsVC()
            self.navigationController?.pushViewController(vc!, animated: true)
        case 3:
            tableView.deselectRow(at: indexPath, animated: true)
            self.dialNumber(number: "+994993334696")
        default:
            print("")
        }
    }
}

extension ProfileVC {
    func dialNumber(number: String) {
        
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
             } else {
                 UIApplication.shared.openURL(url)
             }
        } else {
            
        }
    }
}

extension ProfileVC {
    func setupUI() {
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
}
