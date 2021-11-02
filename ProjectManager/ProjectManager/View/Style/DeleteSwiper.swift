//
//  DeleteSwiper.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/03.
//

import SwiftUI

struct DeleteSwiper: ViewModifier {
    @State private var offset: CGFloat = .zero
    @State private var isVisible = false
    private let minimumTrailingSize = UIStyle.buttonWidth

    let delete: () -> Void

    init(delete: @escaping () -> Void) {
        self.delete = delete
    }

    func reset() {
        isVisible = false
        offset = .zero
    }

    func body(content: Content) -> some View {
        let distanceForDrag: CGFloat = 15
        return ZStack {
            content
                .contentShape(Rectangle())
                .offset(x: offset)
                .gesture(
                    DragGesture(minimumDistance: distanceForDrag, coordinateSpace: .local)
                        .onChanged { gesture in
                            withAnimation {
                                offset = gesture.translation.width
                            }
                        }
                        .onEnded { gesture in
                            withAnimation {
                                let distance = gesture.translation.width
                                switch true {
                                case distance < -(distanceForDrag * 15):
                                    delete()
                                case isVisible == true && distance < -(distanceForDrag + 5):
                                    reset()
                                case offset < -(distanceForDrag + 10):
                                    isVisible = true
                                    offset = -minimumTrailingSize
                                default:
                                    reset()
                                }
                            }
                        }
                )

            GeometryReader { proxy in
                HStack(spacing: .zero) {
                    Spacer()

                    Button {
                        withAnimation {
                            reset()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                            withAnimation {
                                delete()
                            }
                        }
                    } label: {
                        DeleteButton(cellHeight: proxy.size.height)
                    }
                    .offset(x: offset + UIStyle.buttonWidth)
                }
            }
        }
    }

    struct DeleteButton: View {
        let cellHeight: CGFloat

        var body: some View {
            Text("DELETE")
                .padding(UIStyle.minInsetAmount)
                .font(.footnote)
                .foregroundColor(.white)
                .frame(width: UIStyle.buttonWidth, height: cellHeight)
                .backgroundColor(.red)
        }
    }
}
