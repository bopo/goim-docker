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
	test -d volumes/discovery/config || mkdir -p volumes/discovery/config
	test -d volumes/imserver/config || mkdir -p volumes/imserver/config

	cp scripts/discovery/* build/discovery/
	cd build/discovery && make build
	cp -R build/discovery/target compose/discovery/standard	
# 	cp -R build/discovery/target/config volumes/discovery/	
	docker build ./compose/discovery -t discovery:standard

	cd $(CWD)

	cp scripts/imserver/* build/imserver/
	cd build/imserver && make build
	cp -R build/imserver/target compose/imserver/standard
# 	cp -R build/imserver/target/config volumes/imserver/
	docker build ./compose/imserver -t imserver:standard

stop: 
	docker-compose stop

start: 
	docker-compose start

setup: build
	docker-compose up -d

restart: 
	docker-compose restart

# DO NOT DELETE
