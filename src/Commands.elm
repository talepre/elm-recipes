module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (Recipe, NewRecipe, RecipeId)
import RemoteData


fetchRecipes : Cmd Msg
fetchRecipes =
    Http.get fetchRecipesUrl recipesDecoder
     |> RemoteData.sendRequest
     |> Cmd.map Msgs.OnFetchRecipes

fetchRecipesUrl : String
fetchRecipesUrl = 
    "http://localhost:4000/recipes"

recipesDecoder : Decode.Decoder (List Recipe)
recipesDecoder = 
    Decode.list recipeDecoder

recipeDecoder : Decode.Decoder Recipe
recipeDecoder =
    decode Recipe
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "ingredients" Decode.string
        |> required "description" Decode.string

saveRecipeUrl : String
saveRecipeUrl =
    "http://localhost:4000/recipes"

saveRecipeRequest : NewRecipe -> Http.Request Recipe
saveRecipeRequest newRecipe =
    Http.request
        { body = newRecipeEncoder newRecipe |> Http.jsonBody
        , expect = Http.expectJson recipeDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = saveRecipeUrl
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
            , ( "ingredients", Encode.string newRecipe.ingredients )
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
            