# ATRefreshControl

[![N|Solid](https://i.imgur.com/sdxV5Yq.gif)](https://i.imgur.com/sdxV5Yq.gif)

A custom UIRefreshControl written in Swift with gradient animation.

Exemple:
```sh
import UIKit

class ViewController: UIViewController {

@IBOutlet fileprivate weak var tableview: UITableView!
fileprivate lazy var refresh 	= ATRefreshControl()

override func viewDidLoad() {
super.viewDidLoad()
tableview.delegate = self
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
/*
your implementation here
*/
}
```

### Installation
Just drag and drop ATRefreshControl.swift file in your project.

### Todos

- Add beginRefreshing(), endRefreshing()
- Add custom animation while scroll

License
----
MIT


