//
//  TextCircle.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/31.
//

import SwiftUI

struct NumberBall: View {
    var number: Int

    var body: some View {
        Text(number.description)
            .bold()
            .padding(10)
            .foregroundColor(.white)
            .background(
                Circle().foregroundColor(.black)
            )
    }
}

struct TextCircle_Previews: PreviewProvider {
    static var previews: some View {
        NumberBall(number: 100)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
