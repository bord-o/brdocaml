let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html

let run interface port =
  Dream.run ~interface ~port @@ Dream.logger
  @@ Dream.router
       [
         Dream.get "/" (fun _ -> Template.layout Template.home_content);
         ( Dream.get "/posts/:name" @@ fun req ->
           let f = Dream.param req "name" in
           (Dream.from_filesystem "wwwroot/posts" f) req );
         ( Dream.get "/:name" @@ fun req ->
           let f = Dream.param req "name" in
           (Dream.from_filesystem "wwwroot/" f) req );
       ]
