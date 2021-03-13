//
//  ProgressRingSampleView.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 12/08/20.
//

import SwiftUI
import SUITcase

struct ProgressRingSampleView: View {
    @State private var progress: CGFloat = 0.5
    @State private var animatedProgress: CGFloat = 0.0
    @State private var stopProgress = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                Group {
                    SectionHeaderView(name: "Static Progreess Ring")
                    ProgressRingView(progress: self.$progress)
                        .showProgress(label: self.progress)
                        .padding()
                    Divider()
                }
                Group {
                    SectionHeaderView(name: "Refreshable Progress Ring",
                                      withButton: true,
                                      buttonSymbolName: "icloud.and.arrow.down",
                                      action: {
                                        self.animatedProgress = 0.0
                                        withAnimation(.easeInOut(duration: 1)) {
                                            self.startFakeDownload()
                                        }
                    })
                    ProgressRingView(progress: self.$animatedProgress,
                                     progressColor: .green)
                        .showProgress(label: self.animatedProgress)
                        .padding()
                    Divider()
                }
            }
        }
    }
    
    func startFakeDownload() {
        self.animatedProgress = 0.9
    }
}

struct ProgressRingSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingSampleView()
    }
}
