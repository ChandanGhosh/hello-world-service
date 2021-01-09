all:
	cd chart && helm package hello-world-service/
	helm repo index --url https://chandanghosh.github.io/hello-world-service/ .