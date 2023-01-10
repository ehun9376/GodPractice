//
//  CodeModel.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/23.
//

import Foundation

class CodeModel: Equatable {
    public static func == (lhs: CodeModel, rhs: CodeModel) -> Bool {
        return lhs.text == rhs.text
        && lhs.text == rhs.text
    }
    
    var text: String?
    
    var number: Int?
    
    init(text: String? = nil, number: Int? = nil) {
        self.text = text
        self.number = number
    }
    
    
    static let woodFish: CodeModel = .init(text: ProductID.woodFish.text, number: 0)
    
    static let drum: CodeModel = .init(text: ProductID.drum.text, number: 1)
    
    static let ring: CodeModel = .init(text: ProductID.ring.text, number: 2)
    
    static let inSin: CodeModel = .init(text: ProductID.inSin.text, number: 3)
    
    static let gong: CodeModel = .init(text: ProductID.gong.text, number: 4)

    static let items: [CodeModel] = [
        .woodFish,
        .drum,
        .ring,
        .inSin,
        .gong
    ]
    
}
