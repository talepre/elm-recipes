module Recipes.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, placeholder, value, autofocus)
import Html.Events exposing (onInput)
import Msgs exposing (Msg)
import Models exposing (Recipe, Model, Query)
import RemoteData exposing (WebData)
import Routing exposing (recipePath, recipesPath, addRecipePath)


view : Model-> Html Msg
view model =
    div []
        [ nav
        , maybeList model.recipes model
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 bg-olive" ]
        [a [ class "left p2 white", href recipesPath ] [ text "Oppskrifter" ],
         a [ class "left p2 white", href addRecipePath ] [ text "Legg til oppskrift" ]
        ]

maybeList : WebData (List Recipe) -> Model -> Html Msg
maybeList response model =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success recipes ->
            list recipes model

        RemoteData.Failure error ->
            text (toString error)


list : List Recipe -> Model -> Html Msg
list recipes model =
    div[][
        div [class "clearfix"]
        [input
            [class "mx-auto input col-3"
            , placeholder "Søk... "
            , value model.query
            , onInput Msgs.Query
            , autofocus True] []   
        ], filterList recipes model.query
        ]

filterList : List Recipe -> Query -> Html Msg
filterList recipes query =
    let
        filterRecipes =
            List.filter (\r -> (String.contains (String.toLower query) (String.toLower r.name))) recipes
    in
        div [ class "flex flex-wrap"](List.map recipeBox filterRecipes)
        
            

recipeBox : Recipe -> Html Msg
recipeBox recipe =
    div [ class "col-4 p2" ]
        [ div [class "overflow-hidden border border-olive"]    
            [ div [class "caps bold bg-olive white"] [ text recipe.name]
            , div [] [ text recipe.description ]
            , div [] [ detailBtn recipe ]
            ]
            
        ]
    

detailBtn : Recipe -> Html.Html Msg
detailBtn recipe =
    let
        path =
            recipePath recipe.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ text "Detaljer" ]
