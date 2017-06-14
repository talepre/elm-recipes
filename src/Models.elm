module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { recipes : WebData (List Recipe)
    , route : Route
    , query : String
    , newRecipe : NewRecipe
    , ingredients : WebData (List Ingredient)
    , units : WebData (List Unit)
    }

initialModel : Route -> Query -> NewRecipe -> Model
initialModel route query recipe =
    { recipes = RemoteData.Loading
    , route = route
    , query = query
    , newRecipe = recipe
    , ingredients = RemoteData.Loading
    , units = RemoteData.Loading
    }

type alias RecipeId =
    String

type alias Recipe =
    { id : RecipeId
    , name : String
    , ingredients : List IngredientInfo
    , description : String
    , directions : String
    }

type alias IngredientInfo =
    { ingredientId : IngredientId
    , unitId : UnitId
    , amount : Int
    }

type alias DisplayIngredientInfo =
    { ingredient : String
    , unit : String
    , amount : String
    }

type alias NewRecipe =
    { name : String
    , description : String
    }

type alias IngredientId =
    String

type alias Ingredient = 
    { id : IngredientId
    , name : String
    }

type alias UnitId =
    String

type alias Unit = 
    { id : UnitId
    , name : String
    }

type alias Query = 
    String

type Route
    = RecipesRoute
    | RecipeRoute RecipeId
    | AddRecipeRoute
    | NotFoundRoute