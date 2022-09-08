//
//  ContentView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/08.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer().frame(width: 10)
                    Text("TODO")
                        .font(.title)
                    ZStack {
                        Circle()
                            .fill(.black)
                            .frame(width: 30, height: 30)
                        Text("1")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
                List {
                    Text(":")
                }
            }
            .background(Color(UIColor.systemGray5))
            Divider()

            VStack(alignment: .leading) {
                HStack {
                    Spacer().frame(width: 10)
                    Text("DOING")
                        .font(.title)
                    ZStack {
                        Circle()
                            .fill(.black)
                            .frame(width: 30, height: 30)
                        Text("1")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
                List {
                    Text(":")
                }
            }
            .background(Color(UIColor.systemGray5))
            Divider()

            VStack(alignment: .leading) {
                HStack {
                    Spacer().frame(width: 10)
                    Text("DONE")
                        .font(.title)
                    ZStack {
                        Circle()
                            .fill(.black)
                            .frame(width: 30, height: 30)
                        Text("1")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
                List {
                    Text(":")
                }
            }
            .background(Color(UIColor.systemGray5))
        }
        .background(Color(UIColor.systemGray3))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
