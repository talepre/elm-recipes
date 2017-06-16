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
    div [ class "list"]
        [ header
        , nav model
        , maybeList model.recipes model
        ]

header : Html Msg
header =
    div [ class "header header-line"]
    [text "Oppskrifter"]

nav : Model -> Html Msg
nav model =
    div [ class "navigation" ]
        [searchField model,
         a [ class "nav-link", href addRecipePath] [ text "Legg til oppskrift" ]
        ]

searchField : Model -> Html Msg
searchField model = 
    span[][
        input [ class "searchField"
            , placeholder "Søk... "
            , value model.query
            , onInput Msgs.Query
            , autofocus True] []]

maybeList : WebData (List Recipe) -> Model -> Html Msg
maybeList response model =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success recipes ->
            list recipes model.query

        RemoteData.Failure error ->
            text (toString error)


list : List Recipe -> Query -> Html Msg
list recipes query =
    let
        filterRecipes =
            List.filter (\r -> (String.contains (String.toLower query) (String.toLower r.name))) recipes
    in
        div [class "recipes"](List.map recipeBox filterRecipes)
        
            

recipeBox : Recipe -> Html Msg
recipeBox recipe =
    span [class "recipe-box"]    
            [ a [ class "recipe-header", href (recipePath recipe.id) ] [ text recipe.name]
            , div [class "recipe-description"] [ text recipe.description ]
            ]
            
