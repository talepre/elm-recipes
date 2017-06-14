module Main exposing (..)

import Commands exposing (fetchRecipes, fetchIngredients, fetchUnits)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing
import Update exposing (update)
import View exposing (view)

init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
        emptyRecipe =
            { name = ""
            , ingredients = []
            , description = ""
            , directions = ""
            }
    in
        ( initialModel currentRoute "" emptyRecipe, Cmd.batch [fetchRecipes, fetchIngredients, fetchUnits])


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }