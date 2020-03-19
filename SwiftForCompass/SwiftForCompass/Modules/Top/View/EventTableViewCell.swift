//
//  EventTableViewCell.swift
//  SwiftForCompass
//
//  Created by Toru Nakandakari on 2020/03/16.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    static let Identifier = "EventTableViewCell"
    
    @IBOutlet weak var eventStartAtLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    private var event: Event!
    private var onTappedEventDetailAction: ((Event) -> Void)!
    private var onTappedEventLocationAction: ((Event) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(event: Event, onTappedDetailAction: @escaping ((Event) -> Void), onTappedLocationAction: @escaping ((Event) -> Void)) {
        self.event = event
        self.onTappedEventDetailAction = onTappedDetailAction
        self.onTappedEventLocationAction = onTappedLocationAction
        eventTitleLabel.text = event.title
        eventLocationLabel.text = event.address
    }

    
    @IBAction func onTappedEventDetail(_ sender: Any) {
        print("onTappedEventDetail")
        onTappedEventDetailAction(event)
    }
    
    @IBAction func onTapeedEventLocation(_ sender: Any) {
        print("onTapeedEventLocation")
        onTappedEventLocationAction(event)
    }
    
}
