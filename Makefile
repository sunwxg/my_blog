

build:
	@rm -rf public/*
	@hugo -D

push:
	@./push.sh
