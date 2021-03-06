//
//  GraphicListData.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/20.
//

import Foundation




//MARK: - 1. UIView List
let customIndicatorVC = ListViewControllers.init(subViewControllerName: "Custom Indicator", subViewControllerIdentifier: "customIndicatorVC")


//MARK: - 2. Alert & Toast List
let customAlertVC = ListViewControllers.init(subViewControllerName: "Custom Alert", subViewControllerIdentifier: "customAlertVC")

//MARK: - 3. TableView List
let expandableTableVC = ListViewControllers.init(subViewControllerName: "Expandable TableView", subViewControllerIdentifier: "expandableTableVC")
let dynamicHeightTableVC = ListViewControllers.init(subViewControllerName: "Dynamic Height TableView", subViewControllerIdentifier: "dynamicHeightTableVC")


//MARK: - 4. Component List
let customButtonVC = ListViewControllers.init(subViewControllerName: "Custom Button", subViewControllerIdentifier: "customButtonVC")
let customTextFieldVC = ListViewControllers.init(subViewControllerName: "Custom TextField", subViewControllerIdentifier: "customTextFieldVC")
let secreetKeyVC = ListViewControllers.init(subViewControllerName: "Screet Key", subViewControllerIdentifier: "secreetKeyVC")

//MARK: - 5. WebView List
let webViewVC = ListViewControllers.init(subViewControllerName: "WebView UserAgent", subViewControllerIdentifier: "webViewVC")

//MARK: - 6. DataBase List
let dataBaseVC = ListViewControllers.init(subViewControllerName: "DataBase", subViewControllerIdentifier: "dataBaseVC")



//MARK: - 7. Graphic List
let drawTextVC = ListViewControllers.init(subViewControllerName: "Draw Text", subViewControllerIdentifier: "drawTextVC")


//MARK: - 8. Api Connection List
let scructBindingVC = ListViewControllers.init(subViewControllerName: "Struct Binding From API Data", subViewControllerIdentifier: "scructBindingVC")
let sendingImageVC = ListViewControllers.init(subViewControllerName: "Sending Image", subViewControllerIdentifier: "sendingImageVC")

//MARK: - 9. Third Party Connection List
let firebaseVC = ListViewControllers.init(subViewControllerName: "Firebase Connection", subViewControllerIdentifier: "firebaseVC")

//MARK: - 10. Conversion Data included Decrypt and Encrypt

let jwtConversionVC = ListViewControllers.init(subViewControllerName: "JWT Conversion", subViewControllerIdentifier: "jwtConversionVC")

let stringToJsonVC = ListViewControllers.init(subViewControllerName: "String to JSON Conversion", subViewControllerIdentifier: "stringToJsonVC")

//MARK: - 11 . Etcetera
let versionCompareVC = ListViewControllers.init(subViewControllerName: "Version Comparison", subViewControllerIdentifier: "versionCompareVC")
