//
//  ProgressSampleView.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 06/07/20.
//

import SwiftUI
import SUITcase

struct ProgressSampleView: View {
    @State private var staticProgress: CGFloat = 0.5
    @State private var animatedProgress: CGFloat = 0.0
    @State private var stopProgress = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                Group {
                    SectionHeaderView(name: "Static Progress View")
                    SCProgressview(progress: self.$staticProgress).padding()
                    Divider()
                }
                Group {
                    SectionHeaderView(name: "Refreshable Progress View", withButton: true,
                                      buttonSymbolName: "icloud.and.arrow.down",
                                      action: {
                                        self.animatedProgress = 0.0
                                        withAnimation(.easeInOut(duration: 2)) {
                                            self.startFakeDownload()
                                        }
                    })
                    SCProgressview(progress: self.$animatedProgress).padding()
                    Divider()
                }
                Group {
                    SectionHeaderView(name: "Undetermined Progress View", withButton: true,
                                      buttonSymbolName: "xmark",
                                      action: {
                                        self.stopProgress.toggle()
                    })
                    SCUndeterminedProgressView(finished: self.$stopProgress).padding()
                    Divider()
                }
            }
        }
    }
    
    func startFakeDownload() {
        self.animatedProgress += 0.9
    }
}

struct ProgressSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressSampleView()
    }
}
