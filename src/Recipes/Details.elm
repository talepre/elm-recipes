module Recipes.Details exposing (..)

import Html.Attributes exposing (class, value, href)
import Routing exposing (recipesPath)
import Html.Events exposing (onClick)
import Html exposing (..)
import Msgs exposing (Msg)
import Models exposing (Recipe)


view : Recipe -> Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Recipe -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : Recipe -> Html Msg
form recipe =
    let
        message =
            Msgs.DeleteRecipe recipe
    in
        div [ class "m3" ]
            [ h1 [] [ text recipe.name, a [href recipesPath][i [ class "fa fa-trash-o ml2 red", onClick message] [] ]]
            , formLevel recipe
            ]


formLevel : Recipe -> Html Msg
formLevel recipe =
    div
        [ class "clearfix py1"]
        [ div [class "italic"] [text recipe.ingredients]
        , div [] [text recipe.description]
        ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href recipesPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "Oppskrifter" ]        