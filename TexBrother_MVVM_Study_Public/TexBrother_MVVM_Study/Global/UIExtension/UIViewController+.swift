//
//  UIViewController+.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit

import RxSwift
import SnapKit
import Then

// MARK: - UIViewController Extension

extension UIViewController {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIViewController {
    /// 🍞
    /// - Parameters:
    ///   - message: 메세지
    ///   - icon: 아이콘 에셋 이름
    ///   - isBottom: 토스트 메세지가 어디에 붙는지 지정을 해줍니다. ( true: top / false: bottom)
    ///   - yAnchor: 토스트 메세지가 safeArea로부터 얼마나 떨어져있을지 설정해줍니다.
    ///   - textColor: text color
    ///   - textFont: text font
    ///   - backgroundColor: background color
    ///   - backgroundRadius: 테두리의 radius
    ///   - duration: 지속 시간을 지정해줍니다.
    
    func showGreenToast(_ message: String,
                        icon: String,
                        isBottom: Bool = true,
                        yAnchor: CGFloat = 40.adjusted,
                        textColor: UIColor = .blackBlack,
                        textFont: UIFont = .systemFont(ofSize: 14.adjusted),
                        backgroundColor: UIColor = .modalBackgroundGreen,
                        backgroundRadius: CGFloat = 22.5.adjusted,
                        duration: TimeInterval = 3) {
        
        let label = UILabel().then {
            $0.textColor = textColor
            $0.textAlignment = .center
            $0.font = textFont
            $0.text = message
            $0.clipsToBounds = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let backgroundView = UIView().then {
            $0.backgroundColor = backgroundColor
            $0.setRounded(radius: backgroundRadius)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let iconImage = UIImageView().then {
            $0.image = UIImage(named: icon)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
        self.view.adds([backgroundView, iconImage, label])
        
        backgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(29.adjusted)
            $0.height.equalTo(45.adjusted)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-40.adjusted)
        }
        
        iconImage.snp.makeConstraints {
            $0.centerY.equalTo(backgroundView)
            $0.leading.equalTo(backgroundView).offset(12.adjusted)
            $0.width.height.equalTo(45.adjusted)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalTo(backgroundView)
            $0.leading.equalTo(iconImage.snp.trailing)
        }
        
        UIView.animate(withDuration: 1, delay: 2, options: .curveEaseOut, animations: {
            label.alpha = 0.0
            iconImage.alpha = 0.0
            backgroundView.alpha = 0.0
        }, completion: { _ in
            label.removeFromSuperview()
            iconImage.removeFromSuperview()
            backgroundView.removeFromSuperview()
        })
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setTabBarHidden(
        _ hidden: Bool,
        animated: Bool = true,
        duration: TimeInterval = 0.3) {
            
            if self.tabBarController?.tabBar.isHidden != hidden {
                if animated {
                    /// Show the tabbar before the animation in case it has to appear
                    if (self.tabBarController?.tabBar.isHidden)! {
                        self.tabBarController?.tabBar.isHidden = hidden
                    }
                    
                    if let frame = self.tabBarController?.tabBar.frame {
                        let factor: CGFloat = hidden ? 1 : 0
                        let y = frame.origin.y + (frame.size.height * factor)
                        
                        UIView.animate(withDuration: duration, animations: {
                            self.tabBarController?.tabBar.frame =
                            CGRect( x: frame.origin.x,
                                    y: y,
                                    width: frame.width,
                                    height: frame.height)
                        }) { (bool) in
                            /// hide the tabbar after the animation in case ti has to be hidden
                            if (!(self.tabBarController?.tabBar.isHidden)!) {
                                self.tabBarController?.tabBar.isHidden = hidden
                            }
                        }
                    }
                }
            }
        }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: false)
    }
}

