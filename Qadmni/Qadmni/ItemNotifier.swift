//
//  ItemNotifier.swift
//  Qadmni
//
//  Created by Prakash Sabale on 25/03/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
public class ItemNotifier
{
    private var itemNotifier : ItemNotifier = ItemNotifier()
    public func getNotification() -> ItemNotifier
    {
    return itemNotifier
    }
    public func setNotification(itemNotifier : ItemNotifier)
    {
        self.itemNotifier = itemNotifier
    }
}
