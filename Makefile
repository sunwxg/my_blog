

build:
	@rm -rf public/*
	@hugo -D

push:
	@cd public
	@git add .
	@git commit -m"updating"
	git push -u origin master
