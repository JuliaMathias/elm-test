module Main exposing (Model, Msg(..), init, main, update, view, viewInput, viewValidation)

import Browser
import Char exposing (isDigit, isLower, isUpper)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if model.password == model.passwordAgain then
        div [ style "color" "green" ] [ text "OK" ]

    else if String.any isDigit model.password == False then
        div [ style "color" "red" ] [ text "Password must contain digits" ]

    else if String.any isUpper model.password == False then
        div [ style "color" "red" ] [ text "Password must contain uppercase" ]

    else if String.any isLower model.password == False then
        div [ style "color" "red" ] [ text "Password must contain lowercase" ]

    else if String.length model.password < 8 then
        div [ style "color" "red" ] [ text "Passwords need to be 8 characters or longer" ]

    else
        div [ style "color" "red" ] [ text "Passwords do not match!" ]
