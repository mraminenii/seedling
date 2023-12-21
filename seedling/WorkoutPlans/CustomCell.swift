//
//  CustomCell.swift
//  Seedling
//
//  Created by Brian Q on 11/30/22.
//

import Foundation
import SwiftUI

struct CustomCell: View {
    
    @Binding var itemName: String
    
    var body: some View {
        HStack {
//            TextField("Workout Name", text: $itemName)
            Text(itemName)
            
        }
    }
}
