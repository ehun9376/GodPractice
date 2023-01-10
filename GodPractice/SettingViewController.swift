//
//  SettingViewController.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/23.
//

import Foundation
import UIKit
import StoreKit

class SettingViewController: BaseTableViewController {
    
    var rowModels: [CellRowModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.regisCellID(cellIDs: [
            "SettingCell",
            "TagCell"
        ])

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupRowModel()
    }
    
    func setupRowModel() {
        
//        let buyedIDs = UserInfoCenter.shared.loadValue(.iaped) as? [String] ?? []
        
        var currentType: ProductID = .woodFish
        
        if let current = UserInfoCenter.shared.loadValue(.current) as? String {
            let types: [ProductID] = [.woodFish,.gong,.inSin,.ring,.drum]
            
            if let type = types.first(where: {$0.text == current}) {
                currentType = type
            }
        } else {
            currentType = .woodFish
        }
            
        self.rowModels.removeAll()
        
        let typeRow = SettingCellRowModel(title: "選擇道具",
                                          detail: currentType.text,
                                          imageName: currentType.soundName,
                                          imageTintColor: .red,
                                          showSwitch: false,
                                          switchON: false,
                                          switchAction: nil,
                                          cellDidSelect: { [weak self] rowModel in
            
            self?.pushToSelectVC(title: "選擇道具",
                                 dataSource: CodeModel.items,
                                 seletedModel: CodeModel.items.filter({$0.text ?? "" == currentType.text}),
                                 confirmAction: { codeModels in
                
                if let codeModel = codeModels.first {
                    UserInfoCenter.shared.storeValue(.current, data: codeModel.text ?? "")
                    self?.setupRowModel()
                }
            })
        })
        
        self.rowModels.append(typeRow)
        
        let reStoreRow = SettingCellRowModel(title: "恢復購買",
                                             detail: "",
                                             systemImageName: "bag",
                                             imageTintColor: .red,
                                             showSwitch: false,
                                             switchON: false,
                                             switchAction: nil,
                                             cellDidSelect: { [weak self] rowModel in
            IAPCenter.shared.storeComplete = {
                self?.showToast(message: "您的購買項目已恢復")
                self?.setupRowModel()
            }
        })
        
        self.rowModels.append(reStoreRow)
        
        
        
        
        self.adapter?.updateTableViewData(rowModels: self.rowModels)
    }

    
    func pushToSelectVC(title: String,dataSource: [CodeModel], seletedModel: [CodeModel], confirmAction:(([CodeModel])->())?) {
        let vc = SelectViewController()
        vc.navigationtitle = title
        vc.dataSourceModels = dataSource
        vc.selectedModels = seletedModel
        vc.confirmAction = confirmAction
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
}
