//
//  CheckMarkPopoverView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/28/22.
//

import SwiftUI

struct CheckMarkPopoverView: View {
    var body: some View {
       Image(systemName: "checkmark")
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10,style: .continuous))
    }
}

struct CheckMarkPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        CheckMarkPopoverView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.blue)
    }
}
