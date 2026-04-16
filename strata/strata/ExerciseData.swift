struct ExerciseData {
    let name: String
    let muscles: [String: Int]
}

let exercises: [ExerciseData] = [

    /* TRAPS */
    ExerciseData(name: "Barbell Shrug", muscles: ["Traps": 3, "Forearms": 1]),
    ExerciseData(name: "Dumbbell Shrug", muscles: ["Traps": 3, "Forearms": 1]),
    ExerciseData(name: "Behind-the-Back Shrug", muscles: ["Traps": 3, "Forearms": 1]),
    ExerciseData(name: "Trap Bar Shrug", muscles: ["Traps": 3, "Forearms": 1]),
    ExerciseData(name: "Snatch Grip High Pull", muscles: ["Traps": 3, "Shoulders": 2, "Glutes": 1, "Quads": 1]),
    ExerciseData(name: "Farmer’s Carry", muscles: ["Forearms": 3, "Traps": 2, "Abs": 1]),

    /* LATS */
    ExerciseData(name: "Pull-Up", muscles: ["Lats": 3, "Biceps": 2, "Rear Delts": 1, "Forearms": 1]),
    ExerciseData(name: "Chin-Up", muscles: ["Lats": 3, "Biceps": 3, "Forearms": 1]),
    ExerciseData(name: "Lat Pulldown", muscles: ["Lats": 3, "Biceps": 2, "Rear Delts": 1]),
    ExerciseData(name: "Wide Grip Lat Pulldown", muscles: ["Lats": 3, "Biceps": 1, "Rear Delts": 1]),
    ExerciseData(name: "Close Grip Lat Pulldown", muscles: ["Lats": 3, "Biceps": 2, "Rear Delts": 1]),
    ExerciseData(name: "Straight Arm Pulldown", muscles: ["Lats": 3, "Triceps": 1]),
    ExerciseData(name: "Single Arm Lat Pulldown", muscles: ["Lats": 3, "Biceps": 2, "Rear Delts": 1]),
    ExerciseData(name: "Resistance Band Pulldown", muscles: ["Lats": 3, "Biceps": 2]),

    /* CHEST */
    ExerciseData(name: "Barbell Bench Press", muscles: ["Chest": 3, "Triceps": 2, "Shoulders": 1]),
    ExerciseData(name: "Incline Bench Press", muscles: ["Chest": 3, "Shoulders": 2, "Triceps": 1]),
    ExerciseData(name: "Decline Bench Press", muscles: ["Chest": 3, "Triceps": 2, "Shoulders": 1]),
    ExerciseData(name: "Dumbbell Bench Press", muscles: ["Chest": 3, "Triceps": 2, "Shoulders": 1]),
    ExerciseData(name: "Machine Chest Press", muscles: ["Chest": 3, "Triceps": 2, "Shoulders": 1]),
    ExerciseData(name: "Chest Fly", muscles: ["Chest": 3, "Shoulders": 1]),
    ExerciseData(name: "Cable Fly", muscles: ["Chest": 3, "Shoulders": 1]),
    ExerciseData(name: "Incline Cable Fly", muscles: ["Chest": 3, "Shoulders": 1]),
    ExerciseData(name: "Decline Cable Fly", muscles: ["Chest": 3, "Shoulders": 1]),
    ExerciseData(name: "Push-Up", muscles: ["Chest": 3, "Triceps": 2, "Shoulders": 1, "Abs": 1]),
    ExerciseData(name: "Decline Push-Up", muscles: ["Chest": 3, "Shoulders": 2, "Triceps": 1, "Abs": 1]),
    ExerciseData(name: "Incline Push-Up", muscles: ["Chest": 2, "Triceps": 2, "Shoulders": 1, "Abs": 1]),

    /* SHOULDERS */
    ExerciseData(name: "Overhead Press", muscles: ["Shoulders": 3, "Triceps": 2, "Upper Chest": 1]),
    ExerciseData(name: "Dumbbell Shoulder Press", muscles: ["Shoulders": 3, "Triceps": 2, "Upper Chest": 1]),
    ExerciseData(name: "Arnold Press", muscles: ["Shoulders": 3, "Triceps": 1, "Upper Chest": 1]),
    ExerciseData(name: "Lateral Raise", muscles: ["Shoulders": 3, "Traps": 1]),
    ExerciseData(name: "Cable Lateral Raise", muscles: ["Shoulders": 3, "Traps": 1]),
    ExerciseData(name: "Front Raise", muscles: ["Shoulders": 2, "Upper Chest": 1]),
    ExerciseData(name: "Plate Raise", muscles: ["Shoulders": 2, "Upper Chest": 1]),
    ExerciseData(name: "Upright Row", muscles: ["Shoulders": 2, "Traps": 2, "Biceps": 1]),

    /* REAR DELTS */
    ExerciseData(name: "Face Pull", muscles: ["Rear Delts": 3, "Traps": 2, "Biceps": 1]),
    ExerciseData(name: "Reverse Fly", muscles: ["Rear Delts": 3, "Traps": 1]),
    ExerciseData(name: "Rear Delt Machine Fly", muscles: ["Rear Delts": 3, "Traps": 1]),
    ExerciseData(name: "Cable Rear Delt Fly", muscles: ["Rear Delts": 3, "Traps": 1]),

    /* BICEPS */
    ExerciseData(name: "Barbell Curl", muscles: ["Biceps": 3, "Forearms": 1]),
    ExerciseData(name: "Dumbbell Curl", muscles: ["Biceps": 3, "Forearms": 1]),
    ExerciseData(name: "Hammer Curl", muscles: ["Biceps": 2, "Forearms": 2, "Brachialis": 2]),
    ExerciseData(name: "Incline Curl", muscles: ["Biceps": 3, "Forearms": 1]),
    ExerciseData(name: "Preacher Curl", muscles: ["Biceps": 3, "Forearms": 1]),
    ExerciseData(name: "Cable Curl", muscles: ["Biceps": 3, "Forearms": 1]),
    ExerciseData(name: "Concentration Curl", muscles: ["Biceps": 3, "Forearms": 1]),
    ExerciseData(name: "Zottman Curl", muscles: ["Biceps": 2, "Forearms": 2, "Brachialis": 1]),
    ExerciseData(name: "Reverse Curl", muscles: ["Forearms": 3, "Biceps": 1, "Brachialis": 2]),

    /* TRICEPS */
    ExerciseData(name: "Tricep Pushdown", muscles: ["Triceps": 3]),
    ExerciseData(name: "Overhead Tricep Extension", muscles: ["Triceps": 3]),
    ExerciseData(name: "Cable Overhead Extension", muscles: ["Triceps": 3]),
    ExerciseData(name: "Skull Crushers", muscles: ["Triceps": 3]),
    ExerciseData(name: "Close Grip Bench Press", muscles: ["Triceps": 3, "Chest": 1, "Shoulders": 1]),
    ExerciseData(name: "Bench Dips", muscles: ["Triceps": 3, "Shoulders": 1, "Chest": 1]),
    ExerciseData(name: "Close Grip Push-Up", muscles: ["Triceps": 3, "Chest": 1, "Shoulders": 1, "Abs": 1]),

    /* FOREARMS */
    ExerciseData(name: "Wrist Curl", muscles: ["Forearms": 3]),
    ExerciseData(name: "Reverse Wrist Curl", muscles: ["Forearms": 3]),
    ExerciseData(name: "Dead Hang", muscles: ["Forearms": 3, "Lats": 1, "Traps": 1]),
    ExerciseData(name: "Towel Hang", muscles: ["Forearms": 3, "Biceps": 1, "Lats": 1]),

    /* CORE */
    ExerciseData(name: "Crunch", muscles: ["Abs": 3]),
    ExerciseData(name: "Sit-Up", muscles: ["Abs": 3, "Hip Flexors": 1]),
    ExerciseData(name: "Decline Sit-Up", muscles: ["Abs": 3, "Hip Flexors": 1]),
    ExerciseData(name: "Hanging Leg Raise", muscles: ["Abs": 3, "Hip Flexors": 2, "Forearms": 1]),
    ExerciseData(name: "Hanging Knee Raise", muscles: ["Abs": 3, "Hip Flexors": 2, "Forearms": 1]),
    ExerciseData(name: "Ab Rollout", muscles: ["Abs": 3, "Shoulders": 1, "Lats": 1]),
    ExerciseData(name: "Plank", muscles: ["Abs": 3, "Shoulders": 1, "Glutes": 1]),
    ExerciseData(name: "Russian Twist", muscles: ["Obliques": 3, "Abs": 2]),
    ExerciseData(name: "Side Plank", muscles: ["Obliques": 3, "Abs": 2]),
    ExerciseData(name: "Cable Woodchopper", muscles: ["Obliques": 3, "Abs": 2, "Shoulders": 1]),
    ExerciseData(name: "Bicycle Crunch", muscles: ["Abs": 3, "Obliques": 2, "Hip Flexors": 1]),
    ExerciseData(name: "Flutter Kicks", muscles: ["Abs": 3, "Hip Flexors": 2]),
    ExerciseData(name: "Mountain Climbers", muscles: ["Abs": 3, "Shoulders": 1, "Hip Flexors": 1]),
    ExerciseData(name: "Toe Touches", muscles: ["Abs": 3]),

    /* ADDUCTORS */
    ExerciseData(name: "Hip Adduction Machine", muscles: ["Adductors": 3]),
    ExerciseData(name: "Cable Hip Adduction", muscles: ["Adductors": 3]),
    ExerciseData(name: "Sumo Squat", muscles: ["Adductors": 2, "Glutes": 2, "Quads": 2, "Hamstrings": 1]),
    ExerciseData(name: "Side Lunge", muscles: ["Adductors": 2, "Quads": 2, "Glutes": 1]),
    ExerciseData(name: "Curtsy Lunge", muscles: ["Adductors": 2, "Glutes": 2, "Quads": 1]),

    /* ABDUCTORS */
    ExerciseData(name: "Hip Abduction Machine", muscles: ["Abductors": 3, "Glutes": 1]),
    ExerciseData(name: "Cable Hip Abduction", muscles: ["Abductors": 3, "Glutes": 1]),
    ExerciseData(name: "Band Walk", muscles: ["Abductors": 2, "Glutes": 2]),
    ExerciseData(name: "Clamshell", muscles: ["Abductors": 3, "Glutes": 2]),

    /* GLUTES */
    ExerciseData(name: "Hip Thrust", muscles: ["Glutes": 3, "Hamstrings": 1]),
    ExerciseData(name: "Barbell Hip Thrust", muscles: ["Glutes": 3, "Hamstrings": 1]),
    ExerciseData(name: "Glute Bridge", muscles: ["Glutes": 3, "Hamstrings": 1]),
    ExerciseData(name: "Cable Kickback", muscles: ["Glutes": 3, "Hamstrings": 1]),
    ExerciseData(name: "Step-Up", muscles: ["Glutes": 2, "Quads": 2, "Calves": 1]),
    ExerciseData(name: "Reverse Lunge", muscles: ["Glutes": 2, "Hamstrings": 2, "Quads": 1]),
    ExerciseData(name: "Frog Pump", muscles: ["Glutes": 3, "Adductors": 1]),

    /* HAMSTRINGS */
    ExerciseData(name: "Romanian Deadlift", muscles: ["Hamstrings": 3, "Glutes": 2, "Lower Back": 1, "Forearms": 1]),
    ExerciseData(name: "Stiff Leg Deadlift", muscles: ["Hamstrings": 3, "Glutes": 2, "Lower Back": 1, "Forearms": 1]),
    ExerciseData(name: "Leg Curl", muscles: ["Hamstrings": 3, "Calves": 1]),
    ExerciseData(name: "Seated Leg Curl", muscles: ["Hamstrings": 3, "Calves": 1]),
    ExerciseData(name: "Nordic Curl", muscles: ["Hamstrings": 3, "Glutes": 1]),
    ExerciseData(name: "Good Morning", muscles: ["Hamstrings": 3, "Glutes": 2, "Lower Back": 2]),

    /* QUADS */
    ExerciseData(name: "Back Squat", muscles: ["Quads": 3, "Glutes": 2, "Hamstrings": 1, "Abs": 1]),
    ExerciseData(name: "Front Squat", muscles: ["Quads": 3, "Glutes": 1, "Abs": 1, "Upper Back": 1]),
    ExerciseData(name: "Leg Press", muscles: ["Quads": 3, "Glutes": 2, "Hamstrings": 1]),
    ExerciseData(name: "Hack Squat", muscles: ["Quads": 3, "Glutes": 1]),
    ExerciseData(name: "Walking Lunge", muscles: ["Quads": 2, "Glutes": 2, "Hamstrings": 1, "Calves": 1]),
    ExerciseData(name: "Leg Extension", muscles: ["Quads": 3]),
    ExerciseData(name: "Wall Sit", muscles: ["Quads": 3, "Glutes": 1]),
    ExerciseData(name: "Step Down", muscles: ["Quads": 2, "Glutes": 1, "Calves": 1]),
    ExerciseData(name: "Jump Squat", muscles: ["Quads": 2, "Glutes": 2, "Calves": 2]),

    /* CALVES */
    ExerciseData(name: "Standing Calf Raise", muscles: ["Calves": 3]),
    ExerciseData(name: "Seated Calf Raise", muscles: ["Calves": 3]),
    ExerciseData(name: "Donkey Calf Raise", muscles: ["Calves": 3]),
    ExerciseData(name: "Single Leg Calf Raise", muscles: ["Calves": 3]),
    ExerciseData(name: "Toe Walk", muscles: ["Calves": 3, "Forearms": 1])
]
