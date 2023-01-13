import SwiftUI
import Foundation
import Combine

struct RecipeList: Codable {
    let meals: [Recipe]
}

struct RecipeDetailsList: Codable {
    let meals: [RecipeDetails]
}

struct Recipe: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct RecipeDetails: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            Text(recipe.strMeal)
        }
    }
}

struct RecipeDetailsRow: View {
    let recipe: Recipe
    @State private var recipeDetails = [RecipeDetails]()
    var body: some View {
        List(recipeDetails, id: \.idMeal) { item in
            VStack(alignment: .leading) {
                Group {
                    Text("Meal name is:").bold()
                    Spacer()
                    Text(item.strMeal)
                    Divider()
                    Text("Instructions for making the meal: ").bold()
                    Spacer()
                    Text(item.strInstructions)
                    Divider()
                    Text("Ingredients of the meal are:").bold()
                    Spacer()
                }
                Group {
                    Text(item.strIngredient1 ?? " ")
                    Text(item.strIngredient2 ?? " ")
                    Text(item.strIngredient3 ?? " ")
                    Text(item.strIngredient4 ?? " ")
                    Text(item.strIngredient5 ?? " ")
                    Text(item.strIngredient6 ?? " ")
                    Text(item.strIngredient7 ?? " ")
                    Text(item.strIngredient8 ?? " ")
                    Text(item.strIngredient9 ?? " ")
                    Text(item.strIngredient10 ?? " ")
                }
                Group {
                    Text(item.strIngredient11 ?? " ")
                    Text(item.strIngredient12 ?? " ")
                    Text(item.strIngredient13 ?? " ")
                    Text(item.strIngredient14 ?? " ")
                    Text(item.strIngredient15 ?? " ")
                    Text(item.strIngredient16 ?? " ")
                    Text(item.strIngredient17 ?? " ")
                    Text(item.strIngredient18 ?? " ")
                    Text(item.strIngredient19 ?? " ")
                    Text(item.strIngredient20 ?? " ")
                }
            }
        }.onAppear(perform: fetchRecipeDetails)
    }
    private func fetchRecipeDetails(){
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(recipe.idMeal)")!
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else {return}
            let recipeList = try! JSONDecoder().decode(RecipeDetailsList.self, from: data)
            DispatchQueue.main.async {
                self.recipeDetails = recipeList.meals
            }
        }.resume()
    }
}

struct RecipeListView: View {
    @State private var recipes = [Recipe]()
    
    var body: some View {
        NavigationView {
            List(recipes.sorted(by: { $0.strMeal < $1.strMeal }), id: \.idMeal) { recipe in
                NavigationLink(destination: RecipeDetailsRow(recipe: recipe)){
                    RecipeRow(recipe: recipe)
                }
            }.navigationBarTitle("Desserts")
                .onAppear(perform: loadRecipes)
        }
    }
    private func loadRecipes() {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let recipeList = try! JSONDecoder().decode(RecipeList.self, from: data)
            DispatchQueue.main.async {
                self.recipes = recipeList.meals
            }
        }.resume()
    }
}
