struct ExerciseData {
    let name: String
    let muscles: [String: Int]
}

let exercises: [ExerciseData] = [

    /* TRAPS */
    ExerciseData(name: "Barbell Shrug", muscles: ["traps": 3, "forearms": 1]),
    ExerciseData(name: "Dumbbell Shrug", muscles: ["traps": 3, "forearms": 1]),
    ExerciseData(name: "Behind-the-Back Shrug", muscles: ["traps": 3, "forearms": 1]),
    ExerciseData(name: "Trap Bar Shrug", muscles: ["traps": 3, "forearms": 1]),
    ExerciseData(name: "Snatch Grip High Pull", muscles: ["traps": 3, "shoulders": 2, "glutes": 1, "quads": 1]),
    ExerciseData(name: "Farmer’s Carry", muscles: ["forearms": 3, "traps": 2, "abs": 1]),

    /* LATS */
    ExerciseData(name: "Pull-Up", muscles: ["lats": 3, "biceps": 2, "rear_delts": 1, "forearms": 1]),
    ExerciseData(name: "Chin-Up", muscles: ["lats": 3, "biceps": 3, "forearms": 1]),
    ExerciseData(name: "Lat Pulldown", muscles: ["lats": 3, "biceps": 2, "rear_delts": 1]),
    ExerciseData(name: "Wide Grip Lat Pulldown", muscles: ["lats": 3, "biceps": 1, "rear_delts": 1]),
    ExerciseData(name: "Close Grip Lat Pulldown", muscles: ["lats": 3, "biceps": 2, "rear_delts": 1]),
    ExerciseData(name: "Straight Arm Pulldown", muscles: ["lats": 3, "triceps": 1]),
    ExerciseData(name: "Single Arm Lat Pulldown", muscles: ["lats": 3, "biceps": 2, "rear_delts": 1]),
    ExerciseData(name: "Resistance Band Pulldown", muscles: ["lats": 3, "biceps": 2]),

    /* CHEST */
    ExerciseData(name: "Barbell Bench Press", muscles: ["chest": 3, "triceps": 2, "shoulders": 1]),
    ExerciseData(name: "Incline Bench Press", muscles: ["chest": 3, "shoulders": 2, "triceps": 1]),
    ExerciseData(name: "Decline Bench Press", muscles: ["chest": 3, "triceps": 2, "shoulders": 1]),
    ExerciseData(name: "Dumbbell Bench Press", muscles: ["chest": 3, "triceps": 2, "shoulders": 1]),
    ExerciseData(name: "Machine Chest Press", muscles: ["chest": 3, "triceps": 2, "shoulders": 1]),
    ExerciseData(name: "Chest Fly", muscles: ["chest": 3, "shoulders": 1]),
    ExerciseData(name: "Cable Fly", muscles: ["chest": 3, "shoulders": 1]),
    ExerciseData(name: "Incline Cable Fly", muscles: ["chest": 3, "shoulders": 1]),
    ExerciseData(name: "Decline Cable Fly", muscles: ["chest": 3, "shoulders": 1]),
    ExerciseData(name: "Push-Up", muscles: ["chest": 3, "triceps": 2, "shoulders": 1, "abs": 1]),
    ExerciseData(name: "Decline Push-Up", muscles: ["chest": 3, "shoulders": 2, "triceps": 1, "abs": 1]),
    ExerciseData(name: "Incline Push-Up", muscles: ["chest": 2, "triceps": 2, "shoulders": 1, "abs": 1]),

    /* SHOULDERS */
    ExerciseData(name: "Overhead Press", muscles: ["shoulders": 3, "triceps": 2, "upper_chest": 1]),
    ExerciseData(name: "Dumbbell Shoulder Press", muscles: ["shoulders": 3, "triceps": 2, "upper_chest": 1]),
    ExerciseData(name: "Arnold Press", muscles: ["shoulders": 3, "triceps": 1, "upper_chest": 1]),
    ExerciseData(name: "Lateral Raise", muscles: ["shoulders": 3, "traps": 1]),
    ExerciseData(name: "Cable Lateral Raise", muscles: ["shoulders": 3, "traps": 1]),
    ExerciseData(name: "Front Raise", muscles: ["shoulders": 2, "upper_chest": 1]),
    ExerciseData(name: "Plate Raise", muscles: ["shoulders": 2, "upper_chest": 1]),
    ExerciseData(name: "Upright Row", muscles: ["shoulders": 2, "traps": 2, "biceps": 1]),

    /* REAR DELTS */
    ExerciseData(name: "Face Pull", muscles: ["rear_delts": 3, "traps": 2, "biceps": 1]),
    ExerciseData(name: "Reverse Fly", muscles: ["rear_delts": 3, "traps": 1]),
    ExerciseData(name: "Rear Delt Machine Fly", muscles: ["rear_delts": 3, "traps": 1]),
    ExerciseData(name: "Cable Rear Delt Fly", muscles: ["rear_delts": 3, "traps": 1]),

    /* BICEPS */
    ExerciseData(name: "Barbell Curl", muscles: ["biceps": 3, "forearms": 1]),
    ExerciseData(name: "Dumbbell Curl", muscles: ["biceps": 3, "forearms": 1]),
    ExerciseData(name: "Hammer Curl", muscles: ["biceps": 2, "forearms": 2, "brachialis": 2]),
    ExerciseData(name: "Incline Curl", muscles: ["biceps": 3, "forearms": 1]),
    ExerciseData(name: "Preacher Curl", muscles: ["biceps": 3, "forearms": 1]),
    ExerciseData(name: "Cable Curl", muscles: ["biceps": 3, "forearms": 1]),
    ExerciseData(name: "Concentration Curl", muscles: ["biceps": 3, "forearms": 1]),
    ExerciseData(name: "Zottman Curl", muscles: ["biceps": 2, "forearms": 2, "brachialis": 1]),
    ExerciseData(name: "Reverse Curl", muscles: ["forearms": 3, "biceps": 1, "brachialis": 2]),

    /* TRICEPS */
    ExerciseData(name: "Tricep Pushdown", muscles: ["triceps": 3]),
    ExerciseData(name: "Overhead Tricep Extension", muscles: ["triceps": 3]),
    ExerciseData(name: "Cable Overhead Extension", muscles: ["triceps": 3]),
    ExerciseData(name: "Skull Crushers", muscles: ["triceps": 3]),
    ExerciseData(name: "Close Grip Bench Press", muscles: ["triceps": 3, "chest": 1, "shoulders": 1]),
    ExerciseData(name: "Bench Dips", muscles: ["triceps": 3, "shoulders": 1, "chest": 1]),
    ExerciseData(name: "Close Grip Push-Up", muscles: ["triceps": 3, "chest": 1, "shoulders": 1, "abs": 1]),

    /* FOREARMS */
    ExerciseData(name: "Wrist Curl", muscles: ["forearms": 3]),
    ExerciseData(name: "Reverse Wrist Curl", muscles: ["forearms": 3]),
    ExerciseData(name: "Dead Hang", muscles: ["forearms": 3, "lats": 1, "traps": 1]),
    ExerciseData(name: "Towel Hang", muscles: ["forearms": 3, "biceps": 1, "lats": 1]),

    /* CORE */
    ExerciseData(name: "Crunch", muscles: ["abs": 3]),
    ExerciseData(name: "Sit-Up", muscles: ["abs": 3, "hip_flexors": 1]),
    ExerciseData(name: "Decline Sit-Up", muscles: ["abs": 3, "hip_flexors": 1]),
    ExerciseData(name: "Hanging Leg Raise", muscles: ["abs": 3, "hip_flexors": 2, "forearms": 1]),
    ExerciseData(name: "Hanging Knee Raise", muscles: ["abs": 3, "hip_flexors": 2, "forearms": 1]),
    ExerciseData(name: "Ab Rollout", muscles: ["abs": 3, "shoulders": 1, "lats": 1]),
    ExerciseData(name: "Plank", muscles: ["abs": 3, "shoulders": 1, "glutes": 1]),
    ExerciseData(name: "Russian Twist", muscles: ["obliques": 3, "abs": 2]),
    ExerciseData(name: "Side Plank", muscles: ["obliques": 3, "abs": 2]),
    ExerciseData(name: "Cable Woodchopper", muscles: ["obliques": 3, "abs": 2, "shoulders": 1]),
    ExerciseData(name: "Bicycle Crunch", muscles: ["abs": 3, "obliques": 2, "hip_flexors": 1]),
    ExerciseData(name: "Flutter Kicks", muscles: ["abs": 3, "hip_flexors": 2]),
    ExerciseData(name: "Mountain Climbers", muscles: ["abs": 3, "shoulders": 1, "hip_flexors": 1]),
    ExerciseData(name: "Toe Touches", muscles: ["abs": 3]),

    /* ADDUCTORS */
    ExerciseData(name: "Hip Adduction Machine", muscles: ["adductors": 3]),
    ExerciseData(name: "Cable Hip Adduction", muscles: ["adductors": 3]),
    ExerciseData(name: "Sumo Squat", muscles: ["adductors": 2, "glutes": 2, "quads": 2, "hamstrings": 1]),
    ExerciseData(name: "Side Lunge", muscles: ["adductors": 2, "quads": 2, "glutes": 1]),
    ExerciseData(name: "Curtsy Lunge", muscles: ["adductors": 2, "glutes": 2, "quads": 1]),

    /* ABDUCTORS */
    ExerciseData(name: "Hip Abduction Machine", muscles: ["abductors": 3, "glutes": 1]),
    ExerciseData(name: "Cable Hip Abduction", muscles: ["abductors": 3, "glutes": 1]),
    ExerciseData(name: "Band Walk", muscles: ["abductors": 2, "glutes": 2]),
    ExerciseData(name: "Clamshell", muscles: ["abductors": 3, "glutes": 2]),

    /* GLUTES */
    ExerciseData(name: "Hip Thrust", muscles: ["glutes": 3, "hamstrings": 1]),
    ExerciseData(name: "Barbell Hip Thrust", muscles: ["glutes": 3, "hamstrings": 1]),
    ExerciseData(name: "Glute Bridge", muscles: ["glutes": 3, "hamstrings": 1]),
    ExerciseData(name: "Cable Kickback", muscles: ["glutes": 3, "hamstrings": 1]),
    ExerciseData(name: "Step-Up", muscles: ["glutes": 2, "quads": 2, "calves": 1]),
    ExerciseData(name: "Reverse Lunge", muscles: ["glutes": 2, "hamstrings": 2, "quads": 1]),
    ExerciseData(name: "Frog Pump", muscles: ["glutes": 3, "adductors": 1]),

    /* HAMSTRINGS */
    ExerciseData(name: "Romanian Deadlift", muscles: ["hamstrings": 3, "glutes": 2, "lower_back": 1, "forearms": 1]),
    ExerciseData(name: "Stiff Leg Deadlift", muscles: ["hamstrings": 3, "glutes": 2, "lower_back": 1, "forearms": 1]),
    ExerciseData(name: "Leg Curl", muscles: ["hamstrings": 3, "calves": 1]),
    ExerciseData(name: "Seated Leg Curl", muscles: ["hamstrings": 3, "calves": 1]),
    ExerciseData(name: "Nordic Curl", muscles: ["hamstrings": 3, "glutes": 1]),
    ExerciseData(name: "Good Morning", muscles: ["hamstrings": 3, "glutes": 2, "lower_back": 2]),

    /* QUADS */
    ExerciseData(name: "Back Squat", muscles: ["quads": 3, "glutes": 2, "hamstrings": 1, "abs": 1]),
    ExerciseData(name: "Front Squat", muscles: ["quads": 3, "glutes": 1, "abs": 1, "upper_back": 1]),
    ExerciseData(name: "Leg Press", muscles: ["quads": 3, "glutes": 2, "hamstrings": 1]),
    ExerciseData(name: "Hack Squat", muscles: ["quads": 3, "glutes": 1]),
    ExerciseData(name: "Walking Lunge", muscles: ["quads": 2, "glutes": 2, "hamstrings": 1, "calves": 1]),
    ExerciseData(name: "Leg Extension", muscles: ["quads": 3]),
    ExerciseData(name: "Wall Sit", muscles: ["quads": 3, "glutes": 1]),
    ExerciseData(name: "Step Down", muscles: ["quads": 2, "glutes": 1, "calves": 1]),
    ExerciseData(name: "Jump Squat", muscles: ["quads": 2, "glutes": 2, "calves": 2]),

    /* CALVES */
    ExerciseData(name: "Standing Calf Raise", muscles: ["calves": 3]),
    ExerciseData(name: "Seated Calf Raise", muscles: ["calves": 3]),
    ExerciseData(name: "Donkey Calf Raise", muscles: ["calves": 3]),
    ExerciseData(name: "Single Leg Calf Raise", muscles: ["calves": 3]),
    ExerciseData(name: "Toe Walk", muscles: ["calves": 3, "forearms": 1])
]
