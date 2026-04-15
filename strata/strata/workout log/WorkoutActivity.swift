import Foundation
import FirebaseFirestore

struct WorkoutActivity {
    let id: String
    let title: String
    let workoutDate: Date
    let exerciseCount: Int

    var subtitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        return formatter.string(from: workoutDate)
    }

    init(id: String, title: String, workoutDate: Date, exerciseCount: Int = 0) {
        self.id = id
        self.title = title
        self.workoutDate = workoutDate
        self.exerciseCount = exerciseCount
    }

    init?(document: DocumentSnapshot) {
        guard
            let data = document.data(),
            let title = data["title"] as? String,
            let workoutTimestamp = data["workoutDate"] as? Timestamp
        else {
            return nil
        }

        let exercises = data["exercises"] as? [[String: Any]] ?? []

        self.id = document.documentID
        self.title = title
        self.workoutDate = workoutTimestamp.dateValue()
        self.exerciseCount = exercises.count
    }
}
