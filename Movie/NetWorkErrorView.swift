//
//  NetWorkErrorView.swift
//  Movie
//
//  Created by kathy yin on 4/2/17.
//  Copyright © 2017 kathy. All rights reserved.
//

import UIKit

class NetWorkErrorView: UIView {

    @IBOutlet weak var errorIconView: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView() {
        let image = UIImage(named: "ic_error")?.withRenderingMode(.alwaysTemplate)
        let nib = UINib(nibName: "NetWorkErrorView", bundle: nil)
        let content: UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        content.frame = self.bounds
        self.errorIconView.image = image
        self.errorIconView.tintColor = .white
        addSubview(content)
       
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
