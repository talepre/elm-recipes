module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { recipes : WebData (List Recipe)
    , route : Route
    , query : String
    , newRecipe : NewRecipe
    }

initialModel : Route -> Query -> NewRecipe -> Model
initialModel route query recipe =
    { recipes = RemoteData.Loading
    , route = route
    , query = query
    , newRecipe = recipe
    }

type alias RecipeId =
    String

type alias Recipe =
    { id : RecipeId
    , name : String
    , ingredients : String
    , description : String
    }

type alias NewRecipe =
    { name : String
    , ingredients : String
    , description : String
    }

type alias Query = 
    String

type Route
    = RecipesRoute
    | RecipeRoute RecipeId
    | AddRecipeRoute
    | NotFoundRoute