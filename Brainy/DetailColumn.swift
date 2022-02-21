//
//  DetailColumn.swift
//  Brainy
//
//  Created by George Mapaya on 2022-02-21.
//

import SwiftUI

struct DetailColumn: View {
    var text: String
    var secondaryText: String
    var trailing: Bool = false
    
    var body: some View {
        VStack(alignment: trailing ? .trailing : .leading) {
            Text(text.uppercased())
                .font(.subheadline.weight(.light))
            Text(secondaryText.uppercased())
                .font(.title.bold())
        } //vstack
    }
}

struct DetailColumn_Previews: PreviewProvider {
    static var previews: some View {
        DetailColumn(text: "Computer Move:", secondaryText: "rock")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
