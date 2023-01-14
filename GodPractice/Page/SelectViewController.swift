//
//  SelectViewController.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/23.
//

import Foundation
import UIKit

class SelectViewController: BaseTableViewController {
    
    var navigationtitle: String = ""
    
    var selectedModels: [CodeModel] = []
    
    var dataSourceModels: [CodeModel] = []
    
    var confirmAction: (([CodeModel])->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.regisCellID(cellIDs: [
            "SettingCell"
        ])
        self.setupRow()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupRow() {
        var rowModels: [CellRowModel] = []
        for model in dataSourceModels {
            
            let isSelected: Bool = self.selectedModels.contains(model)
            
            rowModels.append(SettingCellRowModel(title: model.text,
                                                 detail: nil,
                                                 imageName: isSelected ? "CircleCheckMark" : "",
                                                 imageTintColor: .red ,
                                                 showSwitch: false,
                                                 switchON: false,
                                                 switchAction: nil,
                                                 cellDidSelect: { [weak self] _ in
                
                if model.data == .woodFish {
                    self?.selectedModels = [model]
                    self?.setupRow()
                } else {
                    
                    if let iaped = UserInfoCenter.shared.loadValue(.iaped) as? [String], iaped.contains(model.data.id) {
                        self?.selectedModels = [model]
                        self?.setupRow()
                    } else {
                        self?.showAlert(title: "提示",
                                        message: "目前未開放購買，要購買才可以用喔\n\(model.data.id)",
                                        confirmTitle: "前往購買",
                                        cancelTitle: "取消",
                                        confirmAction: {
                            if let product = IAPCenter.shared.products.first(where: {$0.productIdentifier == model.data.id}) {
                                IAPCenter.shared.buy(product: product)
                            }
                           
                        },
                                        cancelAction: {
                            
                        })
                    }
                }

                


            }))
        }
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }   
    
    override func setBottomButtons() -> [BottomBarButton] {
        
        let confirmButton: BottomBarButton = .createButtonModel(title: .confirm,
                                                                textColor: .red,
                                                                backgroundColor: .white,
                                                                borderColor: .red) {
            if let confirmAction = self.confirmAction{
                confirmAction(self.selectedModels)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        return [confirmButton]
    }
    
}
