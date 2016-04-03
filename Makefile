

build:
	@rm -rf public/*
	@hugo -D

push:
	@rm -rf public/*
	@hugo -D
	@./push.sh
