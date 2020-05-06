//
//  HeaderView.swift
//  HeaderScroll
//
//  Created by Michael Nachbaur on 5/4/20.
//  Copyright © 2020 Michael Nachbaur. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    @IBOutlet private(set) var imageView: UIImageView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private var sizeLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView?
    private var cachedMinimumSize: CGSize?
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Debugging label to demonstrate the size of the header view.
        sizeLabel.text = "\(frame.width)x\(frame.height)"
    }

    // Calculate and cache the minimum size the header's constraints will fit.
    // This value is cached since it can be a costly calculation to make, and
    // we want to keep the framerate high.
    private var minimumHeight: CGFloat {
        get {
            guard let scrollView = scrollView else { return 0 }
            if let cachedSize = cachedMinimumSize {
                if cachedSize.width == scrollView.frame.width {
                    return cachedSize.height
                }
            }
         
            // Ask Auto Layout what the minimum height of the header should be.
            let minimumSize = systemLayoutSizeFitting(CGSize(width: scrollView.frame.width, height: 0),
                                                      withHorizontalFittingPriority: .required,
                                                      verticalFittingPriority: .defaultLow)
            cachedMinimumSize = minimumSize
            return minimumSize.height
        }
    }

    func updatePosition() {
        guard let scrollView = scrollView else { return }
        
        // Calculate the minimum size the header's constraints will fit
        let minimumSize = minimumHeight
        
        // Calculate the baseline header height and vertical position
        let referenceOffset = scrollView.safeAreaInsets.top
        let referenceHeight = scrollView.contentInset.top - referenceOffset
        
        // Calculate the new frame size and position
        let offset = referenceHeight + scrollView.contentOffset.y
        let targetHeight = referenceHeight - offset - referenceOffset
        var targetOffset = referenceOffset
        if targetHeight < minimumSize {
            targetOffset += targetHeight - minimumSize
        }
        
        // Update the header's height and vertical position.
        var headerFrame = frame;
        headerFrame.size.height = max(minimumSize, targetHeight)
        headerFrame.origin.y = targetOffset
        
        frame = headerFrame;
    }
}

