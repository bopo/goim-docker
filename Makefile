# Makefile six
CWD=`pwd`

.PHONY: docs clean start build setup

help:
	@echo "setup    - 安装基本依赖(初始化)"
	@echo "fetch    - 更新版本库最新代码"
	@echo "clean    - 清理编译垃圾数据"
	@echo "build    - 编译所需镜像"
	@echo "start    - 开始项目容器"
	@echo "stop     - 停止项目容器"
	@echo "docs     - 构建在线文档"
	@echo "destry   - 销毁项目容器"
	@echo "doctor   - 所有容器自检"
	@echo "restart  - 重启项目容器"

doctor:
	docker-compose run --rm django discovery
	docker-compose run --rm django goim

destry:
	docker-compose rm -a -f

clean: clean-pyc
	rm -rf project/app

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

fetch:
	rm -rf project/app
	cp -R ../server project/app

build:
	test -d build/imserver || git clone --depth=1 https://github.com/bopo/goim.git build/imserver
	cd build/imserver && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 make build
	cp -R build/imserver/target compose/imserver/standard
	docker build ./compose/imserver -t imserver:standard
	
	cd $(CWD)

	test -d build/discovery || git clone --depth=1 https://github.com/bilibili/discovery.git build/discovery
	cd build/discovery/ && GO111MODULE=on CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o cmd/discovery/discovery cmd/discovery/main.go
	cp -R build/discovery/cmd/discovery compose/discovery/standard
	docker build ./compose/discovery -t discovery:standard

docs: 
	cd project/app && mkdocs build && cd -

stop: 
	docker-compose stop

start: 
	docker-compose start

setup: build
	docker-compose up -d
	docker-compose run --rm django python3 manage.py migrate
	docker-compose run --rm django python3 manage.py createsuperuser
	docker-compose run --rm django python3 manage.py collectstatic --no-input

restart: 
	docker-compose restart

# DO NOT DELETE
