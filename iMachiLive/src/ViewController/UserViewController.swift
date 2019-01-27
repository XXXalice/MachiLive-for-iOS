//
//  LoginView.swift
//  iMachiLive
//
//  Created by RIVER on 2019/01/18.
//  Copyright © 2019 Reverse. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    /** ----------------------------------------------------------------------
     # sharedInstance
     ---------------------------------------------------------------------- **/
    // Model
    var userData = UserData.sharedInstance
    // NotificationCenter
    let notification = NotificationCenter.default
    
    /** ----------------------------------------------------------------------
     UI settings
     ---------------------------------------------------------------------- **/
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUserView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let menuPos = self.menuView.layer.position
        self.menuView.layer.position.x = -self.menuView.frame.width
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.menuView.layer.position.x = menuPos.x
            },
            completion: {
                bool in
            }
        )
    }
    
    func setupUserView() {
        if let currentUser = userData.authUI.auth?.currentUser {
            // アイコンの表示
            let avatarUrl = currentUser.photoURL
            do {
                let data = try Data(contentsOf: avatarUrl!)
                let image = UIImage(data: data)
                avatarImageView.image = image
            }catch let err {
                print("Error : \(err.localizedDescription)")
            }
            // ユーザ名の取得
            let userName = currentUser.displayName
            usernameLabel.text = userName
            
        }
    }
    
    func doLogout() {
        do {
            try userData.authUI.signOut()
            notification.post(name: .LogOut, object: nil)
        } catch let err as NSError {
            print ("Error signing out: %@", err)
        }
    }
    
    
    /** ----------------------------------------------------------------------
     UI actions
     ---------------------------------------------------------------------- **/
    @IBAction func tapLogout(_ sender: UIButton) {
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) in
            
        })
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) in
            
            self.doLogout()
        })
        let alert = UIAlertController(title: "ログアウト",
                                      message: "ログイン画面に戻ってよろしいですか？",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    // エリア外のタップをした際の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.menuView.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
            }
        }
    }

}