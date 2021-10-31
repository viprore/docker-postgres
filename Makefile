current_branch := HEAD
build:
	docker build -t viprore/cluster-base:$(current_branch) ./base
	docker build -t viprore/cluster-control:$(current_branch) ./control

