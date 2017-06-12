module Recipes.Add exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Routing exposing (recipesPath, addRecipePath)
import Msgs exposing (Msg)

view : Html Msg
view =
    div [][
    nav,
    header,
    form]

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [a [ class "left p2 white", href recipesPath ] [ text "Oppskrifter" ],
         a [ class "left p2 white", href addRecipePath ] [ text "Legg til oppskrift" ]
        ]
header : Html Msg
header =
        div [class"h2 m2"][text "Legg til"]

form : Html Msg
form =
    div [class "clearfix"][
        div[class "col col-2 m2"]
            [input [ class "input", type_ "text", placeholder "Navn", onInput Msgs.Name ] []
            , input [ class "input", type_ "text", placeholder "Ingredienser", onInput Msgs.Ingredients ] []
            , input [ class "input", type_ "text", placeholder "Framgangsmåte", onInput Msgs.Description ] []
            , a [class "btn regular btn-outline", href recipesPath, onClick Msgs.AddRecipe][text "Lagre"] ]
        
        , div[class "col col-6"][]]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href recipesPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "Oppskrifter" ]        