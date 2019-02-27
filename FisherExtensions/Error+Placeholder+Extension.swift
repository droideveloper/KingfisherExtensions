//
//  Error+Placeholder+Extension.swift
//  FisherExtensions
//
//  Created by Fatih Şen on 27.02.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
	
	public func circular(_ url: URL) {
		let r = self.bounds.width / 2
		let x = self.bounds.height / 2
		if x != r {
			// we do inform them and do the operation regardless of it
			print("are you sure you want to convert it into circular image since your image is width: \(r * 2) height: \(x * 2)")
		}
		// if image is not square then we should say ops
		roundedRect(url, r)
	}
	
	public func roundedRect(_ url: URL, _ r: CGFloat) {
		var options = defaultOptions
		
		let processors = DownsamplingImageProcessor(size: self.bounds.size)
				>> RoundCornerImageProcessor(cornerRadius: r)
		
		options.append(.processor(processors))
		// now do call it
		load(url, options: options)
	}
	
	// base load func
	public func load(_ url: URL,
										placeholder: String = defaultPlaceholder,
										errorPlaceholder: String = defaultErrorPlaceholder,
										options: KingfisherOptionsInfo = defaultOptions) {
		// load place holder
		let p = UIImage(named: placeholder)
		// error place holder
		let e = UIImage(named: errorPlaceholder)
		// load image now
		self.kf.setImage(with: url, placeholder: p, options: options) { response in
			switch response {
				case .success:
					// no opt
					break
				case .failure:
					// bind error image if there is one provided
					self.image = e
					break
			}
		}
	}
}

public let defaultOptions: KingfisherOptionsInfo = [
	.scaleFactor(UIScreen.main.scale),
	.transition(.none),
	.cacheOriginalImage
]

public let defaultPlaceholder = "placeholder"

public let defaultErrorPlaceholder = "errorPlaceholder"
