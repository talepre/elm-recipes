module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (Recipe, NewRecipe, RecipeId, Ingredient, IngredientId, IngredientInfo, Unit)
import RemoteData


fetchRecipes : Cmd Msg
fetchRecipes =
    Http.get recipesUrl recipesDecoder
     |> RemoteData.sendRequest
     |> Cmd.map Msgs.OnFetchRecipes

fetchIngredients : Cmd Msg
fetchIngredients =
    Http.get ingredientsUrl ingredientsDecoder
     |> RemoteData.sendRequest
     |> Cmd.map Msgs.OnFetchIngredients

ingredientsDecoder : Decode.Decoder (List Ingredient)
ingredientsDecoder = 
    Decode.list ingredientDecoder

ingredientDecoder : Decode.Decoder Ingredient
ingredientDecoder =
    decode Ingredient
        |> required "id" Decode.string
        |> required "name" Decode.string

ingredientsUrl : String
ingredientsUrl = 
    "http://localhost:4000/ingredients"

recipesUrl : String
recipesUrl = 
    "http://localhost:4000/recipes"

recipesDecoder : Decode.Decoder (List Recipe)
recipesDecoder = 
    Decode.list recipeDecoder

recipeDecoder : Decode.Decoder Recipe
recipeDecoder =
    decode Recipe
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "ingredients" (Decode.list ingredientInfoDecoder)
        |> required "description" Decode.string
        |> required "directions" Decode.string

ingredientInfoDecoder: Decode.Decoder IngredientInfo
ingredientInfoDecoder =
    decode IngredientInfo
        |> required "ingredientId" Decode.string
        |> required "unitId" Decode.string
        |> required "amount" Decode.int

saveRecipeRequest : NewRecipe -> Http.Request Recipe
saveRecipeRequest newRecipe =
    Http.request
        { body = newRecipeEncoder newRecipe |> Http.jsonBody
        , expect = Http.expectJson recipeDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = recipesUrl
        , withCredentials = False
        }

saveRecipeCmd : NewRecipe -> Cmd Msg
saveRecipeCmd newRecipe = 
    saveRecipeRequest newRecipe
        |> Http.send Msgs.OnRecipeSave

newRecipeEncoder : NewRecipe -> Encode.Value
newRecipeEncoder newRecipe =
    let
        attributes = 
            [ ( "name", Encode.string newRecipe.name )
            , ( "description", Encode.string newRecipe.description )
            ]
    in
        Encode.object attributes


deleteRecipeUrl : RecipeId -> String
deleteRecipeUrl recipeId =
    "http://localhost:4000/recipes/" ++ recipeId

deleteRecipeRequest : Recipe -> Http.Request Bool
deleteRecipeRequest recipe =
    Http.request
        { body = Http.emptyBody
        , expect = Http.expectJson Decode.bool
        , headers = []
        , method = "DELETE"
        , timeout = Nothing
        , url = deleteRecipeUrl recipe.id
        , withCredentials = False
        }

deleteRecipeCmd : Recipe -> Cmd Msg
deleteRecipeCmd recipe =
    deleteRecipeRequest recipe
        |> Http.send Msgs.OnRecipeDelete

fetchUnits : Cmd Msg
fetchUnits =
    Http.get unitsUrl unitsDecoder
     |> RemoteData.sendRequest
     |> Cmd.map Msgs.OnFetchUnits

unitsDecoder : Decode.Decoder (List Unit)
unitsDecoder = 
    Decode.list unitDecoder

unitDecoder : Decode.Decoder Unit
unitDecoder =
    decode Unit
        |> required "id" Decode.string
        |> required "name" Decode.string

unitsUrl : String
unitsUrl = 
    "http://localhost:4000/units"
