//
//  ContentView.swift
//  GcoTaskOne
//
//  Created by Nozhan Amiri on 9/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: Double = 0
    @State private var animated = false
    
    @State private var currentTime = "00:00"
    
    private var sunCurveView: some View {
        ZStack {
            GeometryReader { geo in
                SineWave(phase: .pi / 2)
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [6, 4]))
                    .foregroundStyle(.white.opacity(0.7))
                
                SineWave(phase: .pi / 2, taperTrailing: 1 - progress)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.purple)
                
                Image(systemName: "sun.max.fill")
                    .imageScale(.large)
                    .foregroundStyle(.yellow)
                    .overlay {
                        Text(currentTime)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .offset(y: -28)
                            .frame(width: 86)
                    }
                    .animatePosition(alongPath: SineWave(phase: .pi / 2).path(in: geo.size.boundingRect), start: CGPoint(x: 0, y: geo.size.height), progress: progress)
            } // :GeometryReader
            .padding(.horizontal, 32)
        } // :ZStack
        .frame(height: 100)
        .overlay {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.white.opacity(0.2))
        }
    }
    
    private var footerView: some View {
        HStack {
            HStack {
                Image(systemName: "sunrise.fill")
                    .imageScale(.large)
                    .bold()
                    .foregroundStyle(.purple.gradient)
                
                VStack(alignment: .leading) {
                    Text("Sunrise")
                        .bold()
                        .font(.subheadline)
                    Text("5:42 AM")
                        .font(.caption)
                } // :VStack
                .foregroundStyle(.white)
                
            } // :HStack
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Sunset")
                        .bold()
                        .font(.subheadline)
                    Text("6:24 PM")
                        .font(.caption)
                } // :VStack
                
                Image(systemName: "sunset.fill")
                    .imageScale(.large)
                    .bold()
                    .foregroundStyle(.purple.gradient)
            }
            .foregroundStyle(.white)
        } // :HStack
    }
    
    private var sunCardView: some View {
        VStack(spacing: 32) {
            sunCurveView
            footerView
        } // :VStack
        .padding(EdgeInsets(top: 44, leading: 16, bottom: 28, trailing: 16))
        .background(.black.opacity(0.8))
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
        .padding()
    }
    
    var animateButton: some View {
        Button(animated ? "Reset" : "Start Animating") {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: .now)
            let minute = calendar.component(.minute, from: .now)
            
            withAnimation(.easeOut(duration: 2)) {
                self.progress = animated ? 0 : (Double(hour) * 60 + Double(minute)) / (24 * 60)
            }
            
            self.currentTime = animated ? "00:00" : "\(hour):\(minute)"
            self.animated.toggle()
        } // :Button
        .buttonStyle(.borderedProminent)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                sunCardView
                animateButton
            } // :VStack
        } // :NavigationStack
    }
}

#Preview {
    ContentView()
}
