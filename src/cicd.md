Полезные ссылки:
- https://docs.gitlab.com/ee/ci/yaml/index.html 



stages:
  - build
  - codestyle
  - tests
  - deploy

Build:
  stage: build 
  tags:
    - myrebean
  script:
    - cd src/cat
    - make s21_cat
    - cd ../grep
    - make s21_grep
  artifacts:
    paths:
      - src/cat/s21_cat
      - src/grep/s21_grep
    expire_in: 30 days

Codestyle:
  stage: codestyle
  tags:
    - myrebean
  script:
    - clang-format -n src/cat/*.c
    - clang-format -n src/grep/*.c

Tests:
  stage: tests
  tags:
    - myrebean
  script:
    - cd src/cat
    - make test
    - cd ../grep
    - make test

Deploy:
  stage: deploy
  tags: 
    - myrebean
  when: manual
  script:
    - cd src
    - chmod 777 copy.sh
    - chmod 777 expect.sh
    - ./expect.sh
