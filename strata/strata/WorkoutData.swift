//
//  WorkoutData.swift
//  strata
//
//  Created by Sanjana Madhav on 4/7/26.
//

import Foundation

let workouts: [Workout] = [
    
    // CHEST WORKOUTS
    Workout(
        name: "Chest Builder",
        bodyPartsWorked: ["Chest", "Triceps"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Barbell Bench Press", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Incline Dumbbell Press", sets: 3, reps: "10-12", rest: "75s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Chest Fly (Dumbbell or Cable)", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Dumbbells", "Cables"]),
            Exercise(name: "Push-up Burnout", sets: 2, reps: "AMRAP", rest: "60s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Dumbbells", "Cables", "Mat"]
    ),
    Workout(
        name: "Chest Shred",
        bodyPartsWorked: ["Chest", "Triceps"],
        difficulty: "Advanced",
        duration: 45,
        exercises: [
            Exercise(name: "Barbell Bench Press", sets: 5, reps: "6-8", rest: "120s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Incline Dumbbell Press", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Weighted Dips", sets: 3, reps: "8-10", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Cable Fly (Slow Tempo)", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Push-up Drop Set", sets: 2, reps: "AMRAP", rest: "60s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Dumbbells", "Machine", "Cables", "Mat"]
    ),
    Workout(
        name: "Push Power",
        bodyPartsWorked: ["Chest", "Shoulders", "Triceps"],
        difficulty: "Beginner",
        duration: 35,
        exercises: [
            Exercise(name: "Push-ups", sets: 3, reps: "10-15", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Dumbbell Bench Press", sets: 3, reps: "8-12", rest: "60s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Incline Push-ups", sets: 2, reps: "10-12", rest: "45s", equipmentUsed: ["Bench"])
        ],
        equipmentUsed: ["Mat", "Dumbbells", "Bench"]
    ),
    Workout(
        name: "Upper Chest Pump",
        bodyPartsWorked: ["Chest", "Shoulders", "Triceps"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Incline Barbell Press", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Incline Dumbbell Fly", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Low-to-High Cable Fly", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Feet-Elevated Push-ups", sets: 2, reps: "12-15", rest: "45s", equipmentUsed: ["Bench"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Dumbbells", "Cables"]
    ),
    Workout(
        name: "Chest Finisher",
        bodyPartsWorked: ["Chest", "Triceps", "Shoulders"],
        difficulty: "Advanced",
        duration: 50,
        exercises: [
            Exercise(name: "Barbell Bench Press", sets: 5, reps: "6-8", rest: "120s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Incline Dumbbell Press", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Cable Crossovers", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Dumbbell Fly (Slow Eccentric)", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Dips", sets: 3, reps: "8-12", rest: "60s", equipmentUsed: ["Machine"]),
            Exercise(name: "Push-up Burnout", sets: 2, reps: "AMRAP", rest: "60s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Dumbbells", "Cables", "Machine", "Mat"]
    ),

    // BACK WORKOUTS
    Workout(
        name: "Back Builder",
        bodyPartsWorked: ["Lats", "Rear Delts", "Traps", "Biceps"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Pull-ups", sets: 4, reps: "6-10", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Barbell Rows", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Lat Pulldown (Wide Grip)", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Seated Cable Row", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Machine", "Barbell", "Cables"]
    ),
    Workout(
        name: "Back Strength",
        bodyPartsWorked: ["Lats", "Rear Delts", "Traps", "Biceps"],
        difficulty: "Advanced",
        duration: 50,
        exercises: [
            Exercise(name: "Deadlifts", sets: 4, reps: "4-6", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "T-Bar Rows", sets: 4, reps: "6-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Weighted Pull-ups", sets: 4, reps: "6-8", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Chest-Supported Row", sets: 3, reps: "8-10", rest: "75s", equipmentUsed: ["Machine", "Bench"])
        ],
        equipmentUsed: ["Barbell", "Machine", "Bench"]
    ),
    Workout(
        name: "Back Basics",
        bodyPartsWorked: ["Lats", "Rear Delts", "Biceps"],
        difficulty: "Beginner",
        duration: 35,
        exercises: [
            Exercise(name: "Assisted Pull-ups", sets: 3, reps: "6-10", rest: "60s", equipmentUsed: ["Machine"]),
            Exercise(name: "Dumbbell Row (Light)", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Band Pull-Aparts", sets: 2, reps: "15-20", rest: "45s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Machine", "Dumbbells", "Bench", "Cables"]
    ),
    Workout(
        name: "Lats & Traps",
        bodyPartsWorked: ["Lats", "Traps", "Rear Delts"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Lat Pulldown (Neutral Grip)", sets: 4, reps: "10-12", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "One-Arm Dumbbell Row", sets: 3, reps: "10-12 each side", rest: "60s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Dumbbell Shrugs", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Face Pulls", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Cables", "Dumbbells", "Bench"]
    ),
    Workout(
        name: "Pull Power",
        bodyPartsWorked: ["Lats", "Biceps", "Traps"],
        difficulty: "Advanced",
        duration: 55,
        exercises: [
            Exercise(name: "Weighted Pull-ups", sets: 4, reps: "5-8", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Barbell Deadlift", sets: 4, reps: "4-6", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Bent-Over Rows", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Cable Row (Slow Eccentric)", sets: 3, reps: "10-12", rest: "75s", equipmentUsed: ["Cables"]),
            Exercise(name: "EZ-Bar Curl Finisher", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Barbell"])
        ],
        equipmentUsed: ["Machine", "Barbell", "Cables"]
    ),

    // LEGS WORKOUTS
    Workout(
        name: "Leg Strength",
        bodyPartsWorked: ["Quads", "Hamstrings", "Glutes", "Calves"],
        difficulty: "Intermediate",
        duration: 50,
        exercises: [
            Exercise(name: "Barbell Squats", sets: 4, reps: "6-10", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Leg Press", sets: 3, reps: "10-12", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Romanian Deadlifts", sets: 3, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Walking Lunges", sets: 3, reps: "10 per leg", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Seated Calf Raises", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Machine"])
        ],
        equipmentUsed: ["Barbell", "Machine", "Dumbbells"]
    ),
    Workout(
        name: "Leg Endurance",
        bodyPartsWorked: ["Quads", "Hamstrings", "Calves"],
        difficulty: "Beginner",
        duration: 40,
        exercises: [
            Exercise(name: "Bodyweight Squats", sets: 3, reps: "15-20", rest: "45s", equipmentUsed: ["Mat"]),
            Exercise(name: "Walking Lunges", sets: 3, reps: "10 per leg", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Glute Bridges", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Mat"]),
            Exercise(name: "Standing Calf Raises", sets: 3, reps: "15-20", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat"]
    ),
    Workout(
        name: "Leg Power",
        bodyPartsWorked: ["Quads", "Hamstrings", "Glutes"],
        difficulty: "Advanced",
        duration: 55,
        exercises: [
            Exercise(name: "Barbell Squats", sets: 5, reps: "4-6", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Romanian Deadlifts", sets: 4, reps: "6-8", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Leg Press (Heavy)", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Bulgarian Split Squats", sets: 3, reps: "8 each leg", rest: "75s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Standing Calf Raises", sets: 4, reps: "12-15", rest: "45s", equipmentUsed: ["Machine"])
        ],
        equipmentUsed: ["Barbell", "Machine", "Dumbbells", "Bench"]
    ),
    Workout(
        name: "Glute Builder",
        bodyPartsWorked: ["Glutes", "Hamstrings", "Quads"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Barbell Hip Thrusts", sets: 4, reps: "8-12", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Bulgarian Split Squats", sets: 3, reps: "8-10 per leg", rest: "75s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Step-Ups", sets: 3, reps: "10 per leg", rest: "60s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Cable Kickbacks", sets: 3, reps: "12-15 per leg", rest: "45s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Dumbbells", "Cables"]
    ),
    Workout(
        name: "Leg Finisher",
        bodyPartsWorked: ["Quads", "Glutes", "Hamstrings", "Calves"],
        difficulty: "Advanced",
        duration: 50,
        exercises: [
            Exercise(name: "Front Squats", sets: 4, reps: "6-8", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Deadlifts", sets: 4, reps: "5-6", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Walking Lunges (Weighted)", sets: 3, reps: "12 per leg", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Jump Squats", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Calf Raise Burnout", sets: 3, reps: "20-25", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Barbell", "Dumbbells", "Mat"]
    ),

    // ARMS WORKOUTS
    Workout(
        name: "Arm Builder",
        bodyPartsWorked: ["Biceps", "Triceps", "Forearms"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Barbell Curl", sets: 4, reps: "8-10", rest: "60s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Tricep Dips", sets: 4, reps: "8-12", rest: "60s", equipmentUsed: ["Bench"]),
            Exercise(name: "Hammer Curls", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Cable Rope Pushdowns", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Dumbbells", "Cables"]
    ),
    Workout(
        name: "Arm Sculpt",
        bodyPartsWorked: ["Biceps", "Triceps", "Forearms"],
        difficulty: "Advanced",
        duration: 45,
        exercises: [
            Exercise(name: "Barbell Curl (Heavy)", sets: 4, reps: "6-8", rest: "75s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Skull Crushers", sets: 4, reps: "8-10", rest: "75s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Preacher Curl", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Machine"]),
            Exercise(name: "Overhead Cable Tricep Extension", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Concentration Curl Burnout", sets: 2, reps: "12-15", rest: "45s", equipmentUsed: ["Dumbbells"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Machine", "Cables", "Dumbbells"]
    ),
    Workout(
        name: "Arm Basics",
        bodyPartsWorked: ["Biceps", "Triceps", "Forearms"],
        difficulty: "Beginner",
        duration: 35,
        exercises: [
            Exercise(name: "Dumbbell Bicep Curls", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Tricep Kickbacks", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Assisted Bench Dips", sets: 3, reps: "8-10", rest: "60s", equipmentUsed: ["Bench"]),
            Exercise(name: "Wrist Circles", sets: 2, reps: "30s", rest: "0s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Dumbbells", "Bench", "Mat"]
    ),
    Workout(
        name: "Biceps Blast",
        bodyPartsWorked: ["Biceps", "Forearms"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "EZ-Bar Curl", sets: 4, reps: "8-10", rest: "60s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Incline Dumbbell Curl", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Hammer Curl", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Cable Curl (Slow Eccentric)", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Barbell", "Dumbbells", "Bench", "Cables"]
    ),
    Workout(
        name: "Triceps Finisher",
        bodyPartsWorked: ["Triceps", "Forearms"],
        difficulty: "Advanced",
        duration: 45,
        exercises: [
            Exercise(name: "Close-Grip Bench Press", sets: 4, reps: "6-8", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Weighted Dips", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Rope Pushdowns", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Overhead Dumbbell Extension", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Bench Dip Burnout", sets: 2, reps: "AMRAP", rest: "45s", equipmentUsed: ["Bench"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Machine", "Cables", "Dumbbells"]
    ),

    // CORE WORKOUTS
    Workout(
        name: "Core Crusher",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Intermediate",
        duration: 35,
        exercises: [
            Exercise(name: "Plank", sets: 3, reps: "45s", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Russian Twists", sets: 3, reps: "20 reps", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Lying Leg Raises", sets: 3, reps: "12-15", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Mountain Climbers", sets: 3, reps: "30s", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat"]
    ),
    Workout(
        name: "Core Strength",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Advanced",
        duration: 40,
        exercises: [
            Exercise(name: "Weighted Plank", sets: 3, reps: "30-45s", rest: "30s", equipmentUsed: ["Mat", "Dumbbells"]),
            Exercise(name: "Hanging Leg Raises", sets: 4, reps: "10-15", rest: "45s", equipmentUsed: ["Machine"]),
            Exercise(name: "Ab Wheel Rollouts", sets: 3, reps: "8-12", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Cable Woodchoppers", sets: 3, reps: "12 each side", rest: "45s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Mat", "Dumbbells", "Machine", "Cables"]
    ),
    Workout(
        name: "Core Basics",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Beginner",
        duration: 30,
        exercises: [
            Exercise(name: "Knee Plank", sets: 3, reps: "30s", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Crunches", sets: 3, reps: "12-15", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Dead Bug", sets: 3, reps: "10 per side", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Seated Torso Twist", sets: 2, reps: "15-20", rest: "0s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat"]
    ),
    Workout(
        name: "Abs & Obliques",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Intermediate",
        duration: 35,
        exercises: [
            Exercise(name: "Side Plank", sets: 3, reps: "30s each side", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Bicycle Crunches", sets: 3, reps: "20 reps", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Hanging Knee Raises", sets: 3, reps: "10-12", rest: "45s", equipmentUsed: ["Machine"]),
            Exercise(name: "Heel Taps", sets: 3, reps: "20 reps", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat", "Machine"]
    ),
    Workout(
        name: "Full Core Blast",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Advanced",
        duration: 45,
        exercises: [
            Exercise(name: "Plank with Shoulder Tap", sets: 4, reps: "20 taps", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Hanging Knee Raises", sets: 4, reps: "10-12", rest: "30s", equipmentUsed: ["Machine"]),
            Exercise(name: "Ab Rollouts", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Russian Twist (Weighted)", sets: 3, reps: "20 reps", rest: "30s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "V-Ups Finisher", sets: 2, reps: "AMRAP", rest: "45s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat", "Machine", "Dumbbells"]
    ),

    // FULL BODY WORKOUTS
    Workout(
        name: "Full Body Burn",
        bodyPartsWorked: ["Chest", "Quads", "Glutes", "Lats", "Biceps", "Triceps", "Shoulders", "Abs"],
        difficulty: "Advanced",
        duration: 55,
        exercises: [
            Exercise(name: "Burpees", sets: 4, reps: "10-12", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Push-ups", sets: 4, reps: "12-15", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Squat Jumps", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Dumbbell Thrusters", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Mountain Climbers", sets: 3, reps: "30-40s", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat", "Dumbbells"]
    ),
    Workout(
        name: "Total Body Strength",
        bodyPartsWorked: ["Chest", "Quads", "Glutes", "Lats", "Biceps", "Triceps", "Shoulders", "Abs"],
        difficulty: "Intermediate",
        duration: 50,
        exercises: [
            Exercise(name: "Deadlifts", sets: 4, reps: "5-6", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Bench Press", sets: 4, reps: "6-10", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Pull-ups", sets: 3, reps: "6-10", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Goblet Squats", sets: 3, reps: "10-12", rest: "75s", equipmentUsed: ["Dumbbells"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Machine", "Dumbbells"]
    ),
    Workout(
        name: "Bodyweight Blast",
        bodyPartsWorked: ["Chest", "Quads", "Glutes", "Abs"],
        difficulty: "Beginner",
        duration: 35,
        exercises: [
            Exercise(name: "Push-ups", sets: 3, reps: "10-15", rest: "45s", equipmentUsed: ["Mat"]),
            Exercise(name: "Bodyweight Squats", sets: 3, reps: "15-20", rest: "45s", equipmentUsed: ["Mat"]),
            Exercise(name: "Glute Bridges", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Mat"]),
            Exercise(name: "Plank", sets: 3, reps: "30-45s", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat"]
    ),
    Workout(
        name: "Cardio Strength",
        bodyPartsWorked: ["Quads", "Glutes", "Abs"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Jumping Jacks", sets: 3, reps: "50", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Walking Lunges", sets: 3, reps: "12 per leg", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Push-ups", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Mountain Climbers", sets: 3, reps: "30s", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat", "Dumbbells"]
    ),
    Workout(
        name: "Total Body Finisher",
        bodyPartsWorked: ["Chest", "Quads", "Glutes", "Lats", "Biceps", "Triceps", "Shoulders", "Abs"],
        difficulty: "Advanced",
        duration: 55,
        exercises: [
            Exercise(name: "Deadlifts", sets: 4, reps: "5-6", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Pull-ups", sets: 4, reps: "6-10", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Bench Press", sets: 4, reps: "6-8", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Walking Lunges (Weighted)", sets: 3, reps: "12 per leg", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Burpee Finisher", sets: 2, reps: "AMRAP", rest: "60s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Barbell", "Machine", "Bench", "Dumbbells", "Mat"]
    ),

    // UPPER BODY WORKOUTS
    Workout(
        name: "Upper Body Blast",
        bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Bench Press", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Pull-ups", sets: 3, reps: "6-10", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Incline Dumbbell Press", sets: 3, reps: "10-12", rest: "75s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Seated Cable Row", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Lateral Raises", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Dumbbells"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Machine", "Dumbbells", "Cables"]
    ),
    Workout(
        name: "Upper Body Strength",
        bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"],
        difficulty: "Advanced",
        duration: 50,
        exercises: [
            Exercise(name: "Incline Bench Press", sets: 4, reps: "5-8", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Barbell Rows", sets: 4, reps: "6-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Overhead Press", sets: 4, reps: "6-8", rest: "75s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Weighted Pull-ups", sets: 3, reps: "6-8", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "EZ-Bar Curls", sets: 3, reps: "8-10", rest: "60s", equipmentUsed: ["Barbell"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Machine"]
    ),
    Workout(
        name: "Upper Body Basics",
        bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"],
        difficulty: "Beginner",
        duration: 35,
        exercises: [
            Exercise(name: "Push-ups", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Dumbbell Rows", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Dumbbell Shoulder Press (Light)", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Arm Circles", sets: 2, reps: "30s", rest: "0s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat", "Dumbbells", "Bench"]
    ),
    Workout(
        name: "Push & Pull",
        bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Incline Bench Press", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Barbell Row", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Dumbbell Shoulder Press", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Hammer Curls", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Tricep Rope Pushdowns", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Dumbbells", "Cables"]
    ),
    Workout(
        name: "Upper Body Finisher",
        bodyPartsWorked: ["Chest", "Shoulders", "Biceps", "Triceps"],
        difficulty: "Advanced",
        duration: 50,
        exercises: [
            Exercise(name: "Weighted Pull-ups", sets: 4, reps: "6-8", rest: "90s", equipmentUsed: ["Machine"]),
            Exercise(name: "Incline Bench Press", sets: 4, reps: "6-8", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Arnold Press", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Cable Fly", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Arm Finisher Superset (Curl + Pushdown)", sets: 2, reps: "12-15", rest: "45s", equipmentUsed: ["Dumbbells", "Cables"])
        ],
        equipmentUsed: ["Machine", "Barbell", "Bench", "Dumbbells", "Cables"]
    ),

    // ADDITIONAL MUSCLE-GROUP TARGETED WORKOUTS
    Workout(
        name: "Trap Dominance",
        bodyPartsWorked: ["Traps", "Rear Delts", "Lats"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Barbell Shrugs", sets: 4, reps: "8-10", rest: "75s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Dumbbell Shrugs (Pause at Top)", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Face Pulls", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Farmer's Carries", sets: 3, reps: "40s", rest: "60s", equipmentUsed: ["Dumbbells"])
        ],
        equipmentUsed: ["Barbell", "Dumbbells", "Cables"]
    ),
    Workout(
        name: "Lat Isolation Flow",
        bodyPartsWorked: ["Lats", "Biceps", "Rear Delts"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Straight-Arm Pulldown", sets: 4, reps: "10-12", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Single-Arm Lat Pulldown", sets: 3, reps: "10-12 each side", rest: "60s", equipmentUsed: ["Machine"]),
            Exercise(name: "Chest-Supported Row", sets: 3, reps: "8-12", rest: "90s", equipmentUsed: ["Machine", "Bench"]),
            Exercise(name: "Cable Lat Stretch Hold", sets: 2, reps: "30s", rest: "30s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Cables", "Machine", "Bench"]
    ),
    Workout(
        name: "Shoulder Complete",
        bodyPartsWorked: ["Shoulders", "Rear Delts", "Traps"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Overhead Press", sets: 4, reps: "6-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Lateral Raises", sets: 4, reps: "12-15", rest: "45s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Rear Delt Fly", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Arnold Press", sets: 3, reps: "8-12", rest: "75s", equipmentUsed: ["Dumbbells"])
        ],
        equipmentUsed: ["Barbell", "Dumbbells"]
    ),
    Workout(
        name: "Arm Isolation Focus",
        bodyPartsWorked: ["Biceps", "Triceps", "Forearms"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Incline Dumbbell Curl", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "EZ Bar Skull Crushers", sets: 3, reps: "8-12", rest: "60s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Hammer Curls", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Rope Pushdowns", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Cables"]),
            Exercise(name: "Wrist Curls + Reverse Wrist Curls", sets: 2, reps: "12-15", rest: "45s", equipmentUsed: ["Dumbbells"])
        ],
        equipmentUsed: ["Dumbbells", "Bench", "Barbell", "Cables"]
    ),
    Workout(
        name: "Core Oblique Burner",
        bodyPartsWorked: ["Abs", "Obliques"],
        difficulty: "Intermediate",
        duration: 35,
        exercises: [
            Exercise(name: "Side Plank Dips", sets: 3, reps: "12 each side", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Russian Twists (Weighted)", sets: 4, reps: "20 reps", rest: "30s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Cable Woodchoppers", sets: 3, reps: "12 each side", rest: "45s", equipmentUsed: ["Cables"]),
            Exercise(name: "Plank Hip Dips", sets: 3, reps: "15 reps", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat", "Dumbbells", "Cables"]
    ),
    Workout(
        name: "Quad & Adductor Strength",
        bodyPartsWorked: ["Quads", "Adductors"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Sumo Squats", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Leg Extensions", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Machine"]),
            Exercise(name: "Cossack Squats", sets: 3, reps: "8-10 each side", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Side Lunges", sets: 3, reps: "10 each side", rest: "60s", equipmentUsed: ["Dumbbells"])
        ],
        equipmentUsed: ["Barbell", "Machine", "Mat", "Dumbbells"]
    ),
    Workout(
        name: "Hamstring & Glute Builder",
        bodyPartsWorked: ["Hamstrings", "Glutes"],
        difficulty: "Intermediate",
        duration: 50,
        exercises: [
            Exercise(name: "Romanian Deadlifts", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Hip Thrusts", sets: 4, reps: "8-12", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Hamstring Curls", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Machine"]),
            Exercise(name: "Bulgarian Split Squats", sets: 3, reps: "8-10 each leg", rest: "75s", equipmentUsed: ["Dumbbells", "Bench"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Machine", "Dumbbells"]
    ),
    Workout(
        name: "Glute & Abductor Sculpt",
        bodyPartsWorked: ["Glutes", "Abductors"],
        difficulty: "Beginner",
        duration: 35,
        exercises: [
            Exercise(name: "Lateral Band Walks", sets: 3, reps: "15 steps each way", rest: "45s", equipmentUsed: ["Cables"]),
            Exercise(name: "Glute Bridges", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Clamshells", sets: 3, reps: "15 each side", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Standing Hip Abductions", sets: 2, reps: "12-15 each leg", rest: "30s", equipmentUsed: ["Cables"])
        ],
        equipmentUsed: ["Cables", "Mat"]
    ),
    Workout(
        name: "Calf Destroyer",
        bodyPartsWorked: ["Calves"],
        difficulty: "Beginner",
        duration: 25,
        exercises: [
            Exercise(name: "Standing Calf Raises", sets: 4, reps: "15-20", rest: "30s", equipmentUsed: ["Machine"]),
            Exercise(name: "Seated Calf Raises", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Machine"]),
            Exercise(name: "Single-Leg Calf Raises", sets: 3, reps: "10 each leg", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Jump Rope", sets: 3, reps: "45s", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Machine", "Mat"]
    ),
    Workout(
        name: "Forearm Strength Circuit",
        bodyPartsWorked: ["Forearms", "Biceps"],
        difficulty: "Beginner",
        duration: 30,
        exercises: [
            Exercise(name: "Farmer's Carries", sets: 4, reps: "40s", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Reverse Curls", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Wrist Roller", sets: 3, reps: "Up & Down", rest: "60s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Dead Hang", sets: 3, reps: "30-45s", rest: "60s", equipmentUsed: ["Machine"])
        ],
        equipmentUsed: ["Dumbbells", "Barbell", "Machine"]
    ),
    Workout(
        name: "Full Posterior Chain",
        bodyPartsWorked: ["Hamstrings", "Glutes", "Lats", "Traps", "Rear Delts"],
        difficulty: "Advanced",
        duration: 55,
        exercises: [
            Exercise(name: "Deadlifts", sets: 4, reps: "5-6", rest: "120s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Barbell Rows", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Face Pulls", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Hip Thrusts", sets: 3, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell", "Bench"]),
            Exercise(name: "Back Extensions", sets: 3, reps: "12-15", rest: "60s", equipmentUsed: ["Bench"])
        ],
        equipmentUsed: ["Barbell", "Bench", "Cables"]
    ),
    
    // ADDUCTOR & ABDUCTOR SPECIALIZATION WORKOUTS
    Workout(
        name: "Adductor Strength Base",
        bodyPartsWorked: ["Adductors", "Quads", "Glutes"],
        difficulty: "Beginner",
        duration: 35,
        exercises: [
            Exercise(name: "Sumo Squats", sets: 4, reps: "10-12", rest: "60s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Side Lunges", sets: 3, reps: "10 each side", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Adductor Machine", sets: 3, reps: "12-15", rest: "45s", equipmentUsed: ["Machine"]),
            Exercise(name: "Wide-Stance Wall Sit", sets: 2, reps: "30-45s", rest: "45s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Barbell", "Dumbbells", "Machine", "Mat"]
    ),
    Workout(
        name: "Abductor Activation Flow",
        bodyPartsWorked: ["Abductors", "Glutes"],
        difficulty: "Beginner",
        duration: 30,
        exercises: [
            Exercise(name: "Lateral Band Walks", sets: 3, reps: "15 steps each way", rest: "45s", equipmentUsed: ["Cables"]),
            Exercise(name: "Clamshells", sets: 3, reps: "15 each side", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Standing Hip Abductions", sets: 3, reps: "12-15 each leg", rest: "30s", equipmentUsed: ["Cables"]),
            Exercise(name: "Glute Bridge Hold (Band)", sets: 2, reps: "30-40s", rest: "45s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Cables", "Mat"]
    ),
    Workout(
        name: "Inner Thigh Burnout",
        bodyPartsWorked: ["Adductors", "Hamstrings"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Cossack Squats", sets: 4, reps: "8-10 each side", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Cable Adductions", sets: 3, reps: "12-15 each leg", rest: "45s", equipmentUsed: ["Cables"]),
            Exercise(name: "Wide-Stance Goblet Squats", sets: 3, reps: "10-12", rest: "60s", equipmentUsed: ["Kettlebells"]),
            Exercise(name: "Side-Lying Adduction", sets: 3, reps: "12-15 each side", rest: "45s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Dumbbells", "Cables", "Kettlebells", "Mat"]
    ),
    Workout(
        name: "Outer Hip Sculpt",
        bodyPartsWorked: ["Abductors", "Glutes"],
        difficulty: "Intermediate",
        duration: 40,
        exercises: [
            Exercise(name: "Cable Hip Abductions", sets: 4, reps: "12-15 each leg", rest: "45s", equipmentUsed: ["Cables"]),
            Exercise(name: "Side-Lying Leg Raises", sets: 3, reps: "15-20", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Monster Walks", sets: 3, reps: "20 steps", rest: "45s", equipmentUsed: ["Cables"]),
            Exercise(name: "Frog Pumps", sets: 3, reps: "15-20", rest: "45s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Cables", "Mat"]
    ),
    Workout(
        name: "Athletic Hip Stability",
        bodyPartsWorked: ["Adductors", "Abductors", "Glutes"],
        difficulty: "Intermediate",
        duration: 45,
        exercises: [
            Exercise(name: "Lateral Lunges", sets: 3, reps: "10 each side", rest: "60s", equipmentUsed: ["Dumbbells"]),
            Exercise(name: "Skater Squats", sets: 3, reps: "8-10 each side", rest: "60s", equipmentUsed: ["Mat"]),
            Exercise(name: "Resistance Band Walks", sets: 3, reps: "20 steps", rest: "45s", equipmentUsed: ["Cables"]),
            Exercise(name: "Single-Leg Glute Bridge", sets: 3, reps: "10-12 each side", rest: "45s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Dumbbells", "Mat", "Cables"]
    ),
    Workout(
        name: "Inner & Outer Hip Combo",
        bodyPartsWorked: ["Adductors", "Abductors", "Glutes"],
        difficulty: "Advanced",
        duration: 55,
        exercises: [
            Exercise(name: "Sumo Squats", sets: 4, reps: "8-10", rest: "90s", equipmentUsed: ["Barbell"]),
            Exercise(name: "Lateral Band Walks", sets: 4, reps: "20 steps", rest: "45s", equipmentUsed: ["Cables"]),
            Exercise(name: "Cable Adduction + Abduction Superset", sets: 3, reps: "12 each direction", rest: "60s", equipmentUsed: ["Cables"]),
            Exercise(name: "Bulgarian Split Squats (Wide Stance)", sets: 3, reps: "8-10 each leg", rest: "75s", equipmentUsed: ["Dumbbells", "Bench"]),
            Exercise(name: "Isometric Wall Sit (Wide Stance)", sets: 2, reps: "45-60s", rest: "60s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Barbell", "Cables", "Dumbbells", "Bench", "Mat"]
    ),
    Workout(
        name: "Hip Mobility & Control",
        bodyPartsWorked: ["Adductors", "Abductors"],
        difficulty: "Beginner",
        duration: 25,
        exercises: [
            Exercise(name: "Hip Openers", sets: 3, reps: "30s each side", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Cossack Squat (Assisted)", sets: 3, reps: "8 each side", rest: "45s", equipmentUsed: ["Mat"]),
            Exercise(name: "Standing Leg Swings", sets: 3, reps: "15 each leg", rest: "30s", equipmentUsed: ["Mat"]),
            Exercise(name: "Deep Squat Hold", sets: 2, reps: "30-45s", rest: "30s", equipmentUsed: ["Mat"])
        ],
        equipmentUsed: ["Mat"]
    )
]
