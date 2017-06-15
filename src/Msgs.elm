module Msgs exposing (..)

import Http
import Models exposing (Recipe)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchRecipes (WebData (List Recipe))
    | OnLocationChange Location
    | Query String
    | Name String
    | Description String
    | Ingredients String
    | Directions String
    | AddRecipe
    | OnRecipeSave (Result Http.Error Recipe)
    | DeleteRecipe Recipe
    | OnRecipeDelete (Result Http.Error Bool)