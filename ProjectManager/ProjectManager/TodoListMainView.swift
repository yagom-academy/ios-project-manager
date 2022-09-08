//
//  ContentView.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/08.
//

import SwiftUI

struct TodoListMainView: View {
    let titleArray = ["TODO", "DOING", "DONE"]
    var body: some View {
        VStack {
            ProjectTitleView()
            HStack {
                ForEach(titleArray, id: \.self) { title in
                    VStackView(title: title)
                }
            }
            .background(Color(UIColor.systemGray3))
        }
    }

    struct ProjectTitleView: View {
        var body: some View {
            ZStack {
                HStack {
                    Spacer()
                    Text("Project Manager")
                        .font(.title)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {
                        print("+ 눌림")
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .font(.title)
                    .padding(10)
                }
            }
        }
    }

    struct VStackView: View {
        let title: String

        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Spacer().frame(width: 10)
                    Text(title)
                        .font(.largeTitle)
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
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            TodoListMainView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
