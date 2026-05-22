import SwiftUI

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let answers: [String]
    let correct: Int
}

let sampleQuestions: [Question] = [
    Question(
        text: "Что включает стоматологический осмотр пациента?",
        answers: [
            "Только осмотр зубов",
            "Осмотр, пальпацию, сбор анамнеза",
            "Только рентген",
            "Только опрос"
        ],
        correct: 1
    ),
    Question(
        text: "Что используют для изоляции рабочего поля?",
        answers: [
            "Коффердам",
            "Только зеркало",
            "Пинцет",
            "Экскаватор"
        ],
        correct: 0
    )
]

struct ContentView: View {
    @State private var current = 0
    @State private var selected: Int? = nil
    @State private var score = 0
    @State private var finished = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Медик Тест")
                .font(.largeTitle)
                .bold()

            if finished {
                Text("Тест завершён")
                    .font(.title2)

                Text("Результат: \(score) / \(sampleQuestions.count)")

                Button("Начать заново") {
                    current = 0
                    score = 0
                    selected = nil
                    finished = false
                }
            } else {

                Text(sampleQuestions[current].text)
                    .font(.title3)

                ForEach(0..<sampleQuestions[current].answers.count, id: \.self) { index in
                    Button(action: {
                        selected = index
                    }) {
                        HStack {
                            Text(sampleQuestions[current].answers[index])
                            Spacer()

                            if selected == index {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                }

                Button("Следующий вопрос") {

                    if selected == sampleQuestions[current].correct {
                        score += 1
                    }

                    selected = nil

                    if current + 1 < sampleQuestions.count {
                        current += 1
                    } else {
                        finished = true
                    }

                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(14)
            }

            Spacer()
        }
        .padding()
    }
}

@main
struct MedicTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}