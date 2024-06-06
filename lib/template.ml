open Dream_html
open HTML

let sf = Printf.sprintf
let preview_amount = 3
let link_item title link = a [ href link ] [ txt title ] :: [ br [] ]

let rec take n l =
  match l with
  | [] -> []
  | x :: xs -> if n = 0 then [] else x :: take (n - 1) xs

let post_card title image name order =
  let delay = sf "%ims" (order * 100) in
  article
    [
      class_ "animate__animated animate__fadeInLeft";
      style_ "display: flex; align-items: center; animation-delay: %s;" delay;
      Hx.boost true;
    ]
    [
      img
        [
          src image;
          style_ "max-width: 20%%; margin-right: 8px; border-radius: 8px;";
        ];
      a
        [ href "/posts/%s" name ]
        [ b [ style_ "max-width: 70%%" ] [ txt title ] ];
    ]

let posts =
  [
    post_card "Building a Lambda Calculus Interpreter with .NET Interop"
      "/posts/dotnet square.jpg" "dotnet_interp" 1;
    post_card "A RISCV Implementation of the Tiger Compiler"
      "/posts/tigerhead.jpg" "tiger_compiler" 2;
    post_card "Modern Languages to Carry the Flame of Standard ML"
      "/posts/poly.jpg" "modern_sml" 3;
    post_card "Text Prediction Using Gzip and K-Nearest Neighbors"
      "/posts/knn.png" "gzip_knn" 4;
  ]

let links =
  [
    link_item "Composable Error Handling in OCaml"
      "https://keleshev.com/composable-error-handling-in-ocaml";
    link_item "F# Falco" "https://www.falcoframework.com/";
    link_item "hypermedia.systems" "https://hypermedia.systems/book/contents/";
    link_item "Sergey Tihon's Blog" "https://sergeytihon.com/fsharp-weekly/";
  ]

let posts_content =
  div []
  @@ [ section [] [ h4 [] [ txt "What I've been up to..." ] ]; hr [] ]
  @ posts

let links_content =
  div []
  @@ [
       section [] [ h4 [] [ txt "Some links I've found interesting..." ] ];
       hr [];
     ]
  @ List.concat links

let about_content =
  div []
    [
      section []
        [
          h4 [] [ txt "About" ];
          p []
            [
              txt
                "I'm Brody Little, a software developer from Michigan. I'm \
                 currently working at Gainwell Technologies.";
            ];
        ];
      section [] [ h4 [] [ txt "Timeline" ]; p [] [ txt "..." ] ];
      section [] [ h4 [] [ txt "CV" ]; p [] [ txt "..." ] ];
    ]

let home_content =
  [
    br [];
    br [];
    h4 []
      [
        txt
          "I'm Brody, a software developer specializing in .NET, functional \
           programming, and language design.";
      ];
    br [];
    br [];
    section [] [ small [] [ txt "what i've been working on" ] ];
    hr [];
  ]
  @ take preview_amount posts
  @ [ a [ style_ "float:right"; href "/posts" ] [ small [] [ txt "more" ] ] ]
  @ [ br []; br []; section [] [ small [] [ txt "some links" ] ]; hr [] ]
  @ (take preview_amount links |> List.concat)
  @ [ a [ style_ "float:right"; href "/links" ] [ small [] [ txt "more" ] ] ]

let layout main_content =
  Dream_html.respond
  @@ html
       [ lang "en" ]
       [
         head []
           [
             title [] "brdo";
             script [ src "https://unpkg.com/htmx.org@1.9.11" ] "";
             meta [ charset "utf-8" ];
             meta
               [
                 name "viewport"; content "width=device-width, initial-scale=1";
               ];
             meta [ name "color-scheme"; content "light dark" ];
             link [ rel "icon"; href "/favicon.png" ];
             link
               [
                 rel "stylesheet";
                 href
                   "https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.classless.zinc.min.css";
               ];
             link
               [
                 rel "stylesheet";
                 href
                   "https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css";
               ];
             link
               [
                 rel "stylesheet";
                 href
                   "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css";
               ];
           ];
         meta [ charset "utf-8" ];
         body []
           [
             header []
               [
                 nav
                   [ Hx.boost true ]
                   [
                     ul []
                       [
                         li []
                           [
                             a
                               [ href "/" ]
                               [
                                 strong []
                                   [
                                     span
                                       [ style_ "color:#c1208b;" ]
                                       [ txt ~raw:true "&lambda;" ];
                                     txt "brdo";
                                   ];
                               ];
                           ];
                       ];
                     ul []
                       [
                         li [] [ a [ href "/about" ] [ txt "About" ] ];
                         li [] [ a [ href "/posts" ] [ txt "Posts" ] ];
                         li [] [ a [ href "/links" ] [ txt "Links" ] ];
                       ];
                   ];
               ];
             main
               [
                 id "content";
                 style_ "max-width: 660px; min-height:calc(100vh - 200px) ";
               ]
               main_content;
             footer
               [ style_ "text-align:center" ]
               [
                 a
                   [ href "mailto:brodylittle011@gmail.com" ]
                   [
                     i
                       [ style_ "padding:8px" ]
                       [
                         span
                           [ style_ "color:#c1208b;" ]
                           [ txt ~raw:true "&lambda;" ];
                       ];
                   ];
                 a
                   [ href "https://github.com/bord-o" ]
                   [
                     i [ style_ "padding:8px"; class_ "fa-brands fa-github" ] [];
                   ];
               ];
           ];
       ]
