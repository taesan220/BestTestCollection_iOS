//
//  ListModel.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/20.
//

import Foundation

/**
 서브 카테고리 구조
 */
struct SubCategory {
    let categorySequence: Int
    let titleName: String
    let listModel: ListModel
}

/**
 리스트 구조
 */
struct ListModel {
    let listSequence: Int
    let storyboardName: String
    let viewControllers: [ListViewControllers]
}

/**
 뷰컨트롤러 모음 구조
 */
struct ListViewControllers {
    let subViewControllerName: String
    let subViewControllerIdentifier: String
}
