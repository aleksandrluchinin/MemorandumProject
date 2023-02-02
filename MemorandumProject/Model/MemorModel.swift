//
//  MemorModel.swift
//  MemorandumProject
//
//  Created by Aleksandr  on 26.01.2023.
//

import Foundation

protocol MemorandumProtocol {
    
    var title: String { get set }
    var textMemor: String { get set }
}

struct MemorStruct: MemorandumProtocol {
    var title: String
    var textMemor: String
}

