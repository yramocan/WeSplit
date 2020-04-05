import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var selectedTipPercentageIndex = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[selectedTipPercentageIndex])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection

        return orderAmount + tipValue
    }

    var totalPerPerson: Double {
        guard let numberOfPeople = Double(numberOfPeople) else { return 0 }
        return grandTotal / numberOfPeople
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $selectedTipPercentageIndex) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Grand total")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
