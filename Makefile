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
	docker-compose run --rm discovery doctor
	docker-compose run --rm imserver doctor

destry:
	docker-compose rm -a -f

clean: clean-pyc
	rm -rf build

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

fetch:
	test -d build/imserver || git clone --depth=1 https://github.com/bopo/goim.git build/imserver
	test -d build/discovery || git clone --depth=1 https://github.com/bopo/discovery.git build/discovery

build: fetch
	cd build/imserver && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 make build
	cp -R build/imserver/target compose/imserver/standard
	docker build ./compose/imserver -t imserver:standard
	
	cd $(CWD)

	cd build/discovery && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 make build
	cp -R build/discovery/target compose/discovery/standard	
	docker build ./compose/discovery -t discovery:standard

docs: 
	cd project/app && mkdocs build && cd -

stop: 
	docker-compose stop

start: 
	docker-compose start

setup: build
	docker-compose up -d

restart: 
	docker-compose restart

# DO NOT DELETE
