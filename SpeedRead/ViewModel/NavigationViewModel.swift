//
//  NavigationViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 07.11.2022.
//

import SwiftUI

final class NavigationViewModel: ObservableObject {
    @Published var path = NavigationPath()
    
    func clearPath() {
        path.removeLast(path.count)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    //TODO: InfoPageModel: isConnected, price, isUnlim?, name?
//    func addBalanceInfoPage(of info: InfoPageModel)
    
}
