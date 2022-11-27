//
//  KeyworkView.swift
//  presentation
//
//  Created by Nihad Ismayilov on 17.09.22.
//

import Foundation
import UIKit

class KeywordView: UIView {
    lazy var backgroundView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.backgroundColor = Asset.Colors.dateColor.color
        
        return view
    }()
    
    lazy var label: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = UIFont(font: FontFamily.NunitoSans.regular, size: 14)
        lbl.textColor = Asset.Colors.textColor.color
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setupUI()
    }
    
    //common func to init our view
    private func setupUI() {
        self.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        self.backgroundView.layer.cornerRadius = 12
        self.backgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        self.label.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundView.snp.top).offset(4)
            make.left.equalTo(self.backgroundView.snp.left).offset(8)
            make.right.equalTo(self.backgroundView.snp.right).offset(-8)
            make.bottom.equalTo(self.backgroundView.snp.bottom).offset(-4)
        }
    }
    
    func setup(word: String) {
        self.label.text = word
        print(self.backgroundView.frame.size.width)
        
    }
}
