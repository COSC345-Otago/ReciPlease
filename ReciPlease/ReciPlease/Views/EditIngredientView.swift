//
//  EditIngredientView.swift
//  ReciPlease
//
//  Created by Ethan Fraser on 30/09/21.
//

import SwiftUI

struct EditIngredientView: View {
    
    @EnvironmentObject var currentRecipe: Recipe
    @Binding var editingIngredient: Bool
    @State var isNewIngredient: Bool
    @State var selectedUnit: Unit = Unit.each
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack{
            Color.black
                .onTapGesture {
                    currentRecipe.currentIngredient = Ingredient()
                    withAnimation {
                        editingIngredient.toggle()
                    }
                }
                .ignoresSafeArea()
                .opacity(0.4)
            VStack(spacing: 0){
                Text("Item Details").padding(.top, 20)

                Form{
    
                    TextField("Name", text: $currentRecipe.currentIngredient.name)

                    Picker(selection: $currentRecipe.currentIngredient.unit, label:Text("Unit")) {
                        Text("Each").tag(Unit.each)
                        Text("Grams").tag(Unit.g)
                        Text("Kg").tag(Unit.kg)
                        Text("mL").tag(Unit.ml)
                        Text("L").tag(Unit.l)
                        Text("Cup").tag(Unit.cup)
                        Text("Tablespoon").tag(Unit.Tbsp)
                        Text("Teaspoon").tag(Unit.tsp)
                    }
                
                    TextField("Quantity", text:$currentRecipe.currentIngredient.quantity)
                        .keyboardType(.numberPad)

                }
                NavigationLink(destination: SearchProductsView(currentRecipe: currentRecipe, searchText: $currentRecipe.currentIngredient.name)) {
                   Text("Search product")
                }.environmentObject(currentRecipe)
                HStack {
                    Button("Cancel") {
                        currentRecipe.currentIngredient = Ingredient()
                        withAnimation {
                            editingIngredient.toggle()
                        }
                    }.padding()
                    Button("Submit") {
                        if(currentRecipe.currentIngredient.name != currentRecipe.currentIngredient.product?.name){
                            currentRecipe.currentIngredient.product = nil
                        }
                        if isNewIngredient {
                            currentRecipe.ingredients.append(currentRecipe.currentIngredient)
                        } else {
                            let oldIngs = currentRecipe.ingredients
                            currentRecipe.ingredients = []
                            oldIngs.forEach {ing in
                                if ing.id == $currentRecipe.currentIngredient.id {
                                    currentRecipe.ingredients.append(currentRecipe.currentIngredient)
                                } else {
                                    currentRecipe.ingredients.append(ing)
                                }
                            }
                        }
                        currentRecipe.currentIngredient = Ingredient()
                        withAnimation {
                            editingIngredient.toggle()
                        }
                    }.padding()
                }
            }.frame(width:350, height:310)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                .shadow(color: .gray, radius: 5, x:-9, y: -9)
        }
        .environmentObject(currentRecipe)

    }
}

//struct EditIngredientView_Previews: PreviewProvider {
//    @State var editingIngredient = true
//    static var previews: some View {
//        EditIngredientView(editingIngredient: $editingIngredient,
//                           currentRecipe: Recipe(),
//                           currentIngredient: Ingredient())
//    }
//}
