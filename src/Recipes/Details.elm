module Recipes.Details exposing (..)

import Html.Attributes exposing (class, value, href)
import Routing exposing (recipesPath)
import Html.Events exposing (onClick)
import Html exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model, Recipe, RecipeId, Ingredient, IngredientId, IngredientInfo, DisplayIngredientInfo, Unit, UnitId)
import RemoteData exposing (WebData)

view : Recipe -> Model -> Html Msg
view recipe model =
    let
        recipeIngredients =
            List.map (getDisplayInfo model) recipe.ingredients 
    in
        div []
            [ nav
            , details recipe recipeIngredients
            ]

getDisplayInfo : Model -> IngredientInfo -> DisplayIngredientInfo
getDisplayInfo model ingredientInfo =
    let
        ingredientText = maybeIngredient ingredientInfo.ingredientId model.ingredients
        unitText = maybeUnit ingredientInfo.unitId model.units
        amountText = (toString ingredientInfo.amount)
    in
        { ingredient = ingredientText
        , unit = unitText
        , amount = amountText
        }
            
maybeIngredient : IngredientId -> WebData (List Ingredient) -> String
maybeIngredient ingredientId response =
    case response of
        RemoteData.NotAsked ->
            ""

        RemoteData.Loading ->
            "Loading..."

        RemoteData.Success ingredients ->
            String.concat (getIngredientName ingredientId ingredients)

        RemoteData.Failure error ->
            (toString error)

getIngredientName : IngredientId -> List Ingredient -> List String
getIngredientName ingredientId ingredients = 
    List.filterMap (ingredientName ingredientId) ingredients

ingredientName : IngredientId -> Ingredient -> Maybe String
ingredientName ingredientId ingredient =
    if ingredientId == ingredient.id then
        Just ingredient.name
    else
        Nothing

maybeUnit : UnitId -> WebData (List Unit) -> String
maybeUnit unitId response =
    case response of
        RemoteData.NotAsked ->
            ""

        RemoteData.Loading ->
            "Loading..."

        RemoteData.Success units ->
            String.concat (getUnitName unitId units)

        RemoteData.Failure error ->
            (toString error)

getUnitName : UnitId -> List Unit -> List String
getUnitName unitId units = 
    List.filterMap (unitName unitId) units

unitName : UnitId -> Unit -> Maybe String
unitName unitId unit =
    if unitId == unit.id then
        Just unit.name
    else
        Nothing   

nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-olive p1" ]
        [ listBtn ]


details : Recipe -> List DisplayIngredientInfo -> Html Msg
details recipe ingredients =
    let
        deleteMsg =
            Msgs.DeleteRecipe recipe
        description =
            recipe.description
        directions =
            recipe.directions
    in
        div [ class "m3" ]
            [ h1 [] [ text recipe.name, a [href recipesPath][i [ class "fa fa-trash-o ml2 red", onClick deleteMsg] [] ]]
            , descriptionBox description
            , ingredientList ingredients
            , directionBox directions
            ]

ingredientList : List DisplayIngredientInfo -> Html Msg
ingredientList ingredients =
    div [](List.map ingredientLine ingredients)

ingredientLine : DisplayIngredientInfo -> Html Msg
ingredientLine ingredientInfo =
    div [][text (ingredientInfo.amount ++ " " ++ ingredientInfo.unit ++ " " ++ (String.toLower ingredientInfo.ingredient))]
    

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