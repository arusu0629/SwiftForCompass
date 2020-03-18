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
            // Pull To Refresh
            tableViewPullToRefreshControl.addTarget(self, action: #selector(TopViewController.refresh(sender:)), for: .valueChanged)
            eventTableView.refreshControl = tableViewPullToRefreshControl
        }
    }
    
    var eventList = [Event]()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        self.title = navigationTitle
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        // TODO: TextFieldに入力されている文字
        output.refreshEventList(keyword: nil)
    }

    // MARK: TopViewInput
    func setupInitialState() {
    }
    
    func reloadDataWithEvents(events: [Event]) {
        self.eventList = events
        self.eventTableView.reloadData()
        tableViewPullToRefreshControl.endRefreshing()
    }
}

extension TopViewController: UITableViewDelegate {
    // Cell間に設けたい余白の高さを指定
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
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
