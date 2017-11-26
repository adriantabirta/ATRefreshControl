//
//  ViewController.swift
//  CustomRefreshControl
//
//  Created by Adrian Tabirta on 25.11.2017.
//  Copyright © 2017 Adrian Tabirta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet fileprivate weak var tableview: UITableView!
	fileprivate lazy var refresh 	= ATRefreshControl()
	fileprivate var array 			= ["one", "two", "three", "four",]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableview.addSubview(refresh)
	}
}

extension ViewController: UIScrollViewDelegate {
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		refresh.containingScrollViewDidEndDragging(scrollView)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		refresh.didScroll(scrollView)
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return array.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell 				= UITableViewCell()
		cell.textLabel?.text 	= array[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200
	}
}

