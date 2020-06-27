//
//  SparkSampleView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import UIToolbox

struct SparkSampleView: View {
    @State private var showSuccessSpark = false
    @State private var showErrorSpark = false
    @State private var showDownloadingSpark = false
    var body: some View {
        ZStack {
            VStack {
                LargeButton(title: "Success Spark",
                            symbolName: "checkmark",
                            frame: (width: 300, height: 50),
                            color: .green, fontColor: .white,
                            style: .filled) {
                          self.showSuccessSpark = true
                }.padding(.top, 20)
                
                LargeButton(title: "Error Spark",
                            symbolName: "xmark",
                            frame: (width: 300, height: 50),
                            color: .red, fontColor: .white,
                            style: .filled) {
                          self.showErrorSpark = true
                }
                
                LargeButton(title: "Downloading Spark",
                            symbolName: "icloud.and.arrow.down",
                            frame: (width: 300, height: 50),
                            color: .blue, fontColor: .white,
                            style: .filled) {
                          self.showDownloadingSpark = true
                }
                Spacer()
            }
            
            if self.sparkView != nil {
                sparkView!
            }
        }
    }
    
    var sparkView: AnyView? {
        if self.showSuccessSpark {
            return AnyView(SparkView(message: "Success!",
                      undoTitle: "Undo", undoAction: {
                        
            }, forError: false, sparkColor: .green).onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.showSuccessSpark.toggle()
                    }
                }
            })
        }
        
        if self.showErrorSpark {
            return AnyView(SparkView(message: "Error",
                      forError: true,
                      sparkColor: Color.red,
                      errorColor: Color.red).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.showErrorSpark.toggle()
                            }
                        }
            })
        }
        
        if self.showDownloadingSpark {
            return AnyView(SparkView(message: "Downloading",
                      undoTitle: "Cancel", undoAction: {
                        
            }, forError: false, sparkColor: .blue).onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.showDownloadingSpark.toggle()
                    }
                }
            })
        }
        
        return nil
    }
}

//struct SparkSampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        SparkSampleView()
//    }
//}
