//
//  WorkoutData.swift
//  strata
//
//  Created by Sanjana Madhav on 4/7/26.
//

import Foundation

let workouts: [Workout] = [

    // MARK: - CHEST (8)

    Workout(
        name: "Chest Strength A",
        bodyPartsWorked: ["Chest", "Triceps", "Shoulders"],
        difficulty: "Advanced",
        duration: 45,
        exercises: [
            Exercise(name: "Barbell Bench Press", sets: 4, reps: "5-8", rest: "120s", intensity: 5, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Incline Bench Press", sets: 3, reps: "8-10", rest: "90s", intensity: 4, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Cable Fly", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    Workout(
        name: "Chest Builder",
        bodyPartsWorked: ["Chest", "Triceps", "Shoulders"],
        difficulty: "Intermediate",
        duration: 42,
        exercises: [
            Exercise(name: "Dumbbell Bench Press", sets: 4, reps: "8-10", rest: "90s", intensity: 4, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Chest Fly", sets: 3, reps: "10-12", rest: "45s", intensity: 3, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Push-Up", sets: 3, reps: "12-20", rest: "45s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Upper Chest Focus",
        bodyPartsWorked: ["Chest", "Shoulders", "Triceps"],
        difficulty: "Advanced",
        duration: 44,
        exercises: [
            Exercise(name: "Incline Bench Press", sets: 4, reps: "6-10", rest: "90s", intensity: 5, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Incline Cable Fly", sets: 3, reps: "10-15", rest: "45s", intensity: 3, equipment: ["Cables", "Bench"]),
            Exercise(name: "Incline Push-Up", sets: 3, reps: "15-20", rest: "30s", intensity: 2, equipment: ["Bench", "Mat"])
        ]
    ),

    Workout(
        name: "Chest Volume Day",
        bodyPartsWorked: ["Chest", "Triceps", "Shoulders"],
        difficulty: "Intermediate",
        duration: 46,
        exercises: [
            Exercise(name: "Machine Chest Press", sets: 4, reps: "8-12", rest: "75s", intensity: 4, equipment: []),
            Exercise(name: "Chest Fly", sets: 4, reps: "10-15", rest: "45s", intensity: 3, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Decline Push-Up", sets: 3, reps: "10-15", rest: "45s", intensity: 3, equipment: ["Bench", "Mat"])
        ]
    ),

    Workout(
        name: "Chest Press Mix",
        bodyPartsWorked: ["Chest", "Triceps", "Shoulders"],
        difficulty: "Advanced",
        duration: 48,
        exercises: [
            Exercise(name: "Barbell Bench Press", sets: 4, reps: "6-8", rest: "120s", intensity: 5, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Dumbbell Bench Press", sets: 3, reps: "8-12", rest: "75s", intensity: 4, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Decline Cable Fly", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables", "Bench"])
        ]
    ),

    Workout(
        name: "Chest Pump",
        bodyPartsWorked: ["Chest", "Shoulders", "Triceps"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Machine Chest Press", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: []),
            Exercise(name: "Cable Fly", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"]),
            Exercise(name: "Push-Up", sets: 2, reps: "AMRAP", rest: "45s", intensity: 3, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Decline Chest Day",
        bodyPartsWorked: ["Chest", "Triceps", "Shoulders"],
        difficulty: "Intermediate",
        duration: 43,
        exercises: [
            Exercise(name: "Decline Bench Press", sets: 4, reps: "6-10", rest: "90s", intensity: 4, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Decline Cable Fly", sets: 3, reps: "10-15", rest: "45s", intensity: 3, equipment: ["Cables", "Bench"]),
            Exercise(name: "Close Grip Push-Up", sets: 3, reps: "10-15", rest: "45s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Chest Finisher",
        bodyPartsWorked: ["Chest", "Triceps", "Shoulders"],
        difficulty: "Intermediate",
        duration: 38,
        exercises: [
            Exercise(name: "Dumbbell Bench Press", sets: 3, reps: "8-10", rest: "75s", intensity: 4, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Chest Fly", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Push-Up", sets: 3, reps: "AMRAP", rest: "30s", intensity: 3, equipment: ["Mat"])
        ]
    ),

    // MARK: - BACK (8)

    Workout(
        name: "Back Strength A",
        bodyPartsWorked: ["Lats", "Biceps", "Rear Delts", "Traps"],
        difficulty: "Advanced",
        duration: 48,
        exercises: [
            Exercise(name: "Pull-Up", sets: 4, reps: "6-8", rest: "120s", intensity: 5, equipment: []),
            Exercise(name: "Lat Pulldown", sets: 3, reps: "8-12", rest: "75s", intensity: 4, equipment: []),
            Exercise(name: "Face Pull", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    Workout(
        name: "Wide Back Builder",
        bodyPartsWorked: ["Lats", "Biceps", "Rear Delts"],
        difficulty: "Intermediate",
        duration: 44,
        exercises: [
            Exercise(name: "Wide Grip Lat Pulldown", sets: 4, reps: "8-12", rest: "75s", intensity: 4, equipment: []),
            Exercise(name: "Single Arm Lat Pulldown", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: []),
            Exercise(name: "Straight Arm Pulldown", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    Workout(
        name: "Pull and Grip",
        bodyPartsWorked: ["Lats", "Biceps", "Forearms", "Traps"],
        difficulty: "Intermediate",
        duration: 46,
        exercises: [
            Exercise(name: "Chin-Up", sets: 4, reps: "6-10", rest: "90s", intensity: 4, equipment: []),
            Exercise(name: "Close Grip Lat Pulldown", sets: 3, reps: "8-12", rest: "75s", intensity: 3, equipment: []),
            Exercise(name: "Dead Hang", sets: 3, reps: "30-45s", rest: "45s", intensity: 2, equipment: [])
        ]
    ),

    Workout(
        name: "Trap Builder",
        bodyPartsWorked: ["Traps", "Forearms", "Rear Delts"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Barbell Shrug", sets: 4, reps: "10-12", rest: "60s", intensity: 4, equipment: ["Barbells"]),
            Exercise(name: "Dumbbell Shrug", sets: 3, reps: "12-15", rest: "45s", intensity: 3, equipment: ["Dumbbells"]),
            Exercise(name: "Reverse Fly", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Dumbbells", "Bench"])
        ]
    ),

    Workout(
        name: "Back Basics",
        bodyPartsWorked: ["Lats", "Biceps", "Rear Delts"],
        difficulty: "Beginner",
        duration: 38,
        exercises: [
            Exercise(name: "Resistance Band Pulldown", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: []),
            Exercise(name: "Lat Pulldown", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: []),
            Exercise(name: "Cable Rear Delt Fly", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    Workout(
        name: "Rear Delt and Lats",
        bodyPartsWorked: ["Rear Delts", "Lats", "Traps"],
        difficulty: "Intermediate",
        duration: 42,
        exercises: [
            Exercise(name: "Single Arm Lat Pulldown", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: []),
            Exercise(name: "Face Pull", sets: 4, reps: "12-15", rest: "45s", intensity: 3, equipment: ["Cables"]),
            Exercise(name: "Rear Delt Machine Fly", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: [])
        ]
    ),

    Workout(
        name: "Loaded Pull Day",
        bodyPartsWorked: ["Lats", "Biceps", "Forearms", "Traps"],
        difficulty: "Advanced",
        duration: 50,
        exercises: [
            Exercise(name: "Pull-Up", sets: 4, reps: "6-8", rest: "120s", intensity: 5, equipment: []),
            Exercise(name: "Farmer’s Carry", sets: 4, reps: "30-40s", rest: "60s", intensity: 4, equipment: ["Dumbbells"]),
            Exercise(name: "Straight Arm Pulldown", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    Workout(
        name: "Back Finisher",
        bodyPartsWorked: ["Lats", "Biceps", "Forearms", "Traps"],
        difficulty: "Intermediate",
        duration: 43,
        exercises: [
            Exercise(name: "Chin-Up", sets: 3, reps: "6-10", rest: "90s", intensity: 4, equipment: []),
            Exercise(name: "Wide Grip Lat Pulldown", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: []),
            Exercise(name: "Towel Hang", sets: 3, reps: "20-30s", rest: "45s", intensity: 2, equipment: [])
        ]
    ),

    // MARK: - LEGS (8)

    Workout(
        name: "Leg Strength A",
        bodyPartsWorked: ["Quads", "Glutes", "Hamstrings", "Calves"],
        difficulty: "Advanced",
        duration: 52,
        exercises: [
            Exercise(name: "Back Squat", sets: 4, reps: "5-8", rest: "120s", intensity: 5, equipment: ["Barbells"]),
            Exercise(name: "Walking Lunge", sets: 3, reps: "10 per leg", rest: "75s", intensity: 4, equipment: ["Dumbbells"]),
            Exercise(name: "Standing Calf Raise", sets: 3, reps: "12-20", rest: "30s", intensity: 2, equipment: [])
        ]
    ),

    Workout(
        name: "Quad Builder",
        bodyPartsWorked: ["Quads", "Glutes", "Hamstrings"],
        difficulty: "Advanced",
        duration: 48,
        exercises: [
            Exercise(name: "Front Squat", sets: 4, reps: "6-8", rest: "120s", intensity: 5, equipment: ["Barbells"]),
            Exercise(name: "Leg Press", sets: 3, reps: "10-12", rest: "90s", intensity: 4, equipment: []),
            Exercise(name: "Leg Extension", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: [])
        ]
    ),

    Workout(
        name: "Hamstring Focus",
        bodyPartsWorked: ["Hamstrings", "Glutes"],
        difficulty: "Advanced",
        duration: 47,
        exercises: [
            Exercise(name: "Romanian Deadlift", sets: 4, reps: "6-10", rest: "120s", intensity: 5, equipment: ["Barbells"]),
            Exercise(name: "Seated Leg Curl", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: []),
            Exercise(name: "Glute Bridge", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Glute Builder",
        bodyPartsWorked: ["Glutes", "Hamstrings", "Quads"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Barbell Hip Thrust", sets: 4, reps: "8-10", rest: "90s", intensity: 4, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Reverse Lunge", sets: 3, reps: "10 per leg", rest: "75s", intensity: 3, equipment: ["Dumbbells"]),
            Exercise(name: "Cable Kickback", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    Workout(
        name: "Leg Power",
        bodyPartsWorked: ["Quads", "Glutes", "Hamstrings", "Calves"],
        difficulty: "Advanced",
        duration: 50,
        exercises: [
            Exercise(name: "Hack Squat", sets: 4, reps: "6-10", rest: "120s", intensity: 5, equipment: []),
            Exercise(name: "Jump Squat", sets: 3, reps: "10-12", rest: "60s", intensity: 4, equipment: ["Mat"]),
            Exercise(name: "Single Leg Calf Raise", sets: 3, reps: "12-15", rest: "30s", intensity: 2, equipment: [])
        ]
    ),

    Workout(
        name: "Adductor and Glute Day",
        bodyPartsWorked: ["Adductors", "Glutes", "Quads", "Hamstrings"],
        difficulty: "Intermediate",
        duration: 43,
        exercises: [
            Exercise(name: "Sumo Squat", sets: 4, reps: "8-10", rest: "90s", intensity: 4, equipment: ["Kettle Bell"]),
            Exercise(name: "Curtsy Lunge", sets: 3, reps: "10 per leg", rest: "60s", intensity: 3, equipment: ["Dumbbells"]),
            Exercise(name: "Frog Pump", sets: 3, reps: "15-20", rest: "30s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Lower Body Basics",
        bodyPartsWorked: ["Quads", "Glutes", "Hamstrings", "Calves"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Leg Press", sets: 3, reps: "10-12", rest: "75s", intensity: 3, equipment: []),
            Exercise(name: "Step-Up", sets: 3, reps: "10 per leg", rest: "60s", intensity: 3, equipment: ["Bench", "Dumbbells"]),
            Exercise(name: "Wall Sit", sets: 3, reps: "30-45s", rest: "30s", intensity: 2, equipment: [])
        ]
    ),

    Workout(
        name: "Posterior Chain Day",
        bodyPartsWorked: ["Hamstrings", "Glutes"],
        difficulty: "Advanced",
        duration: 48,
        exercises: [
            Exercise(name: "Good Morning", sets: 4, reps: "8-10", rest: "90s", intensity: 4, equipment: ["Barbells"]),
            Exercise(name: "Stiff Leg Deadlift", sets: 3, reps: "8-10", rest: "90s", intensity: 4, equipment: ["Barbells"]),
            Exercise(name: "Nordic Curl", sets: 3, reps: "6-10", rest: "60s", intensity: 3, equipment: ["Mat"])
        ]
    ),

    // MARK: - CORE (7)

    Workout(
        name: "Core Basics",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Beginner",
        duration: 30,
        exercises: [
            Exercise(name: "Crunch", sets: 3, reps: "12-20", rest: "30s", intensity: 2, equipment: ["Mat"]),
            Exercise(name: "Plank", sets: 3, reps: "30-45s", rest: "30s", intensity: 2, equipment: ["Mat"]),
            Exercise(name: "Toe Touches", sets: 3, reps: "15-20", rest: "30s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Core Strength",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Advanced",
        duration: 36,
        exercises: [
            Exercise(name: "Hanging Leg Raise", sets: 4, reps: "8-12", rest: "45s", intensity: 4, equipment: []),
            Exercise(name: "Ab Rollout", sets: 3, reps: "8-12", rest: "45s", intensity: 4, equipment: ["Mat"]),
            Exercise(name: "Russian Twist", sets: 3, reps: "20 reps", rest: "30s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Oblique Focus",
        bodyPartsWorked: ["Obliques", "Abs"],
        difficulty: "Intermediate",
        duration: 34,
        exercises: [
            Exercise(name: "Cable Woodchopper", sets: 3, reps: "12-15 per side", rest: "30s", intensity: 3, equipment: ["Cables"]),
            Exercise(name: "Side Plank", sets: 3, reps: "30-45s each side", rest: "30s", intensity: 2, equipment: ["Mat"]),
            Exercise(name: "Bicycle Crunch", sets: 3, reps: "20 reps", rest: "30s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Hanging Core Day",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Intermediate",
        duration: 35,
        exercises: [
            Exercise(name: "Hanging Knee Raise", sets: 4, reps: "10-15", rest: "45s", intensity: 3, equipment: []),
            Exercise(name: "Hanging Leg Raise", sets: 3, reps: "8-12", rest: "45s", intensity: 4, equipment: []),
            Exercise(name: "Flutter Kicks", sets: 3, reps: "20-30", rest: "30s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Ab Endurance",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Intermediate",
        duration: 32,
        exercises: [
            Exercise(name: "Sit-Up", sets: 3, reps: "15-20", rest: "30s", intensity: 2, equipment: ["Mat"]),
            Exercise(name: "Mountain Climbers", sets: 3, reps: "30-40s", rest: "30s", intensity: 3, equipment: ["Mat"]),
            Exercise(name: "Plank", sets: 3, reps: "45-60s", rest: "30s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Decline Core Day",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Intermediate",
        duration: 33,
        exercises: [
            Exercise(name: "Decline Sit-Up", sets: 3, reps: "10-15", rest: "30s", intensity: 3, equipment: ["Bench"]),
            Exercise(name: "Toe Touches", sets: 3, reps: "15-20", rest: "30s", intensity: 2, equipment: ["Mat"]),
            Exercise(name: "Russian Twist", sets: 3, reps: "20 reps", rest: "30s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Core Finisher",
        bodyPartsWorked: ["Abs", "Obliques", "Shoulders"],
        difficulty: "Intermediate",
        duration: 28,
        exercises: [
            Exercise(name: "Ab Rollout", sets: 3, reps: "8-10", rest: "45s", intensity: 4, equipment: ["Mat"]),
            Exercise(name: "Bicycle Crunch", sets: 3, reps: "20 reps", rest: "30s", intensity: 2, equipment: ["Mat"]),
            Exercise(name: "Side Plank", sets: 2, reps: "30-45s each side", rest: "30s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    // MARK: - ARMS (7)

    Workout(
        name: "Arm Builder",
        bodyPartsWorked: ["Biceps", "Triceps", "Forearms"],
        difficulty: "Intermediate",
        duration: 42,
        exercises: [
            Exercise(name: "Barbell Curl", sets: 4, reps: "8-10", rest: "60s", intensity: 4, equipment: ["Barbells"]),
            Exercise(name: "Tricep Pushdown", sets: 4, reps: "10-12", rest: "60s", intensity: 3, equipment: ["Cables"]),
            Exercise(name: "Hammer Curl", sets: 3, reps: "10-12", rest: "45s", intensity: 3, equipment: ["Dumbbells"])
        ]
    ),

    Workout(
        name: "Arm Basics",
        bodyPartsWorked: ["Biceps", "Triceps", "Forearms"],
        difficulty: "Intermediate",
        duration: 36,
        exercises: [
            Exercise(name: "Dumbbell Curl", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: ["Dumbbells"]),
            Exercise(name: "Overhead Tricep Extension", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: ["Dumbbells"]),
            Exercise(name: "Wrist Curl", sets: 2, reps: "15-20", rest: "30s", intensity: 2, equipment: ["Dumbbells"])
        ]
    ),

    Workout(
        name: "Biceps Blast",
        bodyPartsWorked: ["Biceps", "Forearms"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Preacher Curl", sets: 4, reps: "8-10", rest: "60s", intensity: 4, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Incline Curl", sets: 3, reps: "10-12", rest: "45s", intensity: 3, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Zottman Curl", sets: 3, reps: "10-12", rest: "45s", intensity: 2, equipment: ["Dumbbells"])
        ]
    ),

    Workout(
        name: "Triceps Finisher",
        bodyPartsWorked: ["Triceps", "Chest", "Shoulders"],
        difficulty: "Advanced",
        duration: 41,
        exercises: [
            Exercise(name: "Close Grip Bench Press", sets: 4, reps: "6-8", rest: "90s", intensity: 5, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Skull Crushers", sets: 3, reps: "8-12", rest: "60s", intensity: 4, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Bench Dips", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Bench"])
        ]
    ),

    Workout(
        name: "Cable Arms",
        bodyPartsWorked: ["Biceps", "Triceps"],
        difficulty: "Intermediate",
        duration: 38,
        exercises: [
            Exercise(name: "Cable Curl", sets: 4, reps: "10-12", rest: "45s", intensity: 3, equipment: ["Cables"]),
            Exercise(name: "Cable Overhead Extension", sets: 4, reps: "10-12", rest: "45s", intensity: 3, equipment: ["Cables"]),
            Exercise(name: "Reverse Wrist Curl", sets: 3, reps: "15-20", rest: "30s", intensity: 2, equipment: ["Dumbbells"])
        ]
    ),

    Workout(
        name: "Forearm and Curl Day",
        bodyPartsWorked: ["Forearms", "Biceps"],
        difficulty: "Intermediate",
        duration: 35,
        exercises: [
            Exercise(name: "Reverse Curl", sets: 4, reps: "10-12", rest: "45s", intensity: 3, equipment: ["Barbells"]),
            Exercise(name: "Hammer Curl", sets: 3, reps: "10-12", rest: "45s", intensity: 3, equipment: ["Dumbbells"]),
            Exercise(name: "Wrist Curl", sets: 3, reps: "15-20", rest: "30s", intensity: 2, equipment: ["Dumbbells"])
        ]
    ),

    Workout(
        name: "Push and Arms",
        bodyPartsWorked: ["Triceps", "Chest", "Biceps"],
        difficulty: "Intermediate",
        duration: 39,
        exercises: [
            Exercise(name: "Close Grip Push-Up", sets: 3, reps: "12-20", rest: "45s", intensity: 3, equipment: ["Mat"]),
            Exercise(name: "Concentration Curl", sets: 3, reps: "10-12", rest: "45s", intensity: 3, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Tricep Pushdown", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    // MARK: - FULL BODY (6)

    Workout(
        name: "Full Body Strength",
        bodyPartsWorked: ["Chest", "Quads", "Lats", "Shoulders"],
        difficulty: "Advanced",
        duration: 55,
        exercises: [
            Exercise(name: "Back Squat", sets: 4, reps: "5-8", rest: "120s", intensity: 5, equipment: ["Barbells"]),
            Exercise(name: "Barbell Bench Press", sets: 4, reps: "6-8", rest: "90s", intensity: 5, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Pull-Up", sets: 3, reps: "6-10", rest: "90s", intensity: 4, equipment: [])
        ]
    ),

    Workout(
        name: "Full Body Builder",
        bodyPartsWorked: ["Quads", "Glutes", "Chest", "Lats"],
        difficulty: "Intermediate",
        duration: 52,
        exercises: [
            Exercise(name: "Leg Press", sets: 4, reps: "8-12", rest: "90s", intensity: 4, equipment: []),
            Exercise(name: "Dumbbell Bench Press", sets: 3, reps: "8-12", rest: "75s", intensity: 4, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Lat Pulldown", sets: 3, reps: "10-12", rest: "75s", intensity: 3, equipment: [])
        ]
    ),

    Workout(
        name: "Full Body Basics",
        bodyPartsWorked: ["Chest", "Quads", "Abs", "Glutes"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Push-Up", sets: 3, reps: "10-15", rest: "45s", intensity: 3, equipment: ["Mat"]),
            Exercise(name: "Walking Lunge", sets: 3, reps: "10 per leg", rest: "60s", intensity: 3, equipment: ["Dumbbells"]),
            Exercise(name: "Plank", sets: 3, reps: "30-45s", rest: "30s", intensity: 2, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Full Body Cable Mix",
        bodyPartsWorked: ["Chest", "Lats", "Obliques", "Glutes"],
        difficulty: "Intermediate",
        duration: 47,
        exercises: [
            Exercise(name: "Cable Fly", sets: 3, reps: "12-15", rest: "45s", intensity: 3, equipment: ["Cables"]),
            Exercise(name: "Straight Arm Pulldown", sets: 3, reps: "12-15", rest: "45s", intensity: 3, equipment: ["Cables"]),
            Exercise(name: "Cable Kickback", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    Workout(
        name: "Athletic Full Body",
        bodyPartsWorked: ["Quads", "Glutes", "Shoulders", "Abs"],
        difficulty: "Advanced",
        duration: 46,
        exercises: [
            Exercise(name: "Jump Squat", sets: 3, reps: "10-12", rest: "60s", intensity: 4, equipment: ["Mat"]),
            Exercise(name: "Dumbbell Shoulder Press", sets: 3, reps: "8-12", rest: "60s", intensity: 4, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Mountain Climbers", sets: 3, reps: "30-40s", rest: "30s", intensity: 3, equipment: ["Mat"])
        ]
    ),

    Workout(
        name: "Total Body Finisher",
        bodyPartsWorked: ["Chest", "Hamstrings", "Lats", "Abs"],
        difficulty: "Advanced",
        duration: 50,
        exercises: [
            Exercise(name: "Romanian Deadlift", sets: 4, reps: "6-8", rest: "120s", intensity: 5, equipment: ["Barbells"]),
            Exercise(name: "Push-Up", sets: 3, reps: "AMRAP", rest: "45s", intensity: 3, equipment: ["Mat"]),
            Exercise(name: "Hanging Knee Raise", sets: 3, reps: "10-15", rest: "45s", intensity: 3, equipment: [])
        ]
    ),

    // MARK: - UPPER BODY (6)

    Workout(
        name: "Upper Body Blast",
        bodyPartsWorked: ["Chest", "Lats", "Shoulders", "Triceps"],
        difficulty: "Advanced",
        duration: 47,
        exercises: [
            Exercise(name: "Barbell Bench Press", sets: 4, reps: "6-8", rest: "90s", intensity: 5, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Lat Pulldown", sets: 3, reps: "8-12", rest: "75s", intensity: 4, equipment: []),
            Exercise(name: "Overhead Press", sets: 3, reps: "8-10", rest: "75s", intensity: 4, equipment: ["Barbells"])
        ]
    ),

    Workout(
        name: "Upper Body Strength",
        bodyPartsWorked: ["Chest", "Lats", "Shoulders", "Biceps"],
        difficulty: "Advanced",
        duration: 50,
        exercises: [
            Exercise(name: "Incline Bench Press", sets: 4, reps: "6-8", rest: "90s", intensity: 5, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Pull-Up", sets: 4, reps: "6-8", rest: "90s", intensity: 5, equipment: []),
            Exercise(name: "Barbell Curl", sets: 3, reps: "8-10", rest: "60s", intensity: 3, equipment: ["Barbells"])
        ]
    ),

    Workout(
        name: "Upper Body Basics",
        bodyPartsWorked: ["Chest", "Lats", "Shoulders"],
        difficulty: "Beginner",
        duration: 38,
        exercises: [
            Exercise(name: "Incline Push-Up", sets: 3, reps: "12-20", rest: "45s", intensity: 2, equipment: ["Bench", "Mat"]),
            Exercise(name: "Resistance Band Pulldown", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: []),
            Exercise(name: "Lateral Raise", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Dumbbells"])
        ]
    ),

    Workout(
        name: "Push and Pull",
        bodyPartsWorked: ["Chest", "Lats", "Shoulders", "Rear Delts"],
        difficulty: "Intermediate",
        duration: 46,
        exercises: [
            Exercise(name: "Dumbbell Bench Press", sets: 4, reps: "8-10", rest: "75s", intensity: 4, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Wide Grip Lat Pulldown", sets: 4, reps: "8-12", rest: "75s", intensity: 4, equipment: []),
            Exercise(name: "Face Pull", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    Workout(
        name: "Upper Body Pump",
        bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"],
        difficulty: "Intermediate",
        duration: 44,
        exercises: [
            Exercise(name: "Machine Chest Press", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: []),
            Exercise(name: "Arnold Press", sets: 3, reps: "10-12", rest: "60s", intensity: 3, equipment: ["Dumbbells", "Bench"]),
            Exercise(name: "Cable Curl", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    ),

    Workout(
        name: "Upper Body Finisher",
        bodyPartsWorked: ["Chest", "Lats", "Shoulders", "Triceps"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Decline Bench Press", sets: 3, reps: "8-10", rest: "75s", intensity: 4, equipment: ["Barbells", "Bench"]),
            Exercise(name: "Chin-Up", sets: 3, reps: "6-10", rest: "75s", intensity: 4, equipment: []),
            Exercise(name: "Cable Lateral Raise", sets: 3, reps: "12-15", rest: "45s", intensity: 2, equipment: ["Cables"])
        ]
    )
]
