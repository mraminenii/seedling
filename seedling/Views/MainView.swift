//
//  MainView.swift
//  Seedling
//
//  Created by Brian Q on 11/28/22.
//

import Foundation
import SwiftUI
import UIKit


class workouts: Identifiable {
    
    var itemName: String
    
    init(itemName: String) {
        
        self.itemName = itemName
    }
    
}

struct MainView: View {
    @State var plantCondition: String = "happyplantsmall"
    @State var tempWorkoutName: String = ""
    @State var tempReps: String = ""
    @State var tempSets: String = ""
    @State var isDisclosed = false
    @FocusState var focused: Bool
    @State var textEditorHeight: CGFloat = 20
    @State var showingPopover = false
    @State var plantGrowth = 1
    @State var plantMax = 3
    @State var plantLevel = 1
    
    @State var plantLevels = ["happyplantsmall", "happyplantmed", "happyplantlarge"]
    
    @State var workoutsList = [workouts]()
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color(red: 0.6706, green: 0.8392, blue: 0.5765))
                .frame(width: 400, height: 100)
            ZStack {
                VStack {
                    HStack {
                        HStack {
                            Text(String(describing: plantLevel))
                                .padding(0)
                                .frame(width: 50, height: 50)
                                .background(Color(red: 0.96, green: 0.80, blue: 0.56))
                                .foregroundColor(Color(red: 0.40, green: 0.24, blue: 0))
                                .cornerRadius(50.0)
                                .font(.system(size: 25, weight: .heavy))
                                .foregroundColor(.white)
                        }
                        .padding([.leading, .trailing], 30)
                        Spacer()
                        Button(action: saveWorkout) {
                                       EndWorkout()
                                    }
                        .popover(isPresented: $showingPopover) {
                            VStack {
                                Text("Good work today!")
                                    .font(.headline)
                                    .padding()
                                    .cornerRadius(15)
                                Button(action: {print("Button tapped")}) {
                                               feedPlant()
                                        .onTapGesture {
                                            showingPopover = false
                                        }
                                }
                            }
                                        
                                }
                        
                    }
                    .padding([.bottom, .trailing], 30)
                    .padding(.top, 10)
                    Spacer()
                }
                VStack {
                    Image(plantCondition)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    HStack {
                        plantProgress(progress: plantGrowth, progressMax: plantMax)
                    }
                    Spacer()
                        .frame(height: 200)
                    .padding()
                }
                .padding(100)
                VStack {
                    Spacer()
                    VStack {
                        ZStack {
                            List {
                                Section(header: Text("Today's Workout Plan")) {
                                    ForEach($workoutsList) {listItem in
                                        CustomCell(itemName: listItem.itemName)
                                    }
                                    TextField("Workout", text: $tempWorkoutName)
                                        .focused($focused)
                                }
                                .headerProminence(.increased)
                            }
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button(action: {print("Button tapped")}) {
                                                   addWorkoutViewButton()
                                            .onTapGesture(perform: addWorkout)
                                    }
                                }
                                .padding([.top, .bottom], 10)
                            }
                            .padding(25)
                        }

                    }
                        .frame(maxWidth: 330, maxHeight: 400)
                        .cornerRadius(25)
                        .modifier(AnimatingCellHeight(height: isDisclosed ? 500 : 300))
                        .onTapGesture {
                                        withAnimation {
                                            self.isDisclosed.toggle()
                                        }
                            if !isDisclosed {
                                focused = false
                            } else {
                                focused = true
                            }
                                    }
                }
            }
            Spacer()
        }
        .padding(.top, -30)

    }
    
    func addWorkout() {
        if tempWorkoutName != "" {
            workoutsList.append(workouts(itemName: tempWorkoutName))
            tempWorkoutName = ""
        }
    }
    
    func saveWorkout() {
        if (workoutsList.count > 0) {
            showingPopover = true
            progressPlant()
            addWorkout()
        }
        workoutsList = [workouts]()
        tempWorkoutName = ""
    }
    
    func progressPlant() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if plantGrowth < plantMax {
                plantGrowth += 1
            } else {
                plantLevel += 1
                plantMax += 2
                plantGrowth = 1
                if plantLevel <= 3 {
                    plantCondition = plantLevels[plantLevel - 1]
                }
            }
        }
    }
}

struct MainViewPreviews: PreviewProvider {
    static var previews: some View {
        ZStack {
            MainView()
        }
    }
}

struct AnimatingCellHeight: AnimatableModifier {
    var height: CGFloat = 0

    var animatableData: CGFloat {
        get { height }
        set { height = newValue }
    }

    func body(content: Content) -> some View {
        content.frame(height: height)
        
    }
}

struct EndWorkout : View {
    var body: some View {
        return Text("Complete Workout")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color(red: 0.6706, green: 0.8392, blue: 0.5765))
            .cornerRadius(15.0)
        
    }
}

struct addWorkoutViewButton : View {
    var body: some View {
        return Text("+")
            .font(.system(size: 35))
            .foregroundColor(.white)
            .padding(.bottom, 5)
            .frame(width: 50, height: 50, alignment: .center)
            .background(Color(red: 0.6706, green: 0.8392, blue: 0.5765))
            .cornerRadius(50.0)
        
    }
}

struct feedPlant : View {
    var body: some View {
        return Text("Feed your plant!")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 60)
            .background(Color(red: 0.6706, green: 0.8392, blue: 0.5765))
            .cornerRadius(15.0)
        
    }
}

struct plantProgress : View  {
    var progress: Int
    var progressMax: Int
    @State var showDetail = false
    @State private var scaleFactor: CGFloat = 1
    
    var body: some View {
        return Text("Progress: " + String(describing: progress) + "/" + String(describing: progressMax))
            .padding(0)
            .frame(width: 150, height: 40)
            .background(Color(red: 0.6706, green: 0.8392, blue: 0.5765))
            .cornerRadius(15.0)
            .font(.headline)
            .foregroundColor(.white)
    }
}

