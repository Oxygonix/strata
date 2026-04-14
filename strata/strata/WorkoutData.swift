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
        Exercise(name: "Barbell Bench Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Incline Dumbbell Press", sets: 3, reps: "10-12", rest: "75s"),
        Exercise(name: "Chest Fly (Dumbbell or Cable)", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Push-up Burnout", sets: 2, reps: "AMRAP", rest: "60s")
    ]),
    Workout(name: "Chest Shred", bodyPartsWorked: ["Chest", "Triceps"], difficulty: "Advanced", duration: 45, exercises: [
        Exercise(name: "Barbell Bench Press", sets: 5, reps: "6-8", rest: "120s"),
        Exercise(name: "Incline Dumbbell Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Weighted Dips", sets: 3, reps: "8-10", rest: "90s"),
        Exercise(name: "Cable Fly (Slow Tempo)", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Push-up Drop Set", sets: 2, reps: "AMRAP", rest: "60s")
    ]),
    Workout(name: "Push Power", bodyPartsWorked: ["Chest", "Shoulders", "Triceps"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Push-ups", sets: 3, reps: "10-15", rest: "60s"),
        Exercise(name: "Dumbbell Bench Press", sets: 3, reps: "8-12", rest: "60s"),
        Exercise(name: "Incline Push-ups", sets: 2, reps: "10-12", rest: "45s")
    ]),
    Workout(name: "Upper Chest Pump", bodyPartsWorked: ["Chest", "Shoulders", "Triceps"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Incline Barbell Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Incline Dumbbell Fly", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Low-to-High Cable Fly", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Feet-Elevated Push-ups", sets: 2, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Chest Finisher", bodyPartsWorked: ["Chest", "Triceps", "Shoulders"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Barbell Bench Press", sets: 5, reps: "6-8", rest: "120s"),
        Exercise(name: "Incline Dumbbell Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Cable Crossovers", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Dumbbell Fly (Slow Eccentric)", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Dips", sets: 3, reps: "8-12", rest: "60s"),
        Exercise(name: "Push-up Burnout", sets: 2, reps: "AMRAP", rest: "60s")
    ]),

    // BACK WORKOUTS
    Workout(name: "Back Builder", bodyPartsWorked: ["Lats", "Rear Delts", "Traps", "Biceps"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Pull-ups", sets: 4, reps: "6-10", rest: "90s"),
        Exercise(name: "Barbell Rows", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Lat Pulldown (Wide Grip)", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Seated Cable Row", sets: 3, reps: "10-12", rest: "60s")
    ]),
    Workout(name: "Back Strength", bodyPartsWorked: ["Lats", "Rear Delts", "Traps", "Biceps"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Deadlifts", sets: 4, reps: "4-6", rest: "120s"),
        Exercise(name: "T-Bar Rows", sets: 4, reps: "6-10", rest: "90s"),
        Exercise(name: "Weighted Pull-ups", sets: 4, reps: "6-8", rest: "90s"),
        Exercise(name: "Chest-Supported Row", sets: 3, reps: "8-10", rest: "75s")
    ]),
    Workout(name: "Back Basics", bodyPartsWorked: ["Lats", "Rear Delts", "Biceps"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Assisted Pull-ups", sets: 3, reps: "6-10", rest: "60s"),
        Exercise(name: "Dumbbell Row (Light)", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Band Pull-Aparts", sets: 2, reps: "15-20", rest: "45s")
    ]),
    Workout(name: "Lats & Traps", bodyPartsWorked: ["Lats", "Traps", "Rear Delts"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Lat Pulldown (Neutral Grip)", sets: 4, reps: "10-12", rest: "60s"),
        Exercise(name: "One-Arm Dumbbell Row", sets: 3, reps: "10-12 each side", rest: "60s"),
        Exercise(name: "Dumbbell Shrugs", sets: 3, reps: "12-15", rest: "45s"),
        Exercise(name: "Face Pulls", sets: 3, reps: "12-15", rest: "60s")
    ]),
    Workout(name: "Pull Power", bodyPartsWorked: ["Lats", "Biceps", "Traps"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Weighted Pull-ups", sets: 4, reps: "5-8", rest: "90s"),
        Exercise(name: "Barbell Deadlift", sets: 4, reps: "4-6", rest: "120s"),
        Exercise(name: "Bent-Over Rows", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Cable Row (Slow Eccentric)", sets: 3, reps: "10-12", rest: "75s"),
        Exercise(name: "EZ-Bar Curl Finisher", sets: 3, reps: "10-12", rest: "60s")
    ]),

    // LEGS WORKOUTS
    Workout(name: "Leg Strength", bodyPartsWorked: ["Quads", "Hamstrings", "Glutes", "Calves"], difficulty: "Intermediate", duration: 50, exercises: [
        Exercise(name: "Barbell Squats", sets: 4, reps: "6-10", rest: "120s"),
        Exercise(name: "Leg Press", sets: 3, reps: "10-12", rest: "90s"),
        Exercise(name: "Romanian Deadlifts", sets: 3, reps: "8-10", rest: "90s"),
        Exercise(name: "Walking Lunges", sets: 3, reps: "10 per leg", rest: "60s"),
        Exercise(name: "Seated Calf Raises", sets: 3, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Leg Endurance", bodyPartsWorked: ["Quads", "Hamstrings", "Calves"], difficulty: "Beginner", duration: 40, exercises: [
        Exercise(name: "Bodyweight Squats", sets: 3, reps: "15-20", rest: "45s"),
        Exercise(name: "Walking Lunges", sets: 3, reps: "10 per leg", rest: "60s"),
        Exercise(name: "Glute Bridges", sets: 3, reps: "12-15", rest: "45s"),
        Exercise(name: "Standing Calf Raises", sets: 3, reps: "15-20", rest: "30s")
    ]),
    Workout(name: "Leg Power", bodyPartsWorked: ["Quads", "Hamstrings", "Glutes"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Barbell Squats", sets: 5, reps: "4-6", rest: "120s"),
        Exercise(name: "Romanian Deadlifts", sets: 4, reps: "6-8", rest: "120s"),
        Exercise(name: "Leg Press (Heavy)", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Bulgarian Split Squats", sets: 3, reps: "8 each leg", rest: "75s"),
        Exercise(name: "Standing Calf Raises", sets: 4, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Glute Builder", bodyPartsWorked: ["Glutes", "Hamstrings", "Quads"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Barbell Hip Thrusts", sets: 4, reps: "8-12", rest: "90s"),
        Exercise(name: "Bulgarian Split Squats", sets: 3, reps: "8-10 per leg", rest: "75s"),
        Exercise(name: "Step-Ups", sets: 3, reps: "10 per leg", rest: "60s"),
        Exercise(name: "Cable Kickbacks", sets: 3, reps: "12-15 per leg", rest: "45s")
    ]),
    Workout(name: "Leg Finisher", bodyPartsWorked: ["Quads", "Glutes", "Hamstrings", "Calves"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Front Squats", sets: 4, reps: "6-8", rest: "120s"),
        Exercise(name: "Deadlifts", sets: 4, reps: "5-6", rest: "120s"),
        Exercise(name: "Walking Lunges (Weighted)", sets: 3, reps: "12 per leg", rest: "60s"),
        Exercise(name: "Jump Squats", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Calf Raise Burnout", sets: 3, reps: "20-25", rest: "30s")
    ]),

    // ARMS WORKOUTS
    Workout(name: "Arm Builder", bodyPartsWorked: ["Biceps", "Triceps", "Forearms"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Barbell Curl", sets: 4, reps: "8-10", rest: "60s"),
        Exercise(name: "Tricep Dips", sets: 4, reps: "8-12", rest: "60s"),
        Exercise(name: "Hammer Curls", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Cable Rope Pushdowns", sets: 3, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Arm Sculpt", bodyPartsWorked: ["Biceps", "Triceps", "Forearms"], difficulty: "Advanced", duration: 45, exercises: [
        Exercise(name: "Barbell Curl (Heavy)", sets: 4, reps: "6-8", rest: "75s"),
        Exercise(name: "Skull Crushers", sets: 4, reps: "8-10", rest: "75s"),
        Exercise(name: "Preacher Curl", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Overhead Cable Tricep Extension", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Concentration Curl Burnout", sets: 2, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Arm Basics", bodyPartsWorked: ["Biceps", "Triceps", "Forearms"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Dumbbell Bicep Curls", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Tricep Kickbacks", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Assisted Bench Dips", sets: 3, reps: "8-10", rest: "60s"),
        Exercise(name: "Wrist Circles", sets: 2, reps: "30s", rest: "0s")
    ]),
    Workout(name: "Biceps Blast", bodyPartsWorked: ["Biceps", "Forearms"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "EZ-Bar Curl", sets: 4, reps: "8-10", rest: "60s"),
        Exercise(name: "Incline Dumbbell Curl", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Hammer Curl", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Cable Curl (Slow Eccentric)", sets: 3, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Triceps Finisher", bodyPartsWorked: ["Triceps", "Forearms"], difficulty: "Advanced", duration: 45, exercises: [
        Exercise(name: "Close-Grip Bench Press", sets: 4, reps: "6-8", rest: "90s"),
        Exercise(name: "Weighted Dips", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Rope Pushdowns", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Overhead Dumbbell Extension", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Bench Dip Burnout", sets: 2, reps: "AMRAP", rest: "45s")
    ]),

    // CORE WORKOUTS
    Workout(name: "Core Crusher", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Intermediate", duration: 35, exercises: [
        Exercise(name: "Plank", sets: 3, reps: "45s", rest: "30s"),
        Exercise(name: "Russian Twists", sets: 3, reps: "20 reps", rest: "30s"),
        Exercise(name: "Lying Leg Raises", sets: 3, reps: "12-15", rest: "30s"),
        Exercise(name: "Mountain Climbers", sets: 3, reps: "30s", rest: "30s")
    ]),
    Workout(name: "Core Strength", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Advanced", duration: 40, exercises: [
        Exercise(name: "Weighted Plank", sets: 3, reps: "30-45s", rest: "30s"),
        Exercise(name: "Hanging Leg Raises", sets: 4, reps: "10-15", rest: "45s"),
        Exercise(name: "Ab Wheel Rollouts", sets: 3, reps: "8-12", rest: "60s"),
        Exercise(name: "Cable Woodchoppers", sets: 3, reps: "12 each side", rest: "45s")
    ]),
    Workout(name: "Core Basics", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Beginner", duration: 30, exercises: [
        Exercise(name: "Knee Plank", sets: 3, reps: "30s", rest: "30s"),
        Exercise(name: "Crunches", sets: 3, reps: "12-15", rest: "30s"),
        Exercise(name: "Dead Bug", sets: 3, reps: "10 per side", rest: "30s"),
        Exercise(name: "Seated Torso Twist", sets: 2, reps: "15-20", rest: "0s")
    ]),
    Workout(name: "Abs & Obliques", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Intermediate", duration: 35, exercises: [
        Exercise(name: "Side Plank", sets: 3, reps: "30s each side", rest: "30s"),
        Exercise(name: "Bicycle Crunches", sets: 3, reps: "20 reps", rest: "30s"),
        Exercise(name: "Hanging Knee Raises", sets: 3, reps: "10-12", rest: "45s"),
        Exercise(name: "Heel Taps", sets: 3, reps: "20 reps", rest: "30s")
    ]),
    Workout(name: "Full Core Blast", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Advanced", duration: 45, exercises: [
        Exercise(name: "Plank with Shoulder Tap", sets: 4, reps: "20 taps", rest: "30s"),
        Exercise(name: "Hanging Knee Raises", sets: 4, reps: "10-12", rest: "30s"),
        Exercise(name: "Ab Rollouts", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Russian Twist (Weighted)", sets: 3, reps: "20 reps", rest: "30s"),
        Exercise(name: "V-Ups Finisher", sets: 2, reps: "AMRAP", rest: "45s")
    ]),

    // FULL BODY WORKOUTS
    Workout(name: "Full Body Burn", bodyPartsWorked: ["Chest", "Quads", "Glutes", "Lats", "Biceps", "Triceps", "Shoulders", "Abs"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Burpees", sets: 4, reps: "10-12", rest: "60s"),
        Exercise(name: "Push-ups", sets: 4, reps: "12-15", rest: "60s"),
        Exercise(name: "Squat Jumps", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Dumbbell Thrusters", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Mountain Climbers", sets: 3, reps: "30-40s", rest: "30s")
    ]),
    Workout(name: "Total Body Strength", bodyPartsWorked: ["Chest", "Quads", "Glutes", "Lats", "Biceps", "Triceps", "Shoulders", "Abs"], difficulty: "Intermediate", duration: 50, exercises: [
        Exercise(name: "Deadlifts", sets: 4, reps: "5-6", rest: "120s"),
        Exercise(name: "Bench Press", sets: 4, reps: "6-10", rest: "90s"),
        Exercise(name: "Pull-ups", sets: 3, reps: "6-10", rest: "90s"),
        Exercise(name: "Goblet Squats", sets: 3, reps: "10-12", rest: "75s")
    ]),
    Workout(name: "Bodyweight Blast", bodyPartsWorked: ["Chest", "Quads", "Glutes", "Abs"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Push-ups", sets: 3, reps: "10-15", rest: "45s"),
        Exercise(name: "Bodyweight Squats", sets: 3, reps: "15-20", rest: "45s"),
        Exercise(name: "Glute Bridges", sets: 3, reps: "12-15", rest: "45s"),
        Exercise(name: "Plank", sets: 3, reps: "30-45s", rest: "30s")
    ]),
    Workout(name: "Cardio Strength", bodyPartsWorked: ["Quads", "Glutes", "Abs"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Jumping Jacks", sets: 3, reps: "50", rest: "30s"),
        Exercise(name: "Walking Lunges", sets: 3, reps: "12 per leg", rest: "60s"),
        Exercise(name: "Push-ups", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Mountain Climbers", sets: 3, reps: "30s", rest: "30s")
    ]),
    Workout(name: "Total Body Finisher", bodyPartsWorked: ["Chest", "Quads", "Glutes", "Lats", "Biceps", "Triceps", "Shoulders", "Abs"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Deadlifts", sets: 4, reps: "5-6", rest: "120s"),
        Exercise(name: "Pull-ups", sets: 4, reps: "6-10", rest: "90s"),
        Exercise(name: "Bench Press", sets: 4, reps: "6-8", rest: "90s"),
        Exercise(name: "Walking Lunges (Weighted)", sets: 3, reps: "12 per leg", rest: "60s"),
        Exercise(name: "Burpee Finisher", sets: 2, reps: "AMRAP", rest: "60s")
    ]),

    // UPPER BODY WORKOUTS
    Workout(name: "Upper Body Blast", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Bench Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Pull-ups", sets: 3, reps: "6-10", rest: "90s"),
        Exercise(name: "Incline Dumbbell Press", sets: 3, reps: "10-12", rest: "75s"),
        Exercise(name: "Seated Cable Row", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Lateral Raises", sets: 3, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Upper Body Strength", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Incline Bench Press", sets: 4, reps: "5-8", rest: "90s"),
        Exercise(name: "Barbell Rows", sets: 4, reps: "6-10", rest: "90s"),
        Exercise(name: "Overhead Press", sets: 4, reps: "6-8", rest: "75s"),
        Exercise(name: "Weighted Pull-ups", sets: 3, reps: "6-8", rest: "90s"),
        Exercise(name: "EZ-Bar Curls", sets: 3, reps: "8-10", rest: "60s")
    ]),
    Workout(name: "Upper Body Basics", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Push-ups", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Dumbbell Rows", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Dumbbell Shoulder Press (Light)", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Arm Circles", sets: 2, reps: "30s", rest: "0s")
    ]),
    Workout(name: "Push & Pull", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Incline Bench Press", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Barbell Row", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Dumbbell Shoulder Press", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Hammer Curls", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Tricep Rope Pushdowns", sets: 3, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Upper Body Finisher", bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"], difficulty: "Advanced", duration: 50, exercises: [
        Exercise(name: "Weighted Pull-ups", sets: 4, reps: "6-8", rest: "90s"),
        Exercise(name: "Incline Bench Press", sets: 4, reps: "6-8", rest: "90s"),
        Exercise(name: "Arnold Press", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Cable Fly", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Arm Finisher Superset (Curl + Pushdown)", sets: 2, reps: "12-15", rest: "45s")
    ]),
    
    // ADDITIONAL MUSCLE-GROUP TARGETED WORKOUTS
    Workout(name: "Trap Dominance", bodyPartsWorked: ["Traps", "Rear Delts", "Lats"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Barbell Shrugs", sets: 4, reps: "8-10", rest: "75s"),
        Exercise(name: "Dumbbell Shrugs (Pause at Top)", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Face Pulls", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Farmer's Carries", sets: 3, reps: "40s", rest: "60s")
    ]),
    Workout(name: "Lat Isolation Flow", bodyPartsWorked: ["Lats", "Biceps", "Rear Delts"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Straight-Arm Pulldown", sets: 4, reps: "10-12", rest: "60s"),
        Exercise(name: "Single-Arm Lat Pulldown", sets: 3, reps: "10-12 each side", rest: "60s"),
        Exercise(name: "Chest-Supported Row", sets: 3, reps: "8-12", rest: "90s"),
        Exercise(name: "Cable Lat Stretch Hold", sets: 2, reps: "30s", rest: "30s")
    ]),
    Workout(name: "Shoulder Complete", bodyPartsWorked: ["Shoulders", "Rear Delts", "Traps"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Overhead Press", sets: 4, reps: "6-10", rest: "90s"),
        Exercise(name: "Lateral Raises", sets: 4, reps: "12-15", rest: "45s"),
        Exercise(name: "Rear Delt Fly", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Arnold Press", sets: 3, reps: "8-12", rest: "75s")
    ]),
    Workout(name: "Arm Isolation Focus", bodyPartsWorked: ["Biceps", "Triceps", "Forearms"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Incline Dumbbell Curl", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "EZ Bar Skull Crushers", sets: 3, reps: "8-12", rest: "60s"),
        Exercise(name: "Hammer Curls", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Rope Pushdowns", sets: 3, reps: "12-15", rest: "45s"),
        Exercise(name: "Wrist Curls + Reverse Wrist Curls", sets: 2, reps: "12-15", rest: "45s")
    ]),
    Workout(name: "Core Oblique Burner", bodyPartsWorked: ["Abs", "Obliques"], difficulty: "Intermediate", duration: 35, exercises: [
        Exercise(name: "Side Plank Dips", sets: 3, reps: "12 each side", rest: "30s"),
        Exercise(name: "Russian Twists (Weighted)", sets: 4, reps: "20 reps", rest: "30s"),
        Exercise(name: "Cable Woodchoppers", sets: 3, reps: "12 each side", rest: "45s"),
        Exercise(name: "Plank Hip Dips", sets: 3, reps: "15 reps", rest: "30s")
    ]),
    Workout(name: "Quad & Adductor Strength", bodyPartsWorked: ["Quads", "Adductors"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Sumo Squats", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Leg Extensions", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Cossack Squats", sets: 3, reps: "8-10 each side", rest: "60s"),
        Exercise(name: "Side Lunges", sets: 3, reps: "10 each side", rest: "60s")
    ]),
    Workout(name: "Hamstring & Glute Builder", bodyPartsWorked: ["Hamstrings", "Glutes"], difficulty: "Intermediate", duration: 50, exercises: [
        Exercise(name: "Romanian Deadlifts", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Hip Thrusts", sets: 4, reps: "8-12", rest: "90s"),
        Exercise(name: "Hamstring Curls", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Bulgarian Split Squats", sets: 3, reps: "8-10 each leg", rest: "75s")
    ]),
    Workout(name: "Glute & Abductor Sculpt", bodyPartsWorked: ["Glutes", "Abductors"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Lateral Band Walks", sets: 3, reps: "15 steps each way", rest: "45s"),
        Exercise(name: "Glute Bridges", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Clamshells", sets: 3, reps: "15 each side", rest: "30s"),
        Exercise(name: "Standing Hip Abductions", sets: 2, reps: "12-15 each leg", rest: "30s")
    ]),
    Workout(name: "Calf Destroyer", bodyPartsWorked: ["Calves"], difficulty: "Beginner", duration: 25, exercises: [
        Exercise(name: "Standing Calf Raises", sets: 4, reps: "15-20", rest: "30s"),
        Exercise(name: "Seated Calf Raises", sets: 3, reps: "12-15", rest: "45s"),
        Exercise(name: "Single-Leg Calf Raises", sets: 3, reps: "10 each leg", rest: "30s"),
        Exercise(name: "Jump Rope", sets: 3, reps: "45s", rest: "30s")
    ]),
    Workout(name: "Forearm Strength Circuit", bodyPartsWorked: ["Forearms", "Biceps"], difficulty: "Beginner", duration: 30, exercises: [
        Exercise(name: "Farmer's Carries", sets: 4, reps: "40s", rest: "60s"),
        Exercise(name: "Reverse Curls", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Wrist Roller", sets: 3, reps: "Up & Down", rest: "60s"),
        Exercise(name: "Dead Hang", sets: 3, reps: "30-45s", rest: "60s")
    ]),
    Workout(name: "Full Posterior Chain", bodyPartsWorked: ["Hamstrings", "Glutes", "Lats", "Traps", "Rear Delts"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Deadlifts", sets: 4, reps: "5-6", rest: "120s"),
        Exercise(name: "Barbell Rows", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Face Pulls", sets: 3, reps: "12-15", rest: "60s"),
        Exercise(name: "Hip Thrusts", sets: 3, reps: "8-10", rest: "90s"),
        Exercise(name: "Back Extensions", sets: 3, reps: "12-15", rest: "60s")
    ]),
    
    // ADDUCTOR & ABDUCTOR SPECIALIZATION WORKOUTS
    Workout(name: "Adductor Strength Base", bodyPartsWorked: ["Adductors", "Quads", "Glutes"], difficulty: "Beginner", duration: 35, exercises: [
        Exercise(name: "Sumo Squats", sets: 4, reps: "10-12", rest: "60s"),
        Exercise(name: "Side Lunges", sets: 3, reps: "10 each side", rest: "60s"),
        Exercise(name: "Adductor Machine", sets: 3, reps: "12-15", rest: "45s"),
        Exercise(name: "Wide-Stance Wall Sit", sets: 2, reps: "30-45s", rest: "45s")
    ]),
    Workout(name: "Abductor Activation Flow", bodyPartsWorked: ["Abductors", "Glutes"], difficulty: "Beginner", duration: 30, exercises: [
        Exercise(name: "Lateral Band Walks", sets: 3, reps: "15 steps each way", rest: "45s"),
        Exercise(name: "Clamshells", sets: 3, reps: "15 each side", rest: "30s"),
        Exercise(name: "Standing Hip Abductions", sets: 3, reps: "12-15 each leg", rest: "30s"),
        Exercise(name: "Glute Bridge Hold (Band)", sets: 2, reps: "30-40s", rest: "45s")
    ]),
    Workout(name: "Inner Thigh Burnout", bodyPartsWorked: ["Adductors", "Hamstrings"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Cossack Squats", sets: 4, reps: "8-10 each side", rest: "60s"),
        Exercise(name: "Cable Adductions", sets: 3, reps: "12-15 each leg", rest: "45s"),
        Exercise(name: "Wide-Stance Goblet Squats", sets: 3, reps: "10-12", rest: "60s"),
        Exercise(name: "Side-Lying Adduction", sets: 3, reps: "12-15 each side", rest: "45s")
    ]),
    Workout(name: "Outer Hip Sculpt", bodyPartsWorked: ["Abductors", "Glutes"], difficulty: "Intermediate", duration: 40, exercises: [
        Exercise(name: "Cable Hip Abductions", sets: 4, reps: "12-15 each leg", rest: "45s"),
        Exercise(name: "Side-Lying Leg Raises", sets: 3, reps: "15-20", rest: "30s"),
        Exercise(name: "Monster Walks", sets: 3, reps: "20 steps", rest: "45s"),
        Exercise(name: "Frog Pumps", sets: 3, reps: "15-20", rest: "45s")
    ]),
    Workout(name: "Athletic Hip Stability", bodyPartsWorked: ["Adductors", "Abductors", "Glutes"], difficulty: "Intermediate", duration: 45, exercises: [
        Exercise(name: "Lateral Lunges", sets: 3, reps: "10 each side", rest: "60s"),
        Exercise(name: "Skater Squats", sets: 3, reps: "8-10 each side", rest: "60s"),
        Exercise(name: "Resistance Band Walks", sets: 3, reps: "20 steps", rest: "45s"),
        Exercise(name: "Single-Leg Glute Bridge", sets: 3, reps: "10-12 each side", rest: "45s")
    ]),
    Workout(name: "Inner & Outer Hip Combo", bodyPartsWorked: ["Adductors", "Abductors", "Glutes"], difficulty: "Advanced", duration: 55, exercises: [
        Exercise(name: "Sumo Squats", sets: 4, reps: "8-10", rest: "90s"),
        Exercise(name: "Lateral Band Walks", sets: 4, reps: "20 steps", rest: "45s"),
        Exercise(name: "Cable Adduction + Abduction Superset", sets: 3, reps: "12 each direction", rest: "60s"),
        Exercise(name: "Bulgarian Split Squats (Wide Stance)", sets: 3, reps: "8-10 each leg", rest: "75s"),
        Exercise(name: "Isometric Wall Sit (Wide Stance)", sets: 2, reps: "45-60s", rest: "60s")
    ]),
    Workout(name: "Hip Mobility & Control", bodyPartsWorked: ["Adductors", "Abductors"], difficulty: "Beginner", duration: 25, exercises: [
        Exercise(name: "Hip Openers", sets: 3, reps: "30s each side", rest: "30s"),
        Exercise(name: "Cossack Squat (Assisted)", sets: 3, reps: "8 each side", rest: "45s"),
        Exercise(name: "Standing Leg Swings", sets: 3, reps: "15 each leg", rest: "30s"),
        Exercise(name: "Deep Squat Hold", sets: 2, reps: "30-45s", rest: "30s")
    ])
]
