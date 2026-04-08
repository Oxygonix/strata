//
//  WorkoutData.swift
//  strata
//
//  Created by Sanjana Madhav on 4/7/26.
//

import Foundation

let workouts: [Workout] = [
    // CHEST WORKOUTS
    Workout(name: "Chest Builder", bodyPartsWorked: ["Chest", "Triceps"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Bench Press", sets: 4, reps: "8-12", rest: "90s"),
        Exercise(name: "Incline Dumbbell Press", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Chest Fly", sets: 3, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Chest Shred", bodyPartsWorked: ["Chest", "Triceps"], difficulty: "Advanced", duration: 45, exercises: [
        Exercise(name: "Dumbbell Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Incline Barbell Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Cable Fly", sets: 3, reps: "12-15", rest: "60s")
    ]),
    Workout(name: "Push Power", bodyPartsWorked: ["Chest", "Shoulders", "Triceps"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Push-ups", sets: 3, reps: "10-15", rest: "60s"),
        Exercise(name: "Dumbbell Bench Press", sets: 3, reps: "8-12", rest: "60s"),
        Exercise(name: "Chest Stretch", sets: 2, reps: "30s hold", rest: "0s")
    ]),
    Workout(name: "Upper Chest Pump", bodyPartsWorked: ["Chest", "Shoulders", "Triceps"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Incline Dumbbell Press", sets: 4, reps: "8-12", rest: "90s"),
        Exercise(name: "Incline Fly", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Push-ups", sets: 3, reps: "15-20", rest: "45s")
    ]),
    Workout(name: "Chest Finisher", bodyPartsWorked: ["Chest", "Triceps", "Shoulders"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Barbell Bench Press", sets: 5, reps: "6-8", rest: "120s"),
        Exercise(name: "Incline Dumbbell Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Cable Crossovers", sets: 3, reps: "12-15", rest: "60s")
    ]),

    // BACK WORKOUTS
    Workout(name: "Back Builder", bodyPartsWorked: ["Lats", "Rear Delts", "Traps", "Biceps"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Pull-ups", sets: 4, reps: "6-10", rest: "90s"),
        Exercise(name: "Barbell Rows", sets: 4, reps: "8-12", rest: "90s"),
        Exercise(name: "Lat Pulldown", sets: 3, reps: "10-12", rest: "60s")
    ]),
    Workout(name: "Back Strength", bodyPartsWorked: ["Lats", "Rear Delts", "Traps", "Biceps"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Deadlifts", sets: 4, reps: "5-8", rest: "120s"),
        Exercise(name: "T-Bar Rows", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Seated Cable Rows", sets: 3, reps: "10-12", rest: "60s")
    ]),
    Workout(name: "Back Basics", bodyPartsWorked: ["Lats", "Rear Delts", "Biceps"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Assisted Pull-ups", sets: 3, reps: "8-12", rest: "60s"),
        Exercise(name: "Dumbbell Rows", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Cat-Cow Stretch", sets: 2, reps: "30s hold", rest: "0s")
    ]),
    Workout(name: "Lats & Traps", bodyPartsWorked: ["Lats", "Traps", "Rear Delts"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Lat Pulldown", sets: 4, reps: "10-12", rest: "60s"),
        Exercise(name: "Dumbbell Shrugs", sets: 3, reps: "12-15", rest: "45s"),
        Exercise(name: "One-Arm Dumbbell Row", sets: 3, reps: "10-12", rest: "60s")
    ]),
    Workout(name: "Pull Power", bodyPartsWorked: ["Lats", "Biceps", "Traps"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Weighted Pull-ups", sets: 4, reps: "6-8", rest: "90s"),
        Exercise(name: "Barbell Deadlift", sets: 4, reps: "5-6", rest: "120s"),
        Exercise(name: "Bent-Over Rows", sets: 4, reps: "8-10", rest: "90s")
    ]),

    // LEGS WORKOUTS
    Workout(name: "Leg Strength", bodyPartsWorked: ["Quads", "Hamstrings", "Glutes", "Calves"], difficulty: "Intermediate", duration: 50, exercises: [
        Exercise(name: "Squats", sets: 4, reps: "8-12", rest: "120s"),
        Exercise(name: "Lunges", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Leg Press", sets: 3, reps: "10-12", rest: "90s")
    ]),
    Workout(name: "Leg Endurance", bodyPartsWorked: ["Quads", "Hamstrings", "Calves"], difficulty: "Beginner", duration: 40, exercises: [
        Exercise(name: "Bodyweight Squats", sets: 3, reps: "15-20", rest: "45s"),
        Exercise(name: "Walking Lunges", sets: 3, reps: "10 per leg", rest: "60s"),
        Exercise(name: "Calf Raises", sets: 3, reps: "15-20", rest: "30s")
    ]),
    Workout(name: "Leg Power", bodyPartsWorked: ["Quads", "Hamstrings", "Glutes"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Barbell Squats", sets: 5, reps: "6-8", rest: "120s"),
        Exercise(name: "Romanian Deadlifts", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Leg Extensions", sets: 4, reps: "12-15", rest: "60s")
    ]),
    Workout(name: "Glute Builder", bodyPartsWorked: ["Glutes", "Hamstrings", "Quads"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Hip Thrusts", sets: 4, reps: "8-12", rest: "90s"),
        Exercise(name: "Walking Lunges", sets: 3, reps: "12 per leg", rest: "60s"),
        Exercise(name: "Step-Ups", sets: 3, reps: "10 per leg", rest: "60s")
    ]),
    Workout(name: "Leg Finisher", bodyPartsWorked: ["Quads", "Glutes", "Hamstrings", "Calves"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Front Squats", sets: 4, reps: "6-8", rest: "120s"),
        Exercise(name: "Deadlifts", sets: 4, reps: "6-8", rest: "120s"),
        Exercise(name: "Jump Squats", sets: 3, reps: "12-15", rest: "60s")
    ]),

    // ARMS WORKOUTS
    Workout(name: "Arm Builder", bodyPartsWorked: ["Biceps", "Triceps", "Forearms"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Bicep Curls", sets: 4, reps: "10-12", rest: "60s"),
        Exercise(name: "Tricep Dips", sets: 4, reps: "8-12", rest: "60s"),
        Exercise(name: "Hammer Curls", sets: 3, reps: "10-12", rest: "60s")
    ]),
    Workout(name: "Arm Sculpt", bodyPartsWorked: ["Biceps", "Triceps", "Forearms"], difficulty: "Advanced", duration: 45, exercises: [
        Exercise(name: "Barbell Curls", sets: 4, reps: "8-10", rest: "60s"),
        Exercise(name: "Skull Crushers", sets: 4, reps: "8-10", rest: "60s"),
        Exercise(name: "Concentration Curls", sets: 3, reps: "10-12", rest: "45s")
    ]),
    Workout(name: "Arm Basics", bodyPartsWorked: ["Biceps", "Triceps", "Forearms"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Dumbbell Bicep Curls", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Tricep Kickbacks", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Wrist Stretch", sets: 2, reps: "30s hold", rest: "0s")
    ]),
    
    Workout(name: "Biceps Blast", bodyPartsWorked: ["Biceps", "Forearms"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Barbell Curls", sets: 4, reps: "8-10", rest: "60s"),
        Exercise(name: "Hammer Curls", sets: 4, reps: "10-12", rest: "60s"),
        Exercise(name: "Cable Curls", sets: 3, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Triceps Finisher", bodyPartsWorked: ["Triceps", "Forearms"], difficulty: "Advanced", duration: 45, exercises: [
        Exercise(name: "Close-Grip Bench Press", sets: 4, reps: "6-8", rest: "90s"),
        Exercise(name: "Weighted Tricep Dips", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Overhead Tricep Extension", sets: 3, reps: "10-12", rest: "60s")
    ]),

    // CORE WORKOUTS
    Workout(name: "Core Crusher", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Intermediate", duration: 35, exercises: [
        Exercise(name: "Plank", sets: 3, reps: "45s", rest: "30s"),
        Exercise(name: "Russian Twists", sets: 3, reps: "20 reps", rest: "30s"),
        Exercise(name: "Leg Raises", sets: 3, reps: "12-15", rest: "30s")
    ]),
    Workout(name: "Core Strength", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Advanced", duration: 40, exercises: [
        Exercise(name: "Weighted Plank", sets: 3, reps: "30-45s", rest: "30s"),
        Exercise(name: "Hanging Leg Raises", sets: 4, reps: "12-15", rest: "45s"),
        Exercise(name: "Bicycle Crunches", sets: 3, reps: "20 reps", rest: "30s")
    ]),
    Workout(name: "Core Basics", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Beginner", duration: 30, exercises: [
        Exercise(name: "Knee Plank", sets: 3, reps: "30s", rest: "30s"),
        Exercise(name: "Crunches", sets: 3, reps: "10-15", rest: "30s"),
        Exercise(name: "Seated Twist", sets: 2, reps: "20 reps", rest: "0s")
    ]),
    Workout(name: "Abs & Obliques", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Intermediate", duration: 35, exercises: [
        Exercise(name: "Side Plank", sets: 3, reps: "30s each side", rest: "30s"),
        Exercise(name: "Bicycle Crunches", sets: 3, reps: "20 reps", rest: "30s"),
        Exercise(name: "Leg Raises", sets: 3, reps: "12-15", rest: "30s")
    ]),
    Workout(name: "Full Core Blast", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Advanced", duration: 45, exercises: [
        Exercise(name: "Plank with Shoulder Tap", sets: 4, reps: "20 taps", rest: "30s"),
        Exercise(name: "Hanging Knee Raises", sets: 4, reps: "10-12", rest: "30s"),
        Exercise(name: "Ab Rollouts", sets: 3, reps: "12 reps", rest: "60s")
    ]),

    // FULL BODY WORKOUTS
    Workout(name: "Full Body Burn", bodyPartsWorked: ["Chest", "Quads", "Glutes", "Lats", "Biceps", "Triceps", "Shoulders", "Abs"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Burpees", sets: 4, reps: "10-12", rest: "60s"),
        Exercise(name: "Push-ups", sets: 4, reps: "10-15", rest: "60s"),
        Exercise(name: "Squat Jumps", sets: 3, reps: "12-15", rest: "60s")
    ]),
    Workout(name: "Total Body Strength", bodyPartsWorked: ["Chest", "Quads", "Glutes", "Lats", "Biceps", "Triceps", "Shoulders", "Abs"], difficulty: "Intermediate", duration: 50, exercises: [
        Exercise(name: "Deadlifts", sets: 4, reps: "6-8", rest: "120s"),
        Exercise(name: "Bench Press", sets: 4, reps: "8-12", rest: "90s"),
        Exercise(name: "Pull-ups", sets: 3, reps: "6-10", rest: "90s")
    ]),
    Workout(name: "Bodyweight Blast", bodyPartsWorked: ["Chest", "Quads", "Glutes", "Abs"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Push-ups", sets: 3, reps: "10-15", rest: "45s"),
        Exercise(name: "Bodyweight Squats", sets: 3, reps: "15-20", rest: "45s"),
        Exercise(name: "Plank", sets: 3, reps: "30-45s", rest: "30s")
    ]),
    Workout(name: "Cardio Strength", bodyPartsWorked: ["Quads", "Glutes", "Abs"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Jumping Jacks", sets: 3, reps: "50", rest: "30s"),
        Exercise(name: "Lunges", sets: 3, reps: "12 per leg", rest: "60s"),
        Exercise(name: "Push-ups", sets: 3, reps: "12-15", rest: "60s")
    ]),
    Workout(name: "Total Body Finisher", bodyPartsWorked: ["Chest", "Quads", "Glutes", "Lats", "Biceps", "Triceps", "Shoulders", "Abs"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Burpees", sets: 4, reps: "12", rest: "60s"),
        Exercise(name: "Deadlifts", sets: 4, reps: "6-8", rest: "120s"),
        Exercise(name: "Pull-ups", sets: 4, reps: "6-10", rest: "90s")
    ]),

    // UPPER BODY WORKOUTS
    Workout(name: "Upper Body Blast", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Bench Press", sets: 4, reps: "8-12", rest: "90s"),
        Exercise(name: "Pull-ups", sets: 3, reps: "6-10", rest: "90s"),
        Exercise(name: "Shoulder Press", sets: 3, reps: "10-12", rest: "60s")
    ]),
    Workout(name: "Upper Body Strength", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Incline Bench Press", sets: 4, reps: "6-10", rest: "90s"),
        Exercise(name: "Barbell Rows", sets: 4, reps: "8-12", rest: "90s"),
        Exercise(name: "Overhead Press", sets: 4, reps: "8-10", rest: "60s")
    ]),
    Workout(name: "Upper Body Basics", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Push-ups", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Dumbbell Rows", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Shoulder Circles", sets: 2, reps: "30s", rest: "0s")
    ]),
    Workout(name: "Push & Pull", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Bench Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Pull-ups", sets: 4, reps: "6-10", rest: "90s"),
        Exercise(name: "Dumbbell Shoulder Press", sets: 3, reps: "10-12", rest: "60s")
    ]),
    Workout(name: "Upper Body Finisher", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Weighted Pull-ups", sets: 4, reps: "6-8", rest: "90s"),
        Exercise(name: "Incline Bench Press", sets: 4, reps: "6-8", rest: "90s"),
        Exercise(name: "Arnold Press", sets: 3, reps: "10-12", rest: "60s")
    ])
]
