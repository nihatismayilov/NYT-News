//
//  ProfileVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 06.09.22.
//

import Foundation
import UIKit
import SnapKit
import Firebase

public class ProfileVC: BaseVC<ProfileViewModel> {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        self.view.addSubview(view)
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
        self.savePersonalData()
        
        self.navigationController?.navigationBar.tintColor = Asset.Colors.redWithDark.color
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Profile"
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func onLogout() {
        do {
            try Auth.auth().signOut()
            APPDefaults.remove(key: "UserName")
            APPDefaults.remove(key: "UserSurname")
            APPDefaults.remove(key: "UserMail")
            APPDefaults.remove(key: "UserPassword")
            APPDefaults.remove(key: "FavoriteNews")
            let vc = self.router?.signInVC()
            vc?.modalTransitionStyle = .coverVertical
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: true)
        }catch {
            print(error)
        }
    }
        
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return ProfileMenu.items.count
        default:
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
            let infoCell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as! InfoCell
            
            let name = APPDefaults.getString(key: "UserName") ?? "-"
            let surname = APPDefaults.getString(key: "UserSurname") ?? "-"
            let mail = APPDefaults.getString(key: "UserMail") ?? "-"
            
            infoCell.setupCellWith(title: "\(name.first ?? "-")\(surname.first ?? "-")", name: "\(name) \(surname)", mail: mail)
            
            cell = infoCell
        case 1:
            tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
            let profileMenuCell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
            
            profileMenuCell.setupCellWith(profile: ProfileMenu.items[indexPath.row])
            
            if APPDefaults.getString(key: "theme") == "Dark" {
                profileMenuCell.switchButton.isOn = true
            } else {
                profileMenuCell.switchButton.isOn = false
            }
            
            profileMenuCell.switchCompletion = {
                if profileMenuCell.switchButton.isOn {
                    UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .dark
                    APPDefaults.setString(key: "theme", value: "Dark")
                } else {
                    UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .light
                    APPDefaults.setString(key: "theme", value: "Light")
                }
            }
            
            switch indexPath.row {
            case 4:
                profileMenuCell.arrowImage.isHidden = true
                profileMenuCell.switchButton.isHidden = false
                profileMenuCell.menuDescription.isHidden = true
            case 5:
                profileMenuCell.arrowImage.isHidden = true
                profileMenuCell.switchButton.isHidden = true
                profileMenuCell.menuDescription.isHidden = true
            default:
                profileMenuCell.arrowImage.isHidden = false
                profileMenuCell.switchButton.isHidden = true
                profileMenuCell.menuDescription.isHidden = false
            }
            
            cell = profileMenuCell
        default:
            return cell
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, selectionFollowsFocusForRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.row {
        case 1:
            return false
        default:
            return true
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 1:
            let vc = self.router?.termsAndConditionsVC()
            self.navigationController?.pushViewController(vc!, animated: true)
        case 2:
            let vc = self.router?.privacyPolicyVC()
            self.navigationController?.pushViewController(vc!, animated: true)
        case 3:
            self.dialNumber(number: "+994993334696")
        case 4:
            break
        case 5:
//            self.displayAlertMessage(messageToDisplay: "Do you want to sign out?", title: "")
            
            let alert = UIAlertController(title: "Are you sure?", message: "You're leaving so soon", preferredStyle: .alert)
            
            let closeBtn = UIAlertAction(title: "Close", style: .cancel)
            let logoutBtn = UIAlertAction(title: "Log out", style: .destructive) {
                UIAlertAction in
                self.onLogout()
            }
            
            alert.addAction(closeBtn)
            alert.addAction(logoutBtn)
            
            self.present(alert, animated: true)
        default:
            break
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
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
}
