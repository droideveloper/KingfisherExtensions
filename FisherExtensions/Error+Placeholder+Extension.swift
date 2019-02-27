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
	
	// base load func
	private func load(_ url: URL,
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
