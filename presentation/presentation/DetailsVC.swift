//
//  DetailsVC.swift
//  presentation
//
//  Created by Nihad Ismayilov on 13.09.22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
import SafariServices
import Lottie
import Firebase
import FirebaseFirestore

public class DetailsVC: BaseVC<DetailsViewModel>, UIGestureRecognizerDelegate {
    
    // MARK: - Variables
//    let database = Firestore.firestore()
    
    var details: DetailsModel?
    var sharedLink: String?
    
    // MARK: - UIComponents
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        self.view.addSubview(scroll)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        self.scrollView.addSubview(view)
        
        return view
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton()
        self.backView.addSubview(btn)
        btn.setImage(Asset.Media.icBack.image.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(onBackTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var saveView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    lazy var saveButton: UIButton = {
        let btn = UIButton()
        self.saveView.addSubview(btn)
        btn.imageView?.tintColor = .white
        btn.setImage(Asset.Media.saveEmpty.image.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(onSaveTapped), for: .touchUpInside)
        
        return btn
    }()
    
    //    lazy var saveAnimation = AnimationView()
    
    lazy var shareView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    lazy var shareButton: UIButton = {
        let btn = UIButton()
        self.shareView.addSubview(btn)
        btn.imageView?.tintColor = .white
        btn.setImage(Asset.Media.icDownload.image.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.addTarget(self, action: #selector(onShareTapped), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        self.contentView.addSubview(img)
        img.image = Asset.Media.girlCampingBesideACar1280Ã800.image
        img.contentMode = .scaleAspectFill
        
        img.isUserInteractionEnabled = true
        let imgGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        img.addGestureRecognizer(imgGesture)
        
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        self.detailsView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.extraBold, size: 24)
        lbl.numberOfLines = 0
        lbl.text = "Retreat in Ukraine’s Northeast Leaves Other Russian Territory Vulnerable"
        
        return lbl
    }()
    
    lazy var detailsView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.backgroundColor = Asset.Colors.backgroundColor.color
        
        return view
    }()
    
    lazy var categoryView: UIView = {
        let view = UIView()
        self.imageView.addSubview(view)
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let lbl = UILabel()
        self.categoryView.addSubview(lbl)
        lbl.textColor = .white
        lbl.font = UIFont(font: FontFamily.NunitoSans.extraBold, size: 14)
        lbl.text = "Technology"
        
        return lbl
    }()
    
    lazy var writtenByView: UIView = {
        let view = UIView()
        self.imageView.addSubview(view)
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    lazy var writtenByLabel: UILabel = {
        let lbl = UILabel()
        self.writtenByView.addSubview(lbl)
        lbl.textColor = .white
        lbl.font = UIFont(font: FontFamily.NunitoSans.extraBold, size: 14)
        lbl.numberOfLines = 0
        
        lbl.text = "David Gelles"
        
        return lbl
    }()
    
    lazy var aboutText: UILabel = {
        let lbl = UILabel()
        self.detailsView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.extraBold, size: 20)
        lbl.text = "Description"
        
        return lbl
    }()
    
    lazy var aboutLabel: UILabel = {
        let lbl = UILabel()
        self.detailsView.addSubview(lbl)
        lbl.textColor = Asset.Colors.textColor.color
        lbl.font = UIFont(font: FontFamily.NunitoSans.regular, size: 16)
        lbl.numberOfLines = 0
        lbl.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
        
        return lbl
    }()
    
    lazy var webLabel: UILabel = {
        let lbl = UILabel()
        self.detailsView.addSubview(lbl)
        lbl.textColor = .systemBlue
        lbl.font = UIFont(font: FontFamily.NunitoSans.bold, size: 14)
        lbl.text = "Link to web page"
        
        lbl.isUserInteractionEnabled = true
        let webGesture = UITapGestureRecognizer(target: self, action: #selector(onUrlTapped))
        lbl.addGestureRecognizer(webGesture)
        
        return lbl
    }()
    
    // MARK: - Parent Delegate
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Asset.Colors.backgroundColor.color
        self.setupUI()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        //        self.animationFirstState()
        
        let saveGesture = UITapGestureRecognizer(target: self, action: #selector(onSaveTapped))
        //        self.saveAnimation.addGestureRecognizer(saveGesture)
        
        self.setData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        guard DetailsHelper.shared.detailsModelArray?.isEmpty == false else {
            self.saveButton.setImage(Asset.Media.saveEmpty.image, for: .normal)
            return
        }
//        if let detail = self.details, DetailsHelper.shared.detailsModelArray?.contains(detail) == true {
//            self.saveButton.setImage(Asset.Media.saveFilled.image, for: .normal)
//        } else {
//            self.saveButton.setImage(Asset.Media.saveEmpty.image, for: .normal)
//        }
        
        let filteredModel = DetailsHelper.shared.detailsModelArray?.filter({ model in
            if model.title == self.details?.title {
                return true
            } else {
                return false
            }
        })
        
        if filteredModel?.isEmpty == false {
            self.saveButton.setImage(Asset.Media.saveFilled.image, for: .normal)
        } else {
            self.saveButton.setImage(Asset.Media.saveEmpty.image, for: .normal)
        }
//        do {
//            if let data = APPDefaults.getData(key: "FavoriteNews") {
//                let decoder = try JSONDecoder().decode([DetailsModel].self, from: data)
//                DetailsHelper.shared.detailsModelArray = decoder
//
//                let checkingDetail = DetailsHelper.shared.detailsModelArray?.filter({ detail in
//                    if detail == self.details {
//                        return true
//                    } else {
//                        return false
//                    }
//                })
//                if checkingDetail?.isEmpty == false {
//                    self.saveButton.setImage(Asset.Media.saveFilled.image, for: .normal)
//                } else {
//                    self.saveButton.setImage(Asset.Media.saveEmpty.image, for: .normal)
//                }
////                if ((DetailsHelper.shared.detailsModelArray?.contains(self.details!)) != nil) {
////                    self.saveButton.setImage(Asset.Media.saveFilled.image, for: .normal)
////                } else {
////                    self.saveButton.setImage(Asset.Media.saveEmpty.image, for: .normal)
////                }
//            } else {
//                print("")
//            }
//        } catch {
//            print("Couldn't")
//        }
        
//
//        DetailsHelper.shared.detailsModelArray?.forEach({ detail in
//            print("HERE \(detail)")
//            if detail == self.details {
//
//                return
//            } else {
//                //                    self.animationFirstState()
//            }
//        })
        
        //        if DetailsHelper.shared.detailsModelArray?.contains(where: { detail in
        //
        //        })
        //        if DetailsHelper.shared.detailsModelArray?.contains(where: { details in
        //            if details == self.details {
        //                self.animationLastState()
        //                return true
        //            } else {
        //                self.animationFirstState()
        //                return false
        //            }
        //        })
    }
    // MARK: - Functions
    
    @objc func onSaveTapped() {
        
        
        DetailsHelper.shared.detailsModelArray?.forEach({ detail in
            if self.details == detail {
                self.saveButton.setImage(Asset.Media.saveFilled.image, for: .normal)
                return
            } else {
                //                    self.animationFirstState()
                self.saveButton.setImage(Asset.Media.saveEmpty.image, for: .normal)
            }
        })
        
        if DetailsHelper.shared.detailsModelArray?.contains(self.details!) ?? false, let idIndex = DetailsHelper.shared.detailsModelArray?.firstIndex(of: self.details!) {
            
            DetailsHelper.shared.detailsModelArray?.remove(at: idIndex)
            self.saveButton.setImage(Asset.Media.saveEmpty.image, for: .normal)
            //            self.startAnimationBackward()
        } else {
            DetailsHelper.shared.detailsModelArray?.append(self.details!)
            self.saveButton.setImage(Asset.Media.saveFilled.image, for: .normal)
            //            self.startAnimation()
            //                    self.animationView.stop()
        }
        
//        do {
//            let data = try JSONEncoder().encode(DetailsHelper.shared.detailsModelArray)
//            APPDefaults.setData(key: "FavoriteNews", value: data)
//        } catch {
//            print("Couldn't save news to appDefaults")
//        }
        if let uuid = Firebase.Auth.auth().currentUser?.uid {
            do {
                let data = try JSONEncoder().encode(DetailsHelper.shared.detailsModelArray)
                
                APPDefaults.setData(key: "FavoriteNews", value: data)
                let favoritesRef = database.document("\(uuid)/favorites")
                favoritesRef.setData(["favoriteNews": data])
            } catch {
                print("Couldn't save news to appDefaults")
            }
        }
    }
    
    @objc func onBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onShareTapped() {
        if let link = sharedLink {
            let activityController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
            present(activityController, animated: true)
        }
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        
        //        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        //        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    @objc func onUrlTapped() {
        
        if let link = sharedLink {
            let svc = SFSafariViewController(url: URL.init(string: link)!)
            present(svc, animated: true, completion: nil)
        }
    }
    
    func setData() {
        var imageUrl: URL?
        if let url = self.details?.image {
            imageUrl = URL.init(string: "\(url)")
        }
        self.imageView.kf.setImage(with: imageUrl, placeholder: UIImage()) { result in
            switch result {
            case .success(let imageResult):
                self.imageView.image = imageResult.image.withRenderingMode(.alwaysOriginal)
            case .failure(let err):
                print(err)
            }
        }
        
        self.titleLabel.text = self.details?.title ?? "N/A"
        self.aboutLabel.text = self.details?.description ?? "N/A"
        self.writtenByLabel.text = self.details?.writtenBy ?? "N/A"
        self.categoryLabel.text = self.details?.category ?? "N/A"
        self.sharedLink = self.details?.webUrl
        
    }
}

//extension DetailsVC {
//    func animationFirstState() {
//        saveAnimation.animation = Animation.named("save")
//        saveAnimation.contentMode = .scaleAspectFill
//    }
//
//    func animationLastState() {
//        saveAnimation.animation = Animation.named("save")
//        saveAnimation.currentProgress = 1.0
//        saveAnimation.contentMode = .scaleAspectFill
//    }
//
//    func startAnimation() {
//        saveAnimation.animation = Animation.named("save")
//        saveAnimation.animationSpeed = 1.0
//        saveAnimation.loopMode = .playOnce
//        saveAnimation.contentMode = .scaleAspectFill
//
//        saveAnimation.play { (finished) in }
//    }
//
//    func startAnimationBackward() {
//        saveAnimation.animation = Animation.named("save")
//        saveAnimation.animationSpeed = -1.0
//        saveAnimation.currentProgress = 1.0
//        saveAnimation.loopMode = .repeatBackwards(1)
//        saveAnimation.contentMode = .scaleAspectFill
//
//        saveAnimation.play { (finished) in }
//    }
//}

extension DetailsVC {
    func setupUI() {
        self.scrollView.snp.makeConstraints { make in
            //            make.edges.equalToSuperview()
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        self.contentView.snp.makeConstraints { make in
            make.edges.equalTo(self.scrollView.snp.edges)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.equalTo(800)
        }
        
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.centerY)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.detailsView.snp.top).offset(32)
            make.left.equalTo(self.detailsView.snp.left).offset(16)
            make.right.equalTo(self.detailsView.snp.right).offset(-16)
        }
        
        self.writtenByView.snp.makeConstraints { make in
            make.left.equalTo(self.imageView.snp.left).offset(16)
            make.right.lessThanOrEqualTo(self.imageView.snp.right).offset(-8)
            make.bottom.equalTo(self.detailsView.snp.top).offset(-8)
            make.height.greaterThanOrEqualTo(36)
        }
        
        self.writtenByLabel.snp.makeConstraints { make in
            make.top.equalTo(self.writtenByView.snp.top).offset(4)
            make.left.equalTo(self.writtenByView.snp.left).offset(8)
            make.right.equalTo(self.writtenByView.snp.right).offset(-8)
            make.bottom.equalTo(self.writtenByView.snp.bottom).offset(-4)
        }
        
        self.categoryView.snp.makeConstraints { make in
            make.left.equalTo(self.imageView.snp.left).offset(16)
            make.bottom.equalTo(self.writtenByView.snp.top).offset(-16)
            make.height.equalTo(36)
        }
        
        self.categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.categoryView.snp.top)
            make.left.equalTo(self.categoryView.snp.left).offset(8)
            make.right.equalTo(self.categoryView.snp.right).offset(-8)
            make.bottom.equalTo(self.categoryView.snp.bottom)
        }
        
