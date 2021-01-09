all:
	cd chart && helm package hello-world-service/
	mv chart/*.tgz chart/docs/
	helm repo index docs --url https://chandanghosh.github.io/hello-world-service/ --merge chart/docs/index.html
