all:
	cd chart && helm package hello-world-service/
	mv chart/*.tgz chart/docs
	helm repo index --url https://chandanghosh.github.io/hello-world-service/ ./chart/docs
