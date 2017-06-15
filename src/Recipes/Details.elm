module Recipes.Details exposing (..)

import Html.Attributes exposing (class, value, href)
import Routing exposing (recipesPath)
import Html.Events exposing (onClick)
import Html exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model, Recipe, RecipeId)
import RemoteData exposing (WebData)

view : Recipe -> Model -> Html Msg
view recipe model =
    div []
        [ nav
        , details recipe
        ]

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-olive p1" ]
        [ listBtn ]


details : Recipe -> Html Msg
details recipe =
    let
        deleteMsg =
            Msgs.DeleteRecipe recipe
    in
        div [ class "m3" ]
            [ h1 [] [ text recipe.name, a [href recipesPath][i [ class "fa fa-trash-o ml2 red", onClick deleteMsg] [] ]]
            , descriptionBox recipe.description
            , ingredientList recipe.ingredients
            , directionBox recipe.directions
            ]

ingredientList : String -> Html Msg
ingredientList ingredients =
    div [] [text ingredients]

    

descriptionBox : String -> Html Msg
descriptionBox description =
    div [] [text description]

directionBox : String -> Html Msg
directionBox directions =
    div [] [text directions]



listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href recipesPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "Oppskrifter" ]        