        self.backView.layer.cornerRadius = 10
        self.backView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left).offset(24)
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(24)
            make.width.height.equalTo(40)
        }
        
        self.backButton.snp.makeConstraints { make in
            make.center.equalTo(self.backView.snp.center)
            make.height.width.equalTo(24)
        }
        
        self.saveView.layer.cornerRadius = 10
        self.saveView.snp.makeConstraints { make in
            make.right.equalTo(self.shareView.snp.left).offset(-16)
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(24)
            make.width.height.equalTo(40)
        }
        
//        self.saveView.addSubview(saveAnimation)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(self.saveView.snp.top)
            make.left.equalTo(self.saveView.snp.left)
            make.right.equalTo(self.saveView.snp.right)
            make.bottom.equalTo(self.saveView.snp.bottom)
//            make.center.equalTo(self.saveView.snp.center)
//            make.height.width.equalTo(24)
        }
        
        self.shareView.layer.cornerRadius = 10
        self.shareView.snp.makeConstraints { make in
            make.right.equalTo(self.contentView.snp.right).offset(-24)
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(24)
            make.width.height.equalTo(40)
        }
        
        self.shareButton.snp.makeConstraints { make in
            make.center.equalTo(self.shareView.snp.center)
            make.height.width.equalTo(24)
        }
        
        self.detailsView.clipsToBounds = true
        self.detailsView.layer.cornerRadius = 28
        self.detailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.detailsView.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.top.equalTo(self.imageView.snp.bottom).offset(-32)
        }
        
        self.aboutText.snp.makeConstraints { make in
            make.left.equalTo(self.detailsView.snp.left).offset(16)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(24)
        }
        
        self.aboutLabel.snp.makeConstraints { make in
            make.top.equalTo(self.aboutText.snp.bottom).offset(24)
            make.left.equalTo(self.aboutText.snp.left)
            make.right.equalTo(self.detailsView.snp.right).offset(-16)
        }
        
        self.webLabel.snp.makeConstraints { make in
            make.top.equalTo(self.aboutLabel.snp.bottom).offset(16)
            make.right.equalTo(self.detailsView.snp.right).offset(-16)
        }
    }
}
