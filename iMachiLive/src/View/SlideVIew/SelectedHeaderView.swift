//
//  SelectedView.swift
//  SlideUpViewAnimation
//
//  Created by RIVER on 2019/02/05.
//  Copyright © 2019 Reverse. All rights reserved.
//

import UIKit

class SelectedHeaderView: UIView {


    @IBOutlet weak var locationnameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // コードから初期化
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    // Storyboardから初期化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib(){
        let view = Bundle.main.loadNibNamed("SelectedHeaderView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    @IBAction func tapEditButton(_ sender: UIButton) {
    }
    @IBAction func tapShareButton(_ sender: UIButton) {
    }
    @IBAction func tapCancelButton(_ sender: UIButton) {
    }
    
}