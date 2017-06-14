module Msgs exposing (..)

import Http
import Models exposing (Recipe, Ingredient, Unit)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchRecipes (WebData (List Recipe))
    | OnLocationChange Location
    | Query String
    | Name String
    --| Ingredients String
    | Description String
    | AddRecipe
    | OnRecipeSave (Result Http.Error Recipe)
    | DeleteRecipe Recipe
    | OnRecipeDelete (Result Http.Error Bool)
    | OnFetchIngredients (WebData (List Ingredient))
    | OnFetchUnits (WebData (List Unit))