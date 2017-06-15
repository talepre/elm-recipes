module Recipes.Add exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Routing exposing (recipesPath, addRecipePath)
import Msgs exposing (Msg)
import Models exposing (Model, NewRecipe, IngredientInfo)

view : Model -> Html Msg
view model =
    div [][
    nav,
    header,
    form model.newRecipe]

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-olive" ]
        [a [ class "left p2 white", href recipesPath ] [ text "Oppskrifter" ],
         a [ class "left p2 white", href addRecipePath ] [ text "Legg til oppskrift" ]
        ]
header : Html Msg
header =
        div [class"h2 m2"][text "Legg til"]

form : NewRecipe -> Html Msg
form newRecipe =
    div [class "clearfix"][
        div[class "col col-3 m2"]
            [input [ class "input", type_ "text", placeholder "Navn", onInput Msgs.Name ] []
            , input [ class "input", type_ "text", placeholder "Beskrivelse", onInput Msgs.Description ] []
            , div [ class "btn regular btn-outline olive col-12", onClick Msgs.AddIngredientNewRecipe ][text "Legg til ingrediens"]
            , div [] (List.map (addInputField (List.length newRecipe.ingredients)) newRecipe.ingredients)
            , input [ class "input", type_ "text", placeholder "Framgangsmåte" ] []
            , a [class "btn regular btn-outline olive col-12", href recipesPath, onClick Msgs.AddRecipe][text "Lagre"] ]
        
        , div[class "col col-6"][]]

addInputField : Int -> IngredientInfo -> Html Msg
addInputField ingredientNumber ingredientInfo = 
    div [][
    input[class "col-4", type_ "text", placeholder "Mengde", onInput (Msgs.Amount ingredientNumber)][],
    input[class "col-4", type_ "text", placeholder "Benevning", onInput (Msgs.UnitId ingredientNumber)][],
    input[class "col-4", type_ "text", placeholder "Ingrediens", onInput (Msgs.IngredientId ingredientNumber)][]]

listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href recipesPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "Oppskrifter" ]        