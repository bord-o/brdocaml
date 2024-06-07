type post = { name : string; html : string }

let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html

let posts =
  let dir = "./wwwroot/posts/" in
  let files =
    Sys.readdir dir |> Array.to_list
    |> List.filter (fun fi -> Filename.extension fi = ".html")
  in
  let read f = In_channel.with_open_text (dir ^ f) In_channel.input_all in
  files |> List.map (fun fi -> { name = fi; html = read fi })

let find_posts req =
  let name = Dream.param req "name" in
  Dream.log "+ Looking for %s.html" name;
  let post = posts |> List.find (fun p -> p.name = name ^ ".html") in
  Template.layout [ Dream_html.txt ~raw:true "%s" post.html ]

let run interface port certificate_file key_file =
  Dream.run ~tls:true ~interface ~port ~certificate_file ~key_file
  @@ Dream.logger
  @@ Dream.router
       [
         Dream.get "/" (fun _ -> Template.layout Template.home_content);
         Dream.get "/about" (fun _ ->
             Template.layout [ Template.about_content ]);
         Dream.get "/links" (fun _ ->
             Template.layout [ Template.links_content ]);
         Dream.get "/posts" (fun _ ->
             Template.layout [ Template.posts_content ]);
         (Dream.get "/posts/:name" @@ fun req -> find_posts req);
         (* For the static files *)
         ( Dream.get "/posts/images/:name" @@ fun req ->
           let f = Dream.param req "name" in
           (Dream.from_filesystem "wwwroot/posts/images" f) req );
       ]
