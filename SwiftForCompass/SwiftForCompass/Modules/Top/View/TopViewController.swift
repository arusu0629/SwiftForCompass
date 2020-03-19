//
//  TopTopViewController.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, TopViewInput {
    
    let navigationTitle = "イベント"
    let tableViewPullToRefreshControl = UIRefreshControl()

    var output: TopViewOutput!
    @IBOutlet weak var eventTableView: UITableView! {
        didSet {
            eventTableView.separatorStyle = .none
            eventTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: EventTableViewCell.Identifier)
            eventTableView.refreshControl = tableViewPullToRefreshControl
        }
    }
    @IBOutlet weak var eventSearchTextField: UITextField! {
        didSet {
            eventSearchTextField.setIcon(UIImage(systemName: "magnifyingglass")!)
        }
    }
    
    @IBOutlet weak var fetchActivityIndicatorView:
        UIActivityIndicatorView! {
        didSet {
            self.fetchActivityIndicatorView.hidesWhenStopped = true
            self.fetchActivityIndicatorView.style = .medium
        }
    }
    
    var eventList = [Event]()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navigationTitle
        self.fetchActivityIndicatorView.center = self.view.center
        output.viewIsReady()
    }
    
    // Pull To Refresh
    func pullToRefresh() {
        output.eventListTableViewPullToRefresh()
    }
    
    // ナビゲーションバーの更新ボタンを押した時
    @IBAction func onTappedRefreshButton(_ sender: Any) {
        output.onTappedRefreshButton()
    }

    // MARK: TopViewInput
    func setupInitialState() {
    }
    
    func showLoading() {
        fetchActivityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        fetchActivityIndicatorView.stopAnimating()
    }
    
    func reloadDataWithEvents(events: [Event]) {
        self.eventList = events
        self.eventTableView.reloadData()
        tableViewPullToRefreshControl.endRefreshing()
    }
}

extension TopViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        output.eventSearchTextFieldReturn(searchWord: textField.text ?? "")
        eventSearchTextField.resignFirstResponder()
        return true
    }
}

extension TopViewController: UITableViewDelegate {
    // Cell間に設けたい余白の高さを指定
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentSizeY = scrollView.contentSize.height
        let distanceToBottom = contentSizeY - (scrollView.contentOffset.y + scrollView.frame.height)
        
        if distanceToBottom < 200 {
            output.eventListTablelViewDidBottom()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Pull To Refresh で指で引っ張って離した時に発火を行うようにする
        if self.tableViewPullToRefreshControl.isRefreshing {
            self.pullToRefresh()
        }
    }
}

extension TopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.Identifier, for: indexPath) as! EventTableViewCell
        cell.setup(event: self.eventList[indexPath.section])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.eventList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
