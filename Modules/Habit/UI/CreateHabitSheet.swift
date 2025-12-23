import SwiftUI

struct CreateHabitSheet: View {
    @State private var name = ""
    @State private var description = ""
    @State private var type = HabitType.positive
    @State private var color: String? = nil
    
    let confirmHabitTapped: (Habit) -> Void
    
    var body: some View {
        VStack {
            Header()
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            HStack {
                Text("Type")
                
                Spacer()
                
                Picker("Projekt", selection: $type) {
                    Text("Positive")
                        .tag(HabitType.positive)
                        .foregroundStyle(.contrast)
                    Text("Timed")
                        .tag(HabitType.timed(0))
                        .foregroundStyle(.contrast)
                }
                .pickerStyle(MenuPickerStyle())
                .tint(.contrast)
            }
            
            CustomColorPicker(selectedColor: $color)
        }
        .padding()
        .foregroundStyle(.contrast)
    }
    
    func confirmTapped() {
        switch type {
        case .positive:
            let habit = Habit(name: name, description: description, icon: "", type: .positive)
            confirmHabitTapped(habit)
        case .timed:
            let habit = Habit(name: name, description: description, icon: "", type: .timed(10))
            confirmHabitTapped(habit)
        }
    }
    
    @ViewBuilder
    func Header() -> some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "xmark")
            }
            
            Spacer()
            
            Text("Goal")
            
            Spacer()
            
            Button(action: confirmTapped) {
                Image(systemName: "checkmark")
            }
        }
    }
}

#Preview {
    CreateHabitSheet(
        confirmHabitTapped: { _ in }
    )
}
