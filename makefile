build:
	dune build

run:
	dune exec brdocaml --profile=release 0.0.0.0 8080

watch:
	dune exec brdocaml --profile=release --watch 0.0.0.0 8080
		
