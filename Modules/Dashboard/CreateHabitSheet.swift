import SwiftUI

struct CreateHabitSheet: View {
    @State var name = ""
    @State var description = ""
    @State var type = HabitType.positive
    @State var color: String? = nil
    
    let createHabitTapped: (Habit) -> Void
    
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
    
    func createTapped() {
        switch type {
        case .positive:
            let habit = Habit(name: name, description: description, icon: "", type: .positive)
            createHabitTapped(habit)
        case .timed:
            let habit = Habit(name: name, description: description, icon: "", type: .timed(10))
            createHabitTapped(habit)
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
            
            Button(action: createTapped) {
                Image(systemName: "checkmark")
            }
        }
    }
}

#Preview {
    CreateHabitSheet(
        createHabitTapped: { _ in }
    )
}
