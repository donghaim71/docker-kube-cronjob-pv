# docker-test
```
1. dockerization of spring boot application
2. k8s pod
3. k8s pv, pvc
```


# run configuration
```
-Dapp.home=logs
-Dspring.profiles.active=local
```


# grade 빌드
```
./gradlew build -x test
```


# Dockerfile 설정
```
FROM adoptopenjdk/openjdk8

VOLUME /tmp

COPY build/libs/docker-test-0.0.1-SNAPSHOT.jar docker-test.jar

ENTRYPOINT ["java","-jar","-Dspring.profiles.active=local", "-Dapp.home=logs", "docker-test.jar"]
```


# Docker 빌드 명령어 
```
(명령어 마지막에 . 붙여야 함)

상대 경로
docker build -t docker-example:0.0.1 -f Dockerfile .

절대 경로
docker build -t docker-example:0.0.1 -f /Users/dinghaim/Documents/workspace-spring-tool-suite-4-4.14.0.RELEASE/docker-test/Dockerfile .
```


# k8s 이미지 배포
```
docker desktop의 kubernetes 일 경우 로컬 이미지 바로 사용 가능

kubectl run name --image=<image>:<tag>

kubectl run docker-example --image=docker-example:0.0.1
```

# k8s pod 확인
```
kubectl get pod

kubectl exec -it docker-example -- bin/bash

pod 삭제 명령어: kubectl delete pods docker-test

exit
```

# k8s cronjob
```
kubectl create -f cronjob.yml

kubectl get pod

container image 못가져 올 경우 STATUS: ErrImagePull

cronojob 삭제 명령어: kubectl delete cronjob docker-test-batch


kubectl 설정 파일에 command 명령어 설정할 경우 Dockerfile의 command 동작 안함 
```

# k8s pv, pvc
> ##### pv, pvc 생성, 조회
```
kubectl create -f pv.yml
kubectl create -f pvc.yml
kubectl get pv
kubectl get pvc
```

> ##### pv 삭제 명령어 
```
kubectl patch pv &lt;pv_name&gt; -p '{"metadata": {"finalizers": null}}'
kubectl delete pv &lt;pv_name&gt; --grace-period=0 --force
kubectl patch pv test-pv -p '{"metadata": {"finalizers": null}}'
kubectl delete pv test-pv --grace-period=0 --force
```




# docker for MacOS directory 탐색 명령어
```
가상 머신 경로 확인:

docker run --rm -it -v /:/vm-root alpine:edge ls -l /vm-root 

가상 머신 내부로 진입: 

docker run --rm -it -v /:/vm-root alpine:edge bin/sh

cd vm-root

(참조: https://forums.docker.com/t/host-path-of-volume/12277)
```


# 참조 url
```
https://medium.com/geekculture/docker-basics-and-easy-steps-to-dockerize-spring-boot-application-17608a65f657

https://kanoos-stu.tistory.com/25?category=1019118

https://blog.knoldus.com/how-to-create-pv-and-pvc-in-kubernetes/

https://jmholly.tistory.com/entry/쿠버네티스-pv-pvc-완전히-삭제하는-방법-terminating-해결

https://forums.docker.com/t/host-path-of-volume/12277
```
