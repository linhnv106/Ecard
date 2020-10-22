//
//  TabBarItemView.swift
//  BinaryNews
//
//  Created by LinhNguyen on 8/31/20.
//  Copyright © 2020 BinaryFuel. All rights reserved.
//

import Foundation
import UIKit
import ESTabBarController_swift
class TabBarItemView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .lightGray
        highlightTextColor = .orange
        iconColor = .lightGray
        highlightIconColor = .orange
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
