//
//  ATRefreshControl.swift
//  CustomRefreshControl
//
//  Created by Adrian Tabirta on 25.11.2017.
//  Copyright © 2017 Adrian Tabirta. All rights reserved.
//

import UIKit

final class ATRefreshControl: UIControl {
	
	fileprivate let gradientOne 	=  UIColor(red: 48/255, green: 62/255, blue: 103/255, alpha: 1).cgColor
	fileprivate let gradientTwo 	=  UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1).cgColor
	fileprivate let gradientThree 	=  UIColor(red: 196/255, green: 70/255, blue: 107/255, alpha: 1).cgColor
	
	fileprivate lazy var gradientSet: [[CGColor]] = {
		var set = [[CGColor]]()
		set.append([gradientOne, gradientTwo])
		set.append([gradientTwo, gradientThree])
		set.append([gradientThree, gradientOne])
		return set
	}()
	
	fileprivate lazy var colorGradient: CAGradientLayer = {
		var gradient 			= CAGradientLayer()
		gradient.colors 		= gradientSet[1]
		gradient.locations		= [0.25, 0.50, 0.75]
		gradient.startPoint 	= CGPoint(x:0, y:0)
		gradient.endPoint 		= CGPoint(x:0, y:1)
		gradient.drawsAsynchronously = true
		return gradient
	}()
	
	fileprivate lazy var gradientAnimation: CABasicAnimation = {
		let animation = CABasicAnimation(keyPath: "colors")
		animation.duration 		= 0.3
		animation.repeatCount 	= Float.infinity
		animation.autoreverses 	= true
		animation.toValue 		= gradientSet[0]
		animation.fillMode 		= kCAFillModeForwards
		animation.isRemovedOnCompletion = false
		return animation
	}()
	
	fileprivate lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: 50)
		label.text = "Release it"
		label.textAlignment	= .center
		label.textColor = .white
		return label
	}()
	
	fileprivate var isChanged = false {
		didSet{
			switch self.isChanged {
			case true:
				titleLabel.text 	= "Refreshing..."
				startLayerAnimation()
				
			case false:
				self.titleLabel.text = "Release it"
				stopLayerAnimation()
			}
		}
	}
	
	convenience init() {
		self.init(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 200))
		self.addTarget(self, action: #selector(changeState), for: .valueChanged)
		colorGradient.frame = self.bounds
		layer.addSublayer(colorGradient)
		addSubview(titleLabel)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	@objc func changeState() {
		isChanged = !isChanged
		DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
			self.isChanged = false
		}
	}
	
	func containingScrollViewDidEndDragging(_ scrollView: UIScrollView) {
		if scrollView.contentOffset.y <= -80 {
			self.sendActions(for: .valueChanged)
		}
	}
	
	func didScroll(_ scrollView: UIScrollView) {
		guard scrollView.contentOffset.y >= -100, isChanged else { return }
		scrollView.contentOffset.y = -80
	}
	
	private func startLayerAnimation() {
		colorGradient.add(gradientAnimation, forKey: "colorChange")
	}
	
	private func stopLayerAnimation() {
		colorGradient.removeAnimation(forKey: "colorChange")
	}

}

extension ATRefreshControl {
	
	func beingRefreshing(in scrollView: UIScrollView) {
		UIView.animate(withDuration: 0.33) {
			scrollView.contentOffset.y = -110
		}
		// scrollView.contentOffset.y = -80
		// scrollView.scrollRectToVisible(scrollView.frame.offsetBy(dx: 0, dy: -100), animated: true)
	}
	
	func endRefreshing(in scrollView: UIScrollView) {
		scrollView.scrollRectToVisible(scrollView.frame, animated: true)
	}

}



/*
func animateGradient() {
	if currentGradient < gradientSet.count - 1 {
		currentGradient += 1
	} else {
		currentGradient = 0
	}
	
	
}

func stopAnimate() {
}

func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
	if flag {
		gradient.colors = gradientSet[currentGradient]
		animateGradient()
	}
}

*/

/*
class ViewController: UIViewController {
	
	let gradient = CAGradientLayer()
	var gradientSet = [[CGColor]]()
	var currentGradient: Int = 0
	
	let gradientOne = UIColor(red: 48/255, green: 62/255, blue: 103/255, alpha: 1).cgColor
	let gradientTwo = UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1).cgColor
	let gradientThree = UIColor(red: 196/255, green: 70/255, blue: 107/255, alpha: 1).cgColor
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		gradientSet.append([gradientOne, gradientTwo])
		gradientSet.append([gradientTwo, gradientThree])
		gradientSet.append([gradientThree, gradientOne])
		
		
		gradient.frame = self.view.bounds
		gradient.colors = gradientSet[currentGradient]
		gradient.startPoint = CGPoint(x:0, y:0)
		gradient.endPoint = CGPoint(x:1, y:1)
		gradient.drawsAsynchronously = true
		self.view.layer.addSublayer(gradient)
		
		animateGradient()
		
	}
	
	func animateGradient() {
		if currentGradient < gradientSet.count - 1 {
			currentGradient += 1
		} else {
			currentGradient = 0
		}
		
		let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
		gradientChangeAnimation.duration = 5.0
		gradientChangeAnimation.toValue = gradientSet[currentGradient]
		gradientChangeAnimation.fillMode = kCAFillModeForwards
		gradientChangeAnimation.isRemovedOnCompletion = false
		gradient.add(gradientChangeAnimation, forKey: "colorChange")
	}
	
}

extension ViewController: CAAnimationDelegate {
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		if flag {
			gradient.colors = gradientSet[currentGradient]
			animateGradient()
		}
	}
}

*/


//		if scrollView.contentOffset.y <= -80 {
//			self.sendActions(for: .valueChanged)
//		}
