//
//  SparkSampleView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import SUITcase

struct SparkSampleView: View {
    @State private var showSuccessSpark = false
    @State private var showErrorSpark = false
    @State private var showDownloadingSpark = false
    var body: some View {
        ZStack {
            VStack {
                LargeButton(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                                                       self.showSuccessSpark = true
                                                   }
                }, label: {
                    Text("Success Spark")
                }, frame: (width: 300, height: 50),
                color: .green, fontColor: .white,
                style: .filled)
                .padding(.top, 20)
                                
                LargeButton(action: {
                    withAnimation(.easeInOut) {
                        self.showErrorSpark = true
                    }
                }, label: {
                    Text("Error Spark")
                }, frame: (width: 300, height: 50),
                color: .red, fontColor: .white,
                style: .filled)
                
                LargeButton(action: {
                    withAnimation(.easeInOut) {
                        self.showDownloadingSpark = true
                    }
                }, label: {
                    HStack {
                        Image(systemName: "icloud.and.arrow.down")
                        Text("Downloading Spark").padding(.leading, 10)
                    }
                }, frame: (width: 300, height: 50),
                color: .red, fontColor: .white,
                style: .filled)
                Spacer()
            }
            
            if self.sparkView != nil {
                sparkView!.transition(.move(edge: .bottom))
            }
        }
    }
    
    var sparkView: AnyView? {
        if self.showSuccessSpark {
            return AnyView(
                SparkView(label: {
                    Text("Success!")
                }, undoAction: {
                    
                }).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.showSuccessSpark.toggle()
                        }
                    }
                }
            )
        }
        
        if self.showErrorSpark {
            return AnyView(
                SparkView(label: {
                    Text("Error")
                }, undoAction: {
                    
                }, forError: true, sparkColor: .red).onAppear {
                   DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.showErrorSpark.toggle()
                        }
                    }
                }
            )
        }
        
        if self.showDownloadingSpark {
            return AnyView(
                SparkView(label: {
                    HStack {
                        Image(systemName: "icloud.and.arrow.down")
                        Text("Downloading").padding(.leading, 10)
                    }
                }).onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.showDownloadingSpark.toggle()
                    }
                }
            }
            )
        }
        
        return nil
    }
}

struct SparkSampleView_Previews: PreviewProvider {
    static var previews: some View {
        SparkSampleView()
    }
}
