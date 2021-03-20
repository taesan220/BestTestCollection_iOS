//
//  CategoryData.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/20.
//

import Foundation


let TITLE_NAME: String = "title"
let SUB_KEY: String = "sub_key"
let SEQUENCE = "sequence"


let category = [SubCategory.init(categorySequence: 1, titleName: "UIView", listModel: uiViewListData),
                SubCategory.init(categorySequence: 2, titleName: "Alert & Toast", listModel: alertToastListData),
                SubCategory.init(categorySequence: 3, titleName: "TableView", listModel: tableViewListData),
                SubCategory.init(categorySequence: 4, titleName: "Component", listModel: componentListData),
                SubCategory.init(categorySequence: 5, titleName: "WebView", listModel: webviewListData),
                SubCategory.init(categorySequence: 6, titleName: "DataBase", listModel: dataBaseListData),
                SubCategory.init(categorySequence: 7, titleName: "Graphic", listModel: graphicListData),
                SubCategory.init(categorySequence: 8, titleName: "API Connection", listModel: apiConnectionListData),
                SubCategory.init(categorySequence: 9, titleName: "3Party Connection", listModel: thirdPartyConnectionListData),

]

//MARK: - 1. UIView List

let uiViewListData = ListModel.init(listSequence: 1, listName: "Custom Indicator", storyboardName: "UIView", viewControllers: [customIndicatorVC])

//MARK: - 2. Alert & Toast List
let alertToastListData = ListModel.init(listSequence: 2, listName: "Custom Alert", storyboardName: "AlertandToast", viewControllers: [customAlertVC])


//MARK: - 3. TableView List
let tableViewListData = ListModel.init(listSequence: 3, listName: "Component", storyboardName: "Component", viewControllers: [customButtonVC])


//MARK: - 4. Component List
let componentListData = ListModel.init(listSequence: 4, listName: "Custom Button", storyboardName: "Component", viewControllers: [customButtonVC])


//MARK: - 5. WebView List
let webviewListData = ListModel.init(listSequence: 5, listName: "Component", storyboardName: "Component", viewControllers: [customButtonVC])


//MARK: - 6. DataBase List
let dataBaseListData = ListModel.init(listSequence: 6, listName: "Component", storyboardName: "Component", viewControllers: [customButtonVC])


//MARK: - 7. Graphic List
let graphicListData = ListModel.init(listSequence: 7, listName: "Draw Text", storyboardName: "Graphic", viewControllers: [drawTextVC])



//MARK: - 8. Api Connection List
let apiConnectionListData = ListModel.init(listSequence: 8, listName: "Component", storyboardName: "Component", viewControllers: [customButtonVC])


//MARK: - 9. Third Party Connection List
let thirdPartyConnectionListData = ListModel.init(listSequence: 8, listName: "Component", storyboardName: "Component", viewControllers: [customButtonVC])